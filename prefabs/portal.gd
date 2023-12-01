extends Area2D

@onready var transition = get_parent().get_node("Transition")
@export var next_level : String = ""


func _on_body_entered(body):
	if body.is_in_group("player") and !next_level == "":
		transition.change_scene(next_level)
