tool
extends KinematicBody2D
var mov: Vector2
var life= 100
var speed= 200
var BOMBS_GROUP= "Bomb-" + str(self)
var pre_bomb= preload("res://scenes/Bomb.tscn")
var attack: bool
#Assets
export (int, "Blue", "Red") var index setget set_index
var type_frames= ["res://scenes/Spriteframes/Cannon_cart_blue.tres", "res://scenes/Spriteframes/Cannon_cart_red.tres"]
var attack_inputs= ["P1_attack", "P2_attack"] 
var mov_inputs= [["P1_left","P1_right","P1_up", "P1_down"],
				 ["P2_left","P2_right","P2_up", "P2_down"]]

func set_index(val):
	index= val
	if Engine.editor_hint:
		update()

func _draw():
	$AnimatedSprite.frames= load(type_frames[index])
	
func _physics_process(_delta):
	if not Engine.editor_hint:
		if life > 0:
			mov= Vector2.ZERO
			if Input.is_action_pressed(mov_inputs[index][0]): mov.x= -1
			if Input.is_action_pressed(mov_inputs[index][1]): mov.x= 1
			if Input.is_action_pressed(mov_inputs[index][2]): mov.y= -1
			if Input.is_action_pressed(mov_inputs[index][3]): mov.y= 1
			mov_animate()
			
			if Input.is_action_just_pressed(attack_inputs[index]):
				if get_tree().get_nodes_in_group(BOMBS_GROUP).size() <2:
					attack= true
					spawn_bomb()
			
			look_at(get_parent().player2_position if index == 0 else get_parent().player1_position)
			mov= move_and_slide(mov * speed)

func spawn_bomb():
	var bomb= pre_bomb.instance()
	bomb.add_to_group(BOMBS_GROUP)
	bomb.index= index
	bomb.position= $spawn_bomb_point.global_position
	bomb.mov= Vector2(cos(rotation), sin(rotation)).normalized()
	$"../".add_child(bomb)
	
func mov_animate():
	if attack: 
		$AnimatedSprite.animation="shot"
		yield($AnimatedSprite, "animation_finished")
		attack=false
	if mov.length_squared() > 0:
		$AnimatedSprite.animation= "run"
	else: $AnimatedSprite.animation= "idle"
