extends Node2D

export var timer_max: int = 120

func _ready():
	$Survive_Timer.wait_time = timer_max
	
	$GUI/Events/Start.start()
	$Survive_Timer.start()
	start_all_spawners()
	
func _process(delta: float) -> void:
	if $Survive_Timer.is_stopped() == false:
		var minutes = floor($Survive_Timer.time_left / 60)
		var seconds = floor($Survive_Timer.time_left / (minutes + 1))
		
		$GUI/Timer/Panel/Label.text = str(minutes) + ":" + str(seconds)

func _on_Survive_Timer_timeout() -> void:
	stop_all_spawners()
	
	$Boat/Attack_Rate.stop()
	kill_all_enemy_instances()
		
	$GUI/Events/End.survived("res://assets/Scenes/Level_3.tscn")

func start_all_spawners():
	var spawners = get_tree().get_nodes_in_group("Spawners")
	for spawner in spawners:
		spawner.start()
		
func stop_all_spawners():
	var spawners = get_tree().get_nodes_in_group("Spawners")
	for spawner in spawners:
		spawner.stop()

func kill_all_enemy_instances():
	var enemies = get_tree().get_nodes_in_group("Enemies")
	var enemy_bullets = get_tree().get_nodes_in_group("Enemy_Bullets")
	
	for enemy in enemies:
		enemy.get_node("Attack_Rate").stop()
		enemy.queue_free()
	
	for bullet in enemy_bullets:
		bullet.queue_free()
