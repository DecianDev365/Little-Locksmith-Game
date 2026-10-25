
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jumps_left = 2
var was_on_floor = false
var is_hitting = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	move_and_slide()

	if is_on_floor() and not was_on_floor:
		jumps_left = 2

	was_on_floor = is_on_floor()

	if is_hitting:
		return

	if Input.is_key_pressed(KEY_D):
		play_hit()
		return

	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("JUMP")
		else:
			animated_sprite.play("fall")
	elif abs(velocity.x) > 10:
		animated_sprite.play("WALKING")
	else:
		animated_sprite.play("IDLE")

func play_hit() -> void:
	is_hitting = true
	animated_sprite.play("HIT")
	await animated_sprite.animation_finished
	is_hitting = false
