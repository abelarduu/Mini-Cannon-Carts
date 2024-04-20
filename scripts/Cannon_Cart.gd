tool
extends KinematicBody2D
var mov= Vector2()
var speed= 200
var BOMBS_CART_GROUP= "Bombs-" + str(self)
var pre_bomb= preload("res://scenes/Bomb.tscn")

#Assets
export (int, "Blue", "Red") var index setget set_index
var carts_sprites= ["res://sprites/blue_cannon_cart.png",
					"res://sprites/red_cannon_cart.png"]

var barrels_sprites= ["res://sprites/blue_cannon_barrel.png",
					  "res://sprites/red_cannon_barrel.png"]
					
var bombs_sprites= ["res://sprites/blue_bomb.png",
					"res://sprites/red_bomb.png"]

func set_index(val):
	index= val
	if Engine.editor_hint:
		update()

func _draw():
	$sprite.texture= load(carts_sprites[index])
	$Barrel/sprite.texture= load(barrels_sprites[index])
	#$bomb/sprite.texture= load(bombs_sprites[index])
	
func _process(_delta):
	if not Engine.editor_hint:
		mov= Vector2.ZERO
		if Input.is_action_pressed("ui_up"): mov.y= -1
		if Input.is_action_pressed("ui_down"): mov.y= 1
		if Input.is_action_pressed("ui_left"): mov.x= -1
		if Input.is_action_pressed("ui_right"): mov.x= 1
		
		if Input.is_action_just_pressed("ui_shoot"):
			if get_tree().get_nodes_in_group(BOMBS_CART_GROUP).size() <3:
				$Barrel/Anim.play("fire")
				var bomb= pre_bomb.instance()
				bomb.add_to_group(BOMBS_CART_GROUP)
				bomb.position= $Barrel/position.global_position
				bomb.mov= Vector2(cos(rotation), sin(rotation)).normalized()
				$"../".add_child(bomb)
				
		look_at(get_global_mouse_position())
		mov= move_and_slide(mov * speed)
