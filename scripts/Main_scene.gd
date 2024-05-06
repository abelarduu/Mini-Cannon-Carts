extends Node2D
onready var player1= get_node("Player1")
onready var player2= get_node("Player2")
var player1_position: Vector2
var player2_position: Vector2

func _physics_process(_delta):
	player1_position= player1.position
	player2_position= player2.position
