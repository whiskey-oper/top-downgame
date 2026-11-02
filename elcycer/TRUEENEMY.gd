extends CharacterBody2D

enum State { PATROL, ATTACK }
var current_state: State = State.PATROL # Default state

@export var speed: float = 80.0
@export var bullet_scene: PackedScene = preload("res://Bullet.tscn") # Load projectile

# Patrol logic variables
@onready var patrol_points = $PatrolPoints.get_children()
var current_point_index: int = 0
var patrol_tolerance: float = 10.0 # Distance check threshold

# Target track variables
var player: CharacterBody2D = null
@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	current_state = State.PATROL

func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL:
			handle_patrol()
		State.ATTACK:
			handle_attack()

func handle_patrol() -> void:
	if patrol_points.size() == 0:
		return
		
	var target_point = patrol_points[current_point_index]
	var direction = global_position.direction_to(target_point.global_position)
	
	velocity = direction * speed
	move_and_slide()
	
	# If close enough to current patrol point, switch to the next point
	if global_position.distance_to(target_point.global_position) < patrol_tolerance:
		current_point_index = (current_point_index + 1) % patrol_points.size()

func handle_attack() -> void:
	# Stop moving while shooting
	velocity = Vector2.ZERO
	move_and_slide()
	
	# Optional: Make the sprite flip towards the player
	if player:
		$Sprite2D.flip_h = (player.global_position.x < global_position.x)

# Connected from DetectionArea (body_entered)
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		current_state = State.ATTACK
		shoot_timer.start() # Start running the shooting cooldown loop

# Connected from DetectionArea (body_exited)
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		current_state = State.PATROL
		shoot_timer.stop() # Stop weapon loops when player flees

# Connected from ShootTimer (timeout)
func _on_shoot_timer_timeout() -> void:
	if player and current_state == State.ATTACK:
		shoot_at_player()

func shoot_at_player() -> void:
	var bullet = bullet_scene.instantiate()
	
	# Assign the bullet spawn coordinates
	bullet.global_position = global_position
	
	# Compute direction path targeting the player
	var dir = global_position.direction_to(player.global_position)
	bullet.direction = dir
	
	# Instance the projectile directly into the main world tree so it doesn't move with the enemy
	get_tree().current_scene.add_child(bullet)


func _on_detectionzone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_detectionzone_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass # Replace with function body.
