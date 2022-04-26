extends PanelContainer

#TODO
## Replace Tween with AnimationPlayer (which is better for when you know the final
##		values in advance)
## Smooth out the transitions
## Fade to transparent after a few seconds of translucense
## Fade out completely instead of move_out

enum Position {
	ON_SCREEN_Y = 10
	OFF_SCREEN_Y = -70
}

enum Alpha {
	INVISIBLE   =   0,
	TRANSPARENT = 120,
	TRANSLUCENT = 220,
	OPAQUE      = 255
}

onready var t: Tween = $Tween

func fade_in() -> void:
	tween_fade(Alpha.TRANSLUCENT)
	tween_move_to(Position.ON_SCREEN_Y)
	t.start()


func fade_out() -> void:
	tween_move_to(Position.OFF_SCREEN_Y)
	tween_fade(Alpha.INVISIBLE)
	t.start()


func tween_fade(Alpha: int) -> void:
	t.interpolate_property(
		self,
		"modulate.a8",
		modulate.a8,
		Alpha,
		3.0,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)


func tween_move_to(Position: int) -> void:
	var target_rect_position := Vector2(rect_position.x, Position)
	
	t.interpolate_property(
		self,
		"rect_position",
		rect_position,
		target_rect_position,
		1.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
