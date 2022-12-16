extends "../EnemyBase.gd"


func _ready():
	max_health = 50
	movement_speed = 100
	bullet_damage = 10
	bullet_speed = 50
	attack_rate = 2
	
	health = max_health

func _physics_process(delta: float) -> void:
	pass

func first_phase_change():
	pass

func second_phase_change():
	pass

func third_phase_change():
	pass
