
extends Area2D

@export var destination: Vector2 = Vector2(10.56, -767.2)

@onready var portal_sprite: Sprite2D = $Sprite2D

var outro_started: bool = false

func _ready() -> void:
	portal_sprite.visible = not Lever.is_activated

func _process(_delta: float) -> void:
	if Lever.is_activated:
		portal_sprite.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name != "LockSmith":
		return

	if not Lever.is_activated:
		print("Portal locked! Activate the lever first.")
		return

	if outro_started:
		return

	outro_started = true
	print("Portal activated! Playing outro animation.")

	get_tree().change_scene_to_file("res://Outro.tscn")
