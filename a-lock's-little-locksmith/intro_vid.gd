
extends Node2D

@onready var frame: AnimatedSprite2D = $Sprite2D/AnimatedSprite2D2

func _ready() -> void:
	frame.animation_finished.connect(_on_animation_finished)
	frame.play("default")

func _on_animation_finished() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
