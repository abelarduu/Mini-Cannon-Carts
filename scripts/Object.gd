tool
extends StaticBody2D

#Assets
export (int , "Box", "Barrel","Contanier") var type_objects
export (int, "Blue", "Red") var index setget set_index
var types_frames_box= ["res://scenes/Spriteframes/Blue_box.tres", "res://scenes/Spriteframes/Red_box.tres"]
var types_frames_barrel= ["res://scenes/Spriteframes/Blue_barrel.tres", "res://scenes/Spriteframes/Red_barrel.tres"]
var types_frames_container= ["res://scenes/Spriteframes/Blue_contanier.tres", "res://scenes/Spriteframes/red_contanier.tres"]

func set_index(val):
	index= val
	if Engine.editor_hint:
		update()
		
func _draw():
	if type_objects == 0: $AnimatedSprite.frames= load(types_frames_box[index])
	if type_objects == 1: $AnimatedSprite.frames= load(types_frames_barrel[index])
	if type_objects == 2: $AnimatedSprite.frames= load(types_frames_container[index])
