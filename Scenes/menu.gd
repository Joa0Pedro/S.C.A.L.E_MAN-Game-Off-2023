extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_button_pressed(button_name : String):
	match button_name:
		"Play":
			get_tree().change_scene_to_file("res://levels/level_1.tscn")
		"Credits":
			get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
		"Quit":
			get_tree().quit()
		"Controls":
			get_tree().change_scene_to_file("res://Scenes/controls.tscn")
