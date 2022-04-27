extends TextureRect

const MOVE_DUR = 2.0

onready var t: Tween = $Tween

func move_to(target_pos: Vector2) -> void:
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
