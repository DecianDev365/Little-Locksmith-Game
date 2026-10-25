
extends Node2D

@onready var frame: AnimatedSprite2D = find_child("AnimatedSprite2D", true, false) as AnimatedSprite2D

func _ready() -> void:
	if frame == null:
		push_error("Could not find AnimatedSprite2D in Outro scene.")
		return

	frame.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	frame.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
