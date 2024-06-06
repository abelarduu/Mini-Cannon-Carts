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
		#if colidir com o Player Pai da bomba:
		#Causa um Self-Damage com dano diminuido
		if body == parent: body.life-= damage/2
		#Senão: causar dano normal
		else: body.life-= damage
		shake_obj(body)
		
		#Destruindo objs
		if body.life <= 0:
			body.damage_animate()
			parent.scores += body.self_point
			body.self_point= 0
	
	z_index= 3
	mov*= Vector2.ZERO
	$AnimatedSprite.scale= Vector2(4, 4)
	$AnimatedSprite.animation= "destroyed"
	yield($AnimatedSprite, "animation_finished")
	queue_free()

func shake_obj(obj):
	var shake_intensity = 1
	# Gerando valores de deslocamento aleatório
	var shake_offset = Vector2(randf() * shake_intensity * 3 - shake_intensity, randf() * shake_intensity * 3 - shake_intensity)
	var new_pos = obj.position + shake_offset
	obj.position = lerp(obj.position, new_pos, 0.5)
