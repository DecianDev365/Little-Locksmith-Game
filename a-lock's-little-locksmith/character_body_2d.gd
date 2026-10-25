extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jumps_left = 2
var was_on_floor = false
var is_hitting = false
var start_position: Vector2
var is_respawning = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var walking_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	start_position = global_position
	walking_sound.finished.connect(_on_walking_sound_finished)

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

	if is_on_floor() and not was_on_floor: ##jumpy jump ;) 
		jumps_left = 2

	was_on_floor = is_on_floor()

	if is_hitting:
		walking_sound.stop()
		return

	if Input.is_key_pressed(KEY_D):
		walking_sound.stop()
		play_hit()
		return

	if not is_on_floor():
		walking_sound.stop()
		if velocity.y < 0:
			animated_sprite.play("JUMP")
		else:
			animated_sprite.play("fall")
	elif abs(velocity.x) > 10:
		animated_sprite.play("WALKING")
		if not walking_sound.playing:
			walking_sound.play()
	else:
		walking_sound.stop()
		animated_sprite.play("IDLE")

func _on_walking_sound_finished() -> void:
	if is_on_floor() and abs(velocity.x) > 10 and not is_hitting and not is_respawning:
		walking_sound.play()

func play_hit() -> void:
	is_hitting = true
	walking_sound.stop()
	animated_sprite.play("HIT")   ## Even playn retro games hit hard uk 
	get_tree().call_group("lever", "activate_lever")
	await animated_sprite.animation_finished
	is_hitting = false

func respawn() -> void:
	if is_respawning:
		return

	is_respawning = true
	walking_sound.stop()
	visible = false
	set_physics_process(false)

	await get_tree().create_timer(0.4).timeout

	global_position = start_position
	velocity = Vector2.ZERO
	jumps_left = 2
	was_on_floor = false
	is_hitting = false

	visible = true
	animated_sprite.play("IDLE")
	set_physics_process(true)
	is_respawning = false

	##Hollow knight is a good game ngl
