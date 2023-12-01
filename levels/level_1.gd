extends Node2D

@onready var player = $Player
@onready var camera = $Camera
@onready var player_scene = preload("res://actors/player.tscn")
@onready var pause_menu = $Camera/CanvasLayer


var player_char = null
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
	

func _ready():
	player.follow_camera(camera)
	
 
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
	
