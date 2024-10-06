class_name Suckable extends CharacterBody2D

signal on_sucked(item: Suckable)
signal on_suck_started()
signal on_suck_stopped()

var title: String = "_"
var is_sucked: bool = false :
	set(value):
		is_sucked = value
		if is_sucked:
			on_suck_started.emit()
		else:
			on_suck_stopped.emit()

func _physics_process(delta: float) -> void:
	if !is_sucked:
		velocity = velocity.move_toward(Vector2.ZERO, 300.0 * delta)
		pass
	move_and_collide(velocity * delta)

func suction_done():
	on_sucked.emit(self)

func get_weight():
	return 0
