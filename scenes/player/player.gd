extends CharacterBody2D


const SPEED = 150.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")
	velocity = direction * SPEED
	print(direction)

	move_and_slide()
