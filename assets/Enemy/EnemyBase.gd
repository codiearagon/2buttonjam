extends KinematicBody2D

signal health_changed(value, max_value)

export var max_health: int = 0
export var health: int = 0
export var movement_speed: int = 0
export var bullet_damage: int = 0
export var bullet_speed: float = 0
export var attack_rate: float = 0

func receive_damage(amount: float):
	pass
