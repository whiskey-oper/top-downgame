extends Node2D

var keys: Array[String] = []

func add_key(key_id: String) -> void:
	if not keys.has(key_id):
		keys.append(key_id)

func has_key(key_id: String) -> bool:
	return keys.has(key_id)

func remove_key(key_id: String) -> void:
	keys.erase(key_id)
