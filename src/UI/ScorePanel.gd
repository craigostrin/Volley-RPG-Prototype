class_name ScorePanel
extends PanelContainer

#TODO
## Fade out completely instead of move_out

const FADE_IN_DUR     = 1.0
const FADE_OUT_DUR    = 0.6
const FADE_TRANSP_DUR = 1.5
const MOVE_IN_DUR     = 0.6
const MOVE_OUT_DUR    = 1.0
const TRANSP_DELAY    = 1.4
const MOVE_OUT_DELAY  = FADE_OUT_DUR + 0.2


# If needed:
# Left X = 10
# Right X = 230 (recalc this later, based on rect size + 10 margin)
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
onready var transp_timer: Timer = $GoToTranspTimer


func _ready() -> void:
	transp_timer.start(TRANSP_DELAY)
	yield(transp_timer, "timeout")
	
	_tween_fade(Alpha.TRANSPARENT, FADE_TRANSP_DUR)
	t.start()


func fade_in() -> void:
	# Fade in
	_tween_fade(Alpha.TRANSLUCENT, FADE_IN_DUR)
	_tween_move_to(Position.ON_SCREEN_Y, MOVE_IN_DUR)
	t.start()
	yield(t, "tween_all_completed")
	
	# Wait a few seconds
	transp_timer.start(TRANSP_DELAY)
	yield(transp_timer, "timeout")
	
	# Fade to transparent
	_tween_fade(Alpha.TRANSPARENT, FADE_TRANSP_DUR)
	t.start()


func fade_out() -> void:
	_tween_fade(Alpha.INVISIBLE, FADE_OUT_DUR)
	_tween_move_to(Position.OFF_SCREEN_Y, MOVE_OUT_DUR, MOVE_OUT_DELAY)
	t.start()


# in should be 1.0, out should be 0.6
func _tween_fade(Alpha: int, Duration: float) -> void:
	t.interpolate_property(
		self,
		"modulate:a8",
		modulate.a8,
		Alpha,
		Duration,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)

# in should be 0.6, out should be 1.0 
func _tween_move_to(Y_Position: int, Duration: float, Delay := 0.0) -> void:
	var target_rect_position := Vector2(rect_position.x, Y_Position)
	
	t.interpolate_property(
		self,
		"rect_position",
		rect_position,
		target_rect_position,
		Duration,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT,
		Delay
	)
