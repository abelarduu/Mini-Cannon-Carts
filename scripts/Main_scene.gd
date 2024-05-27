extends Node2D
onready var player1=  get_node("Player1")
onready var player2= get_node("Player2")
var player1_position: Vector2
var player2_position: Vector2
var play= false

func _physics_process(_delta):
	if check_player(player1): player1_position= player1.position
	if check_player(player2): player2_position= player2.position
	
	#HUD
	if play: $HUD/game_icon.visible= false
	if $HUD/game_icon.global_position <=  Vector2(491.020996, 295):
		$HUD/game_icon.position+= Vector2(0, 5)
			
	$HUD/Player1_Scores.text= str(player1.scores)
	$HUD/Player2_Scores.text= str(player2.scores)
	if not check_player(player1) or not check_player(player2):
		$HUD/game_over_sprite.visible= true

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_select"):
			if event.pressed:
				play= true

func check_player(player) -> bool:
	if is_instance_valid(player):
		if player.life > 0:
			return true
	return false
