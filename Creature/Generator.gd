class_name Generator extends Node2D

@export var gen_time: float = 2.0
@export var max: int = 1
@export var item: PackedScene

var generated_items: Array[Suckable] = []

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(_on_generate_timer_finished)
	add_child(timer)
	timer.one_shot = false
	timer.start(gen_time)

func _on_generate_timer_finished() -> void:
	if generated_items.size() >= max:
		return
	var new_item = item.instantiate() as Suckable
	new_item.on_sucked.connect(_delete_from_list)
	get_tree().root.add_child(new_item)
	new_item.global_position = global_position
	generated_items.append(new_item)

func _delete_from_list(i: Suckable) ->void:
	generated_items.erase(i)
	i.on_sucked.disconnect(_delete_from_list)
