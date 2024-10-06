class_name GameManager extends Node2D
@onready var animation_player: AnimationPlayer = $Load/AnimationPlayer

@onready var level_loader: LevelLoader = $LevelLoader
@export var save_path: String = "user://save_game.tres"
@onready var target_ui: TargetUi = $TargetUi
@onready var thanks: CanvasLayer = $Thanks

var save: SaveData = null
var current_amount: int = 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Delete"):
		delete_save()

func  _ready() -> void:
	load_game()
	level_loader.unload_level()
	await get_tree().create_timer(0.3).timeout
	if level_loader.load_level(save.current_level):
		target_ui.target_label.text = "Target: " + str(current_amount) +"/" + str(level_loader.current_level.data.goal_amount)
	else:
		target_ui.target_label.text = ""
		thanks.visible = true

func delete_save() -> void:
	save = SaveData.new()
	save_game()
	transition()
	
		
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
		save = SaveData.new()
		save_game()

func increase_amount() -> void:
	current_amount += 1
	if current_amount > level_loader.current_level.data.goal_amount:
		return
	if current_amount == level_loader.current_level.data.goal_amount:
		level_loader.current_level.finished()
		target_ui.target_label.text = "Go to portal"
	else:
		target_ui.target_label.text = "Target: " + str(current_amount) +"/" + str(level_loader.current_level.data.goal_amount)

func level_finished():
	save.current_level += 1
	current_amount = 0
	target_ui.target_label.text = "Target: " + str(current_amount) +"/" + str(level_loader.current_level.data.goal_amount)
	save_game()
	transition()
	
func transition():
	animation_player.play("scale")
	await animation_player.animation_finished
	level_loader.unload_level()
	await get_tree().create_timer(0.3).timeout
	if level_loader.load_level(save.current_level):
		target_ui.target_label.text = "Target: " + str(current_amount) +"/" + str(level_loader.current_level.data.goal_amount)
	else:
		target_ui.target_label.text = ""
		thanks.visible = true
	await get_tree().create_timer(0.3).timeout
	animation_player.play("scale_back")
	
