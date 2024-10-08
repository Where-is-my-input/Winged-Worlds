extends Node2D

@export var world:Global.WORLD
@export var triggerValue = 1

@export var type = 1

func _on_area_2d_body_entered(body):
	if !body.is_in_group("player"):
		return
	match world:
		Global.WORLD.PLATFORMER:
			Global.platformTrigger.emit(triggerValue)
		Global.WORLD.TOPDOWN:
			Global.topDownTrigger.emit(triggerValue)
	match type:
		_:
			queue_free()
