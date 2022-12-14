extends Node2D

export var enemy_to_spawn: PackedScene
export var spawn_rate: float

var spawn_timer

func _ready():
	spawn_timer = $Spawn_Rate
	spawn_timer.wait_time = spawn_rate
	spawn_timer.start()

func spawn():
	var new_enemy = enemy_to_spawn.instance()
	new_enemy.position = global_position
	get_parent().add_child(new_enemy)

func _on_Spawn_Rate_timeout() -> void:
	spawn()
