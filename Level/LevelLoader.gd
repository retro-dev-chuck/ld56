class_name LevelLoader extends Node2D

@export var parent_node: Node2D
var current_level: Level = null
		
func load_level(level: int) -> void:
	unload_level()
	var path: String = "res://Levels/Level_%s.tscn" % str(level)
	var res: PackedScene = load(path)
	if res:
		current_level = res.instantiate() as Level
		parent_node.add_child(current_level)
	
func unload_level():
	if current_level:
		current_level.queue_free()
