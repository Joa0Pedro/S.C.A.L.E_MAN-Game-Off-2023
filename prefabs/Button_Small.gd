extends Area2D

signal button_pressed




func _on_body_entered(body):
	if body.is_on_group("boxes"):
		emit_signal(button_pressed)
