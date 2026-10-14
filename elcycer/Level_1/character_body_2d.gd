extends CharacterBody2D

@export var move_speed : float = 100


func _physics_process(_delta):
	# Collects input from player for main character   
	var input_direction = Vector2(
	Input.get_action_strength("Right") - Input.get_action_strength("Left"),
	Input.get_action_strength("Down") - Input.get_action_strength("Up")
	)
	
	
	# Movement for character 
	velocity = input_direction * move_speed
	
	
	# Makes the main character ACTUALLY move on screen
	move_and_slide()
