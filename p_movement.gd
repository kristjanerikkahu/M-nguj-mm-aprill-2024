extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _timer_floor_coyote : Timer = $Timers/FloorCoyote
@onready var _timer_jump_buffer : Timer = $Timers/JumpInputBuffer
@onready var _attack_indicator : Node2D = $AttackIndicator

var _floor_coyote : bool = true
var _jump_input_in_buffer : bool = false

@export var acceleration_time = 0.1
@export var jump_height = 5
@export var move_speed = 10

# Handles mostly the movement, avoid checking anything else but movement here
func _physics_process(delta) -> void:
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

func _handle_jump() -> void:
	_buffer_jump_input()
	if _jump_input_in_buffer and _floor_coyote:
		_timer_jump_buffer.stop()
		_jump_input_in_buffer = false
		_floor_coyote = false
		velocity.y = -sqrt(2 * gravity * abs(jump_height))

func _buffer_jump_input() -> void:
	if Input.is_action_just_pressed("move_jump"):
		_jump_input_in_buffer = true
		_timer_jump_buffer.start()
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
