extends Area2D

@export var key_id: String = "escape_key"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		# Global.add_key(key_id)
		queue_free() # Removes the key from the map after pickup
