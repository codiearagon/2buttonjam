extends Node2D

func _ready() -> void:
	start_all_spawners()

func start_all_spawners():
	var spawners = get_tree().get_nodes_in_group("Spawners")
	for spawner in spawners:
		spawner.start()
		
func stop_all_spawners():
	var spawners = get_tree().get_nodes_in_group("Spawners")
	for spawner in spawners:
		spawner.stop()
