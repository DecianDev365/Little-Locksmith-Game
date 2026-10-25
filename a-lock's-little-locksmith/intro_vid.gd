extends Node2D

func _ready() -> void:
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://main.tscn") ## wait for 15 sec dudess
