extends Node2D

@onready var lever_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_in_range = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "LockSmith":
		player_in_range = true
		print("LockSmith entered lever area")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "LockSmith":
		player_in_range = false
		print("LockSmith exited lever area")

func activate_lever() -> void:
	if player_in_range:
		lever_sprite.play("Lver on")
		print("Lever animation playing")
## And the lever shud most probably work ... Damn this is lot of  work .. I am new to godo btw ;>0
