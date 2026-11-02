extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Move the projectile forward over time
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Apply damage logic to the player here
		body.queue_free() # Temporary placeholder logic
	
	queue_free() # Always destroy the bullet on impact
