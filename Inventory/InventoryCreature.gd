class_name InventoryCreature extends Node2D

signal on_amount_updated(current: int, max: int)

@export var creatures: Array[CreatureInventoryData] = []
@export var max_amount: int = 9001
@onready var suck_area: SuckArea = $"../Visual/SuckArea"

var total_amount: int = 0

func _ready() -> void:
	suck_area.on_suck_done.connect(_process_suck)
	
func _process_suck(sucked: Suckable) -> void:
	var creature:Creature = sucked as Creature
	if creature:
		print(creature.data.creatureData.title, " added to inventory")
		add_to_inventory(creature.data)

func add_to_inventory(data: CreatureInventoryData) -> void:
	if total_amount == max_amount:
		return
	var does_exist: bool = false
	for i in range(creatures.size()):
		if creatures[i].creatureData.title == data.creatureData.title:
			if total_amount + data.amount <= max_amount:
				creatures[i].amount += data.amount
				total_amount += data.amount
			else:
				var amount_to_add: int = total_amount + data.amount - max_amount
				creatures[i].amount += amount_to_add 
				total_amount += amount_to_add
			does_exist = true
	if !does_exist:
		var d: CreatureInventoryData = data.duplicate()
		if total_amount + data.amount > max_amount:
			d.amount = total_amount + data.amount - max_amount
			total_amount = max_amount
		else:
			total_amount += d.amount
		creatures.append(d)
		
	for i in range(creatures.size()):
		print(creatures[i].creatureData.title, ":", creatures[i].amount)	
		
func is_full() -> bool:
	return total_amount == max_amount	
