class_name Wander extends Node2D

@export var wander_range: Vector2 = Vector2(5, 10)
@export var wait_range: Vector2 = Vector2(4, 10)
@export var suck_rest_range: Vector2 = Vector2(2, 5)
@export var radius: float = 100.0 
@export var speed: Vector2 = Vector2(10, 100)  
@export var character: CharacterBody2D

@onready var suckable: Suckable = $".."
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var target_point: Vector2  
var moving: bool = false
var wait_timer: Timer
var suck_rest_timer: Timer
var center_pt: Vector2

func _ready() -> void:
	center_pt = global_position
	suckable.on_suck_started.connect(suck_started)
	suckable.on_suck_stopped.connect(suck_stopped)
	
	suck_rest_timer = Timer.new()
	wait_timer = Timer.new()
	wait_timer.one_shot = true
	suck_rest_timer.one_shot = true
	
	add_child(suck_rest_timer)
	add_child(wait_timer)
	
	suck_rest_timer.timeout.connect(set_random_target_point)
	wait_timer.timeout.connect(set_random_target_point)
	set_random_target_point()

func _physics_process(delta: float) -> void:
	if suckable.is_sucked:
		return
	if moving:
		move_to_target(delta)

func set_random_target_point() -> void:
	var random_angle = randf_range(0, 2 * PI)  
	var random_distance = randf_range(0, radius)  
	
	var offset = Vector2(cos(random_angle), sin(random_angle)) * random_distance
	target_point = center_pt + offset
	animation_player.play("Walk")
	moving = true
	

func move_to_target(delta: float) -> void:
	var direction = (target_point - center_pt).normalized()
	character.velocity = direction * randf_range(speed.x, speed.y) * delta
	character.move_and_collide(character.velocity)

	if character.global_position.distance_to(target_point) < 1.0:
		animation_player.stop()
		moving = false
		character.velocity = Vector2.ZERO
		wait_timer.start(randf_range(wait_range.x, wait_range.y))

func suck_started() -> void:
	animation_player.stop()
	wait_timer.stop()
	suck_rest_timer.stop()

func suck_stopped() -> void:
	if suck_rest_timer.is_stopped():
		suck_rest_timer.start(randf_range(suck_rest_range.x, suck_rest_range.y))

	
