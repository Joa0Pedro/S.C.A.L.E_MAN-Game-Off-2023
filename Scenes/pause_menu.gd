extends Control


func _on_resume_pressed():
	hide()
	Engine.time_scale = 1

func _on_quit_pressed():
	get_tree().quit()
