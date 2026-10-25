extends Node2D

class_name Lever

static var is_activated: bool = false

@onready var lever_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var lever_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player_in_range = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "LockSmith":
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "LockSmith":
		player_in_range = false


func activate_lever() -> void:
	if player_in_range and not is_activated:
		is_activated = true
		lever_sprite.play("Lver on")
		lever_sound.play()
		print("Lever activated! Portal unlocked.")
