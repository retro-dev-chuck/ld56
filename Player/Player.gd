extends CharacterBody2D

@export var speed = 300.0
@onready var visual: Sprite2D = $Visual
var prev_x: float = 0
func _physics_process(delta: float) -> void:

	var direction_x := Input.get_axis("Left", "Right")
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var direction_y := Input.get_axis("Up", "Down")
	if direction_y:
		velocity.y = direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	if prev_x <= 0 && velocity.x > 0:
		visual.scale.x = 1
	elif prev_x >= 0 && velocity.x <0:
		visual.scale.x = -1
	prev_x = velocity.x
	move_and_slide()
