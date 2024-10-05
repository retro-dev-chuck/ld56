class_name WindowResizer extends Node

@export var window_width: int = 512
@export var window_height: int = 512
func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(window_width, window_height))
