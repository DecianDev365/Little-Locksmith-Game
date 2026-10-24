extends AnimatableBody2D

@export var move_distance: float = 48.0
@export var move_speed: float = 4.5


var start_y: float
var time_passed: float = 0.0

func _ready() -> void:
	start_y = position.y

func _physics_process(delta: float) -> void:
	time_passed += delta * move_speed
	position.y = start_y - sin(time_passed) * move_distance
