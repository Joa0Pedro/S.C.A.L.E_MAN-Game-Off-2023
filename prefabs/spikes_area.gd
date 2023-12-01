extends Area2D

@onready var collision = $Collision
@onready var sprite = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	collision.shape.size = sprite.get_rect().size



func _on_body_entered(body):
	if body.name == "Player" && body.has_method("take_damage"):
		body.take_damage(Vector2(0, -400))
	if body.is_in_group("box"):
		body.queue_free()
