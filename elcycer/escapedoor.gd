extends StaticBody2D

@export var required_key_id: String = "escape_key"
@export var consume_key: bool = true
@export var next_scene_path: String = "res://scenes/win_screen.tscn"

@onready var door_collider = $CollisionShape2D # Change to $CollisionShape3D for 3D
@onready var trigger_zone = $Area2D # Change to $Area3D for 3D

# dfunc _ready() -> void:
	# trigger_zone.body_entered.connect(_on_trigger_entered)

func _on_trigger_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
		
	# if Global.has_key(required_key_id):
		# if consume_key:
			# Global.remove_key(required_key_id)
		unlock_and_escape()
	else:
		print("Locked! You need the ", required_key_id)

func unlock_and_escape() -> void:
	door_collider.set_deferred("disabled", true)
	
	# Load the victory or next level scene if a path is provided
	if not next_scene_path.is_empty():
		get_tree().call_deferred("change_scene_to_file", next_scene_path)
