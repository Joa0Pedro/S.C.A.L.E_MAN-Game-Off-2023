extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))
	

func on_button_pressed(button_name : String):
	match button_name:
		"ReturnMenu":
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")
