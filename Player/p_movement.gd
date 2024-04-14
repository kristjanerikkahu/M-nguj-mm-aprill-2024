extends CharacterBody2D
class_name Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var moving : bool = false
var dashing : bool = false

@export var cloud : PackedScene
@export var death_particles : PackedScene
@export var _dash_followup : PackedScene

@onready var _timer_floor_coyote : Timer = $Timers/PlatformTimers/Coyote
@onready var _timer_jump_buffer : Timer = $Timers/PlatformTimers/JumpBuffer
@onready var _timer_dash : Timer = $Timers/AbilityTimers/DashTimer
@onready var _timer_dash_buffer : Timer = $Timers/PlatformTimers/DashBuffer

@onready var _cloud_spawn_position : Marker2D = $CloudSpawn
@onready var _cloud_check_raycast : RayCast2D = $CloudCheck
@onready var _dash_shockwave : Node2D = $DashParticles

var _floor_coyote : bool = true
var _jump_input_in_buffer : bool = false
var _dash_input_in_buffer : bool = false

# TODO: Configure movement and jump height
@export var acceleration_time = 0.1
@export var jump_height = 60
@export var move_speed = 100
@export var wall_climb_speed = 50

# TODO: Configure dash length
@export var dash_lengh : int = 100
var _can_dash : bool = true
var _dash_direction : Vector2
var _dash_end_floating : bool = false

var _can_summon_cloud : bool = true

# Handles mostly the movement, avoid checking anything else but movement here
func _physics_process(delta) -> void:
	_handle_dash()
	if not dashing:
		_handle_gravity_and_coyote(delta)
		_handle_jump()
		_handle_left_right_movement(delta)

	move_and_slide()
	
func _process(_delta) -> void:
	if _can_summon_cloud and Input.is_action_just_pressed("create_cloud") \
	and not is_on_floor():
		summon_cloud()
	
func summon_cloud() -> void:
	var cloud_instance : StaticBody2D = cloud.instantiate()
	cloud_instance.position = _cloud_spawn_position.global_position
	get_tree().current_scene.add_child(cloud_instance)
	_can_summon_cloud = false

# TODO: Send death handling to master script
func die() -> void:
	var death_particles_instance = death_particles.instantiate()
	death_particles_instance.position = global_position
	get_tree().current_scene.add_child(death_particles_instance)
	death_particles_instance.emitting = true
	queue_free()

#region Movement functions
#region Up & Down, Jump, dash
func _handle_gravity_and_coyote(delta) -> void:
	if not is_on_floor():
		# TODO: Wall jump?
		velocity.y += gravity * delta
		if _timer_floor_coyote.is_stopped:
			_timer_floor_coyote.start()
	else:
		_floor_coyote = true
		_timer_floor_coyote.stop()
		_can_dash = true
		# HACK: Prolly a better way to do thiss
		var rc_col = _cloud_check_raycast.get_collider()
		if rc_col and rc_col.owner and rc_col.owner.get_class() != "Cloud":
			_can_summon_cloud = true

# TODO: Configure jumping to feel snappier
func _handle_jump() -> void:
	_buffer_jump_input()
	if _jump_input_in_buffer and _floor_coyote:
		_timer_jump_buffer.stop()
		_jump_input_in_buffer = false
		_floor_coyote = false
		velocity.y = -sqrt(2 * gravity/2 * abs(jump_height))

# TODO: Cancel dash when colliding?
func _handle_dash() -> void:
	_buffer_dash_input()
	if _can_dash and _dash_input_in_buffer:
		_get_dash_dir()
		var followup = _dash_followup.instantiate()
		followup.dir = _dash_direction
		followup.position = global_position
		get_tree().current_scene.add_child(followup)

		var camera2D : Camera2DPlus = $Camera
		camera2D
		
		dashing = true
		_can_dash = false
		_timer_dash.start()
		
	if dashing:
		velocity = _dash_direction * (dash_lengh / _timer_dash.wait_time)
	
#endregion

func _get_dash_dir():
	var x_dir = Input.get_axis("move_left", "move_right")
	var y_dir = Input.get_axis("move_up", "move_down")
	_dash_direction = Vector2(x_dir, y_dir).normalized()
	if _dash_direction.is_equal_approx(Vector2.ZERO):
		_dash_direction = Vector2.LEFT if $Sprite.flip_h else Vector2.RIGHT

func _emit_dash_particles(dir : Vector2):
	_dash_shockwave.rotation = _dash_direction.angle() - PI/2
	_dash_shockwave.toggle_emission()

func _handle_left_right_movement(delta) -> void:
	var direction : float = Input.get_axis("move_left", "move_right")
	var accel_per_frame = (move_speed / acceleration_time) * delta
	if direction:
		velocity.x = move_toward(
			velocity.x, 
			move_speed * direction, 
			accel_per_frame
		)
	else:
		velocity.x = move_toward(
			velocity.x, 
			0, 
			accel_per_frame
		)
#endregion

#region Input Buffers
func _buffer_jump_input() -> void:
	if Input.is_action_just_pressed("move_jump"):
		_jump_input_in_buffer = true
		_timer_jump_buffer.start()

func _buffer_dash_input() -> void:
	if Input.is_action_just_pressed("move_dash"):
		_dash_input_in_buffer = true
		_timer_dash_buffer.start()
#endregion


#region Timer timeouts
func _on_coyote_timeout():
	_floor_coyote = false

func _on_jump_buffer_timeout():
	_jump_input_in_buffer = false

func _on_dash_timer_timeout():
	dashing = false
	velocity.y = clampf(velocity.y, -gravity / 4, INF)
	velocity.x = clampf(velocity.x, -move_speed, move_speed)
	var angle = Vector2.from_angle(_dash_shockwave.rotation)
	
	_dash_shockwave.toggle_emission()

func _on_dash_buffer_timeout():
	_dash_input_in_buffer = false
#endregion
