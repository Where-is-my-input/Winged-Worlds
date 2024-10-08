extends Node2D
@onready var collision_shape_2d = $cb2Platform/CollisionShape2D
@onready var color_cell = $cb2Platform/colorCell
@onready var cb_2_platform = $cb2Platform

@export var disabled = false
@export var color:Global.WORLD_COLOR = Global.WORLD_COLOR.WHITE
@export var world:Global.WORLD = Global.WORLD.PLATFORMER

var locked = false
var waitingSwap = false

func _ready():
	match world:
		Global.WORLD.PLATFORMER:
			Global.connect("platformColorSwap", colorSwapped)
		Global.WORLD.TOPDOWN:
			Global.connect("topdownColorSwap", colorSwapped)
		_:
			Global.connect("colorSwap", colorSwapped)
	collision_shape_2d.disabled = disabled
	color_cell.currentColor = color
	color_cell.setCurrentColor()

func colorSwapped():
	disabled = !disabled
	if !locked: 
		#collision_shape_2d.disabled = disabled
		setCollision()
		color_cell.colorSwap()
	else:
		waitingSwap = !waitingSwap

func _on_area_2d_body_entered(body):
	if !body.is_in_group("player"): return
	locked = true

func _on_area_2d_body_exited(body):
	if !body.is_in_group("player"): return
	if locked && waitingSwap: 
		#collision_shape_2d.disabled = disabled
		setCollision()
		color_cell.colorSwap()
		waitingSwap = false
	locked = false

func setCollision():
	collision_shape_2d.set_deferred("disabled", disabled)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !disabled: area.queue_free()
