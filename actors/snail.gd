extends CharacterBody2D

const SPEED = 300.0

var direction = -1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_procces(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = direction * SPEED
	
	move_and_slide()
