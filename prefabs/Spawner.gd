extends Node2D

@onready var timer = $Timer

var boxes = preload("res://prefabs/enlarge_box_bigger.tscn")
var spawn_location : Vector2 = Vector2(0, 0)

func _ready():
	pass
	

func instance_object():
	var spawn_box = boxes.instantiate()
	call_deferred("add_child", spawn_box)

func _on_timer_timeout():
	instance_object()
	
