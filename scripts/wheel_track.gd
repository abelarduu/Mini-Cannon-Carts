extends Node2D

func _on_Timer_queue_timeout():
	modulate_transparency()
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()

func modulate_transparency():
	var tween = Tween.new()
	tween.interpolate_property($Sprite, "modulate:a", 1.0, 0.0, 0.3)
	add_child(tween)
	tween.start()
