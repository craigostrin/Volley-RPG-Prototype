extends PanelContainer

const ON_SCREEN_Y = 10
const OFF_SCREEN_Y = -70

enum Alpha {
	TRANSPARENT = 120,
	TRANSLUCENT = 220,
	OPAQUE      = 255
}

onready var t: Tween = $Tween

func fade(alpha: int) -> void:
	t.interpolate_property(
		self,
		"modulate.a",
		modulate.a,
		alpha,
		1.0,Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)

func move() -> void:
	pass
