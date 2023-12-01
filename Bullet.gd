extends Area2D

var bullet_speed : float = 400
var bullet_direction := 1

# Called when the node enters the scene tree for the first time.
func _process(delta):
	# Movimentar a bala
	position.x += bullet_direction * bullet_speed * delta

func set_bullet_direction(direction):
	bullet_direction = direction
	if bullet_direction == 1:
		$sprite.flip_h = false
	else:
		$sprite.flip_h = true
		
	
	

func _on_Bullet_body_entered(body):
	# Verificar se atingiu o objeto específico que você quer aumentar
	if body.is_in_group("scalable") and body.hitted == false:
		# Aumentar o tamanho do objeto
		body.scale *= 2  # Ajuste o fator de aumento conforme necessário
		body.hitted = true
		
		# Remover a bala da cena ao colidir com o objeto
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
