extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jumps_left = 2
var was_on_floor = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	move_and_slide()

	# Reset only when landing after being airborne.
	if is_on_floor() and not was_on_floor:
		jumps_left = 2

	was_on_floor = is_on_floor()
