extends CharacterBody2D

#uuuu too slow go faster
@export var move_speed : float = 150


func _physics_process(_delta):
	# Collects input from player for main character   
	var input_direction = Vector2(
	Input.get_action_strength("Right") - Input.get_action_strength("Left"),
	Input.get_action_strength("Down") - Input.get_action_strength("Up")
	)
	# it somehow already works with wasd btw
	
	
	# Movement for character 
	velocity = input_direction * move_speed
	
	
	# Makes the main character ACTUALLY move on screen
	move_and_slide()
# great job daerue
# now i shall take the liberty of enhancing ur already marvellous work
# since ur not here 4 a mysterious reason
# get a gud nite's sleep next time will u?

# BREAKING NEWS: ive done absolutely nothing sowi
# im getting fired
# Reduced cartoon sqwashs.sfx for sean
