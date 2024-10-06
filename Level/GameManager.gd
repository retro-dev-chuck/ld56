class_name GameManager extends Node2D

@onready var level_loader: LevelLoader = $LevelLoader
@export var save_path: String = "user://save_game.tres"
var save: SaveData = null
var current_amount: int = 0
func  _ready() -> void:
	load_game()
	level_loader.load_level(save.current_level)
	
func save_game() -> void:
	var error = ResourceSaver.save(save, save_path)
	if error == OK:
		print("Game saved successfully!")
	else:
		print("Failed to save the game. Error code: ", error)

func load_game() -> void:
	var data = ResourceLoader.load(save_path)
	if data:
		save = data as SaveData
	else:
		print("Failed to load the game.")
		save = SaveData.new()
		save_game()

func increase_amount() -> void:
	current_amount += 1
	if current_amount == level_loader.current_level.data.goal_amount:
		level_loader.current_level.finished()

func level_finished():
	print("nice")
