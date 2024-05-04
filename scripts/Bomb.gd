extends Area2D
var mov: Vector2
var speed: int = 250

func _physics_process(delta):
	translate(mov * speed * delta)
