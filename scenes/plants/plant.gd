extends Node2D
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D

var phases : int = 0

func _ready() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	if phases < 3:
		sprite_2d.frame += 1
		print("Passou 5 segundos")
	else:
		timer.stop()
