extends Area2D

@export var destination: Vector2 = Vector2(22.6 ,-767.200)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("respawn"):
		body.global_position = destination
		body.velocity = Vector2.ZERO
