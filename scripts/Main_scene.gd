extends Node2D
onready var player1=  get_node("Player1")
onready var player2= get_node("Player2")
var player1_position: Vector2
var player2_position: Vector2

func _physics_process(_delta):
	if check_player(player1): player1_position= player1.position
	if check_player(player2): player2_position= player2.position
	
	#HUD	
	$HUD/Player1_Scores.text= str(player1.scores)
	$HUD/Player2_Scores.text= str(player2.scores)
	if not check_player(player1) or not check_player(player2):
		$HUD/game_over_sprite.visible= true

func check_player(player) -> bool:
	if is_instance_valid(player):
		if player.life > 0:
			return true
	return false
