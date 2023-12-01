extends CharacterBody2D


const SPEED = 500.0

@onready var wall_detector = $Wall_Detector as RayCast2D
@onready var sprite = $Sprite
@onready var anim = $Animation

var direction := -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.target_position *= -1
	
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	velocity.x = direction * SPEED * delta
	
	move_and_slide()


func _on_animation_animation_finished(anim_name):
	if anim_name == "Hurt":
		queue_free()
