class_name Level extends Node2D
@onready var portal: Portal = $Portal
@export var data: LevelData
var is_finished: bool = false

func _ready() -> void:
	portal.on_player_entered.connect(portal_entered)

func finished() -> void:
	if is_finished:
		return
	is_finished = true
	var tween = portal.create_tween()
	tween.tween_property(portal, "scale", Vector2(1,1), 0.4).set_ease(Tween.EaseType.EASE_IN_OUT)
	tween.play()
	await tween.finished
	portal.enable_portal()

func portal_entered() -> void:
	get_tree().current_scene.level_finished()
