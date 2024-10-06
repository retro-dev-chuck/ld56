class_name Generator extends Node2D

@export var gen_time: Vector2 = Vector2(4, 15)
@export var maximum: int = 1
@export var item: PackedScene
@onready var touchgrass: TileMapLayer 
@onready var audio_poop: AudioPlayer = $"../AudioPoop"

var does_need_grass: bool = true
var generated_items: Array[Suckable] = []

var timer: Timer


func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(_on_generate_timer_finished)
	add_child(timer)
	timer.one_shot = false
	timer.start(randf_range(gen_time.x, gen_time.y))

func _on_generate_timer_finished() -> void:
	if generated_items.size() >= maximum:
		return
	if does_need_grass && !is_on_grass():
		return
	var new_item = item.instantiate() as Suckable
	new_item.on_sucked.connect(_delete_from_list)
	get_tree().current_scene.get_node("Level").add_child(new_item)
	new_item.global_position = global_position
	generated_items.append(new_item)
	audio_poop.play_better()

func _delete_from_list(i: Suckable) ->void:
	generated_items.erase(i)
	i.on_sucked.disconnect(_delete_from_list)

func is_on_grass() -> bool:
	if touchgrass == null:
		if get_tree().current_scene.get_node("Level"):
			touchgrass = get_tree().current_scene.get_node("Level").get_node("%Touchgrass") as TileMapLayer
		if touchgrass == null:
			return false
	if !is_inside_tree():
		return false
	var map_pos: Vector2 = touchgrass.local_to_map(global_position)
	var type: int = touchgrass.get_cell_tile_data(map_pos).get_custom_data("Type") as int
	return type == 1
