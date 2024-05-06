extends Area2D
var mov: Vector2
var speed: int = 250
var damage: int= 30
var index: int
var type_frames= ["res://scenes/Spriteframes/Blue_bomb.tres", "res://scenes/Spriteframes/Red_bomb.tres"]

func _draw():
	$AnimatedSprite.frames= load(type_frames[index])
	
func _physics_process(delta):
	translate(mov * speed * delta)
	
func _on_Bomb_body_entered(body):
	if "Box" in body.name or "Barrel" in body.name:
		body.life-= damage
		if body.life <= 0:
			body.queue_free()
	queue_free()
