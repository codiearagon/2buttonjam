extends "../EnemyBase.gd"

onready var boat = get_node("../Boat")

func _ready():
	max_health = 50
	movement_speed = 100
	bullet_damage = 10
	bullet_speed = 50
	attack_rate = 2
	
	health = max_health
	

func _physics_process(delta: float) -> void:
	
	if health < max_health * .75 && health > max_health * .50:
		first_phase_change()
		
	elif health < max_health * .50 && health > max_health * .25:
		second_phase_change()
		
	elif health < max_health * .25:
		third_phase_change()
		
	else:
		default_phase()
	
func default_phase():
	print(boat.position)
	pass

func first_phase_change():
	pass

func second_phase_change():
	pass

func third_phase_change():
	pass
