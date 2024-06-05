extends Node2D
onready var player1=  get_node("Player1")
onready var player2= get_node("Player2")
var player1_position: Vector2
var player2_position: Vector2
var play= false

func _physics_process(_delta):
	if check_player(player1): player1_position= player1.position
	if check_player(player2): player2_position= player2.position
	$HUD/Player1_Scores.text= str(player1.scores)
	$HUD/Player2_Scores.text= str(player2.scores)

	if play: 
		#Movendo a placa "Game icon" para fora da tela
		move_obj($HUD/game_icon_sprite, Vector2(491.020996, -190), -5)
		#Se o um dos players morrerem: Anime a placa "Game Over"
		if not check_player(player1) or not check_player(player2):
			$HUD/game_over_sprite.visible= true
			if $HUD/game_over_sprite.scale >= Vector2(4.5, 4.5):
				$HUD/game_over_sprite.scale-= Vector2(0.25,0.25)
	else:
		#Movendo a placa "Game icon" para dentro da tela 
		move_obj($HUD/game_icon_sprite, Vector2(491.020996, 295), 5)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if not play:
				#Se a placa "Game icon" estiver no local certo dentro da tela: 
				if $HUD/game_icon_sprite.position >= Vector2(491.020996, 295):
					play= true
			
			#Se a Animação da placa "Game Over" acabar:
			if $HUD/game_over_sprite.scale <= Vector2(4.5, 4.5):
				$HUD/game_over_sprite.scale=Vector2(10,10)
				$HUD/game_over_sprite.visible= false
				reset_game()

func check_player(player) -> bool:
	if is_instance_valid(player):
		if player.life > 0:
			return true
	return false

func move_obj(obj, new_pos, steps):
	if not obj.position == new_pos:
		obj.position+= Vector2(0, steps)

func reset_game():
	#Pegando todos Objetos
	var boxes= $objects/boxes.get_children()
	var barrels= $objects/barrels.get_children()
	var containers= $objects/containers.get_children()
	var objs= boxes + barrels + containers
	var nodes= get_children() + objs
	
	#Resetando tudo
	for node in nodes:
		if node.has_method("reset"):
			node.reset()
	play= false
