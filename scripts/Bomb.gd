extends Area2D
var mov= Vector2()
var speed= 250

func _process(delta):
	translate(mov * speed * delta)
	
func _on_VisibilityNotifier_screen_exited():
	queue_free()
