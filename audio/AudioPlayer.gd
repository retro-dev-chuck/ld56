class_name AudioPlayer extends AudioStreamPlayer2D

func play_better() -> void:
	pitch_scale = randf_range(0.9, 1.15)
	volume_db = randf_range(-4, 4)
	play()
