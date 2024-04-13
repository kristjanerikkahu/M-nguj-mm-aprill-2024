extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _timer_floor_coyote : Timer = $Timers/PlatformTimers/Coyote
@onready var _timer_jump_buffer : Timer = $Timers/PlatformTimers/JumpBuffer
@onready var _timer_dash : Timer = $Timers/AbilityTimers/DashTimer
@onready var _timer_dash_buffer : Timer = $Timers/PlatformTimers/DashBuffer

var _floor_coyote : bool = true
var _jump_input_in_buffer : bool = false
var _dash_input_in_buffer : bool = false

# TODO: Configure movement and jump height
@export var acceleration_time = 0.1
@export var jump_height = 60
@export var move_speed = 100

# TODO: Configure dash length
@export var dash_lengh : int = 100
var _dashing : bool = false
var _can_dash : bool = true
var _dash_direction : Vector2

# Handles mostly the movement, avoid checking anything else but movement here
func _physics_process(delta) -> void:
	_handle_dash()
	if not _dashing:
		_handle_gravity_and_coyote(delta)
		_handle_jump()
		_handle_left_right_movement(delta)

	move_and_slide()

#region Movement functions
#region Up & Down, Jump buffering
func _handle_gravity_and_coyote(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if _timer_floor_coyote.is_stopped:
			_timer_floor_coyote.start()
	else:
		_floor_coyote = true
		_timer_floor_coyote.stop()
		_can_dash = true

# TODO: Configure jumping to feel snappier
func _handle_jump() -> void:
	_buffer_jump_input()
	if _jump_input_in_buffer and _floor_coyote:
		_timer_jump_buffer.stop()
		_jump_input_in_buffer = false
		_floor_coyote = false
		velocity.y = -sqrt(2 * gravity/2 * abs(jump_height))

func _buffer_jump_input() -> void:
	if Input.is_action_just_pressed("move_jump"):
		_jump_input_in_buffer = true
		_timer_jump_buffer.start()

func _buffer_dash_input() -> void:
	if Input.is_action_just_pressed("move_dash"):
		_dash_input_in_buffer = true
		_timer_dash_buffer.start()

func _handle_dash() -> void:
	_buffer_dash_input()
	if _can_dash and _dash_input_in_buffer:
		_dashing = true
		_dash_direction = (get_global_mouse_position() - position).normalized()
		_can_dash = false
		_timer_dash.start()
		
	if _dashing:
		# TODO: Ease out dash
		velocity = _dash_direction * (dash_lengh / _timer_dash.wait_time)
	
#endregion

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

# Timer timeouts
func _on_coyote_timeout():
	_floor_coyote = false

func _on_jump_buffer_timeout():
	_jump_input_in_buffer = false

func _on_dash_timer_timeout():
	_dashing = false
	velocity = Vector2.ZERO


func _on_dash_buffer_timeout():
	_dash_input_in_buffer = false
