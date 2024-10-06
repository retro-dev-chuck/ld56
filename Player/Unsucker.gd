class_name Unsucker extends Node2D

const CREATURE_MAP = preload("res://Creature/Data/CreatureMap.tres")
@onready var inventory_creature: InventoryCreature = $"../../InventoryCreature"
@export var unsuck_force: int = 225
@export var plop_cd: float = 0.425
@export var unsuck_src_node: Node2D
@export var unsuck_dst_node: Node2D

	
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("Suck"):
		return
	if Input.is_action_just_pressed("Unsuck"):
		_plop()
		
func _plop() -> void:
	if inventory_creature.total_amount > 0:
		for i in range(CREATURE_MAP.all_creatures.size()):
			var c = CREATURE_MAP.all_creatures[i]
			for j in range(inventory_creature.creatures.size()):
				if inventory_creature.creatures[j].creatureData.title == c.key:
					if inventory_creature.creatures[j].amount > 0:
						var plopped: Creature = c.value.instantiate() as Creature
						var direction: Vector2 = get_dir()
						var force: Vector2 = direction * unsuck_force 
						plopped.global_position = unsuck_src_node.global_position
						get_tree().root.add_child(plopped)
						plopped.velocity = force
						inventory_creature.creatures[j].amount -= 1
						inventory_creature.total_amount -= 1

func get_dir() -> Vector2:
	var direction = (unsuck_dst_node.global_position - unsuck_src_node.global_position).normalized()
	return direction
