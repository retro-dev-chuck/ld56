class_name Creature extends Suckable

@export var data: CreatureInventoryData 

func _ready() -> void:
	title = data.creatureData.title

func get_weight():
	return data.creatureData.weight
