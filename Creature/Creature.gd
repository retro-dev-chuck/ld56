class_name Creature extends CharacterBody2D

var is_sucked: bool = false

func _physics_process(delta: float) -> void:
	if !is_sucked:
		pass
	move_and_slide()
