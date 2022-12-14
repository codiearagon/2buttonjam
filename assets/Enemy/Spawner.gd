extends Node2D

export var enemy_to_spawn: PackedScene
export var spawn_rate: float = 5

var spawn_timer

func _ready():
	self.add_to_group("Spawners")
	spawn_timer = $Spawn_Rate
	spawn_timer.wait_time = spawn_rate

func spawn():
	var new_enemy = enemy_to_spawn.instance()
	new_enemy.add_to_group("Enemies")
	new_enemy.position = global_position
	get_parent().add_child(new_enemy)

func _on_Spawn_Rate_timeout() -> void:
	spawn()

func start():
	$Spawn_Rate.start()

func stop():
	$Spawn_Rate.stop()
