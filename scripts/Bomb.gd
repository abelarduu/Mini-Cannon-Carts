extends Area2D
var parent
var index: int
var mov: Vector2
var speed= 250
var damage= 20
var type_frames= ["res://scenes/Spriteframes/Blue_bomb.tres",
				  "res://scenes/Spriteframes/Red_bomb.tres"]

func _draw():
	$AnimatedSprite.frames= load(type_frames[index])
	
func _physics_process(delta):
	translate(mov * speed * delta)
	
func _on_Bomb_body_entered(body):
	if not "walls" in body.name:
		body.life-= damage
		
		if body.life <= 0 and body.get_score:
			body.damage_animate()
			parent.scores += 20
			body.get_score= false
	
	z_index= 3
	mov*= Vector2.ZERO
	$AnimatedSprite.scale= Vector2(4, 4)
	$AnimatedSprite.animation= "destroyed"
	yield($AnimatedSprite, "animation_finished")
	queue_free()
