class_name Suckable extends CharacterBody2D

signal on_sucked(item: Suckable)

var is_sucked: bool = false

func _physics_process(delta: float) -> void:
	if !is_sucked:
		pass
	move_and_slide()

func suction_done():
	on_sucked.emit(self)
