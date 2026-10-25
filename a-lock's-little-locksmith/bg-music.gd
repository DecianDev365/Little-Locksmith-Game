extends AudioStreamPlayer2D

func _ready() -> void:
	finished.connect(_on_music_finished)
	play()

func _on_music_finished() -> void: ## shoutout pixabay for the bg music 
	play()
	
	
