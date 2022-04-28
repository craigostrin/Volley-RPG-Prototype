extends TextureRect

signal move_finished

const MOVE_DUR = 2.0

var ready_to_move := true

onready var t: Tween = $Tween


func _ready() -> void:
	t.connect("tween_all_completed", self, "_on_tween_all_completed")


func move_to(target_pos: Vector2) -> void:
	if ready_to_move:
		ready_to_move = false
		
		t.interpolate_property(
			self,
			"rect_position",
			rect_position,
			target_pos,
			MOVE_DUR,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN
		)
		t.start()


func warp_to(target_pos: Vector2) -> void:
	if ready_to_move:
		rect_position = target_pos


func _on_tween_all_completed() -> void:
	ready_to_move = true
	emit_signal("move_finished")
