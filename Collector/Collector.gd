class_name Collector extends Node2D

@onready var container_icon: Sprite2D = $ContainerBack/ContainerFront/ContainerIcon
@onready var animation_player: AnimationPlayer = $ContainerBack/AnimationPlayer

@export var target_title: String = "x"
@export var target: CreatureInventoryData

var correct_amount: int = 0
var wrong_amount: int = 0

func _ready() -> void:
	if target != null:
		target_title = target.creatureData.title
		container_icon.texture = target.texture
	else:
		self.queue_free()
func set_icon(texture: Texture2D) -> void:
	container_icon.texture = texture

func _on_collect_area_body_entered(body: Node2D) -> void:
	var suckable: Suckable = body as Suckable
	if suckable:
		print(suckable.title)
		if suckable.title == target_title:
			animation_player.play("Correct")
			correct_amount += 1
			print("correct")
		else:
			animation_player.play("Wrong")
			print("wrong")
			wrong_amount += 1
