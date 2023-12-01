extends CharacterBody2D
class_name Pushables

var scale_factor : float = 1.0
var max_scale : float = 2.0
var push_speed : float = 200
var hitted : bool = false
var box_life : int = 1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.y += gravity * delta
	
	move_and_slide()
	
	velocity.x = 0
	
	

func slide_object(direction):
	velocity.x = int(direction.x) * push_speed
	

#func take_damage():
	#if box_life > 0:
		#box_life -= 2
	#else:
		#queue_free()
	
