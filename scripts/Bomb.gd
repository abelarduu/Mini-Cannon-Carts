extends Area2D
var mov: Vector2
var speed: int = 250
var index: int
var type_frames= ["res://scenes/Spriteframes/Blue_bomb.tres", "res://scenes/Spriteframes/Red_bomb.tres"]

func _draw():
	$AnimatedSprite.frames= load(type_frames[index])
	
func _physics_process(delta):
	translate(mov * speed * delta)
	
func _on_Collision_Area_body_entered(_body):
	queue_free()
