extends Node2D
var player1_position: Vector2
var player2_position: Vector2

func _physics_process(_delta):
	player1_position= get_node("Player1").position
	player2_position= get_node("Player2").position
