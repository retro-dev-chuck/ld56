class_name Portal extends Node2D

signal on_player_entered()
var is_portal_used: bool = false
@onready var area_2d: Area2D = $Area2D

func enable_portal() -> void:
	area_2d.monitorable = true
	area_2d.monitoring = true



func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_portal_used: 
		return
	print(body.name)
	if body.is_in_group("player"):
		is_portal_used = true
		on_player_entered.emit()
