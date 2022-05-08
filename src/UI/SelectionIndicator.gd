extends TextureRect

signal move_finished

const MOVE_SPD = 100.0

var ready_to_move := true
var move_queue := []

onready var t: Tween = $Tween


func move_to(target_pos: Vector2) -> void:
	ready_to_move = false
	var dist := Vector2(rect_position).distance_to(target_pos)
	var move_duration := dist / MOVE_SPD
	
	t.interpolate_property(
		self,
		"rect_position",
		rect_position,
		target_pos,
		move_duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	t.start()
	
	# Let everyone know the move is finished.
	yield(t, "tween_all_completed" )
	ready_to_move = true
	emit_signal("move_finished")


func warp_to(target_pos: Vector2) -> void:
	if ready_to_move:
		rect_position = target_pos
