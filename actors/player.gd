extends CharacterBody2D

signal died

const BULLET = preload("res://prefabs/bullet.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation = $AnimationPlayer
@onready var texture = $Texture
@onready var remote_transform = $RemoteTransform2D
@onready var ray_right = $Ray_right
@onready var ray_left = $Ray_left


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_hurted = false
var player_life = 1
var knockback_vector = Vector2.ZERO

# Propriedades do tiro
var bullet_speed : float = 400
var can_shoot : bool = true
var bullet_timer : float = 0.5
var bullet_timer_max : float = 0.5
var bullet_scene : PackedScene

func _ready():
	bullet_scene = preload("res://prefabs/bullet.tscn")


func _process(delta):
	# Atualizar temporizador de tiro
	bullet_timer -= delta
	if bullet_timer < 0:
		can_shoot = true
	
	if can_shoot and Input.is_action_just_pressed("aumentar"):
		shoot()
		animation.play("shooting")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if not is_on_floor():
			velocity.y += gravity * delta
			animation.play("jump")
	else:
		if(velocity.x == 0):
			animation.play("idle")
		else:
			animation.play("run")
		
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("esquerda", "direita")
	
	if Input.is_action_just_pressed("esquerda"):
		if sign($bullet_point.position.x) == 1:
			$bullet_point.position.x *= -1
	if Input.is_action_just_pressed("direita"):
		if sign($bullet_point.position.x) == -1:
			$bullet_point.position.x *= -1
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	if direction > 0:
		texture.flip_h = false
	elif direction < 0:
		texture.flip_h = true
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	move_and_slide()
	apply_push_force()
	set_animation()

func shoot():
	if bullet_scene:
		#anim.play("shooting")
		# Instanciar a bala
		var bullet_instance = bullet_scene.instantiate()
		
		# Posicionar a bala na posição do personagem
		bullet_instance.position = position
		
		# Adicionar a bala à cena
		if sign($bullet_point.position.x) == 1:
			bullet_instance.set_bullet_direction(1)
		else:
			bullet_instance.set_bullet_direction(-1)
		
		get_parent().add_child(bullet_instance)
		bullet_instance.position = $bullet_point.global_position
		
		# Reiniciar o temporizador de tiro
		bullet_timer = bullet_timer_max
		can_shoot = false
		
		
		


func apply_push_force():
	for objects in get_slide_collision_count():
		var collision = get_slide_collision(objects)
		if collision.get_collider() is Pushables:
			collision.get_collider().slide_object(-collision.get_normal())
	

func set_animation():
	var state := "idle"
	
	if not is_on_floor():
		state = "jump"
	elif velocity.x != 0:
		state = "run"
	elif can_shoot:
		state = "shooting"


func _on_hurtbox_body_entered(body):
	if ray_right.is_colliding():
		take_damage(Vector2(-400,-400))
	elif ray_left.is_colliding():
		take_damage(Vector2(400,-400))


func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path


func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	
	if player_life > 0:
		player_life -= 1
	else:
		die()
	
		
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		

func die():
	emit_signal("died")
	queue_free()
	#mandar o boneco tornar visível uma mensagem de "Press R to restart level"
