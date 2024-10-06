class_name SuckArea extends Area2D

@export var pull_strength: float = 500.0 
@export var target_pull_point: Node2D 
@export var center_point: Vector2 
@export var bodies_in_area: Array[PhysicsBody2D] = []
@export var suck_power: int = 1
var is_sucking: bool = false


signal on_suck_done(body: Suckable)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Unsuck"):
		return
	if Input.is_action_pressed("Suck"):
		is_sucking = true
		for body in bodies_in_area:
			apply_gravitational_pull(body, delta)
	else:
		is_sucking = false
		for body in bodies_in_area:
			unset_suck(body)
		

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("affected_by_gravity"): 
		bodies_in_area.append(body)

func _on_body_exited(body: PhysicsBody2D) -> void:
	bodies_in_area.erase(body)

func apply_gravitational_pull(body: PhysicsBody2D, delta: float) -> void:
	var suckable: Suckable = body as Suckable
	if suckable:
		if suck_power < suckable.get_weight():
			return
	center_point = target_pull_point.global_position
	var direction: Vector2 = (center_point - body.global_position).normalized()
	var distance: float = center_point.distance_to(body.global_position)
	var force: Vector2 = direction * (pull_strength / max(distance, 1)) 
	body.is_sucked = true 
	body.velocity += force * delta
	if body.global_position.distance_squared_to(target_pull_point.global_position) < 25:
		body.suction_done()
		on_suck_done.emit(body as Suckable)
		body.queue_free()

func unset_suck(body: CharacterBody2D) -> void:
	body.is_sucked = false
	
