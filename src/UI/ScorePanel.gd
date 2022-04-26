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
# scorepanelRight x position, 230, but you should recalc for final product

enum Alpha {
	INVISIBLE   =   0,
	TRANSPARENT = 120,
	TRANSLUCENT = 220,
	OPAQUE      = 255
}

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var timer: Timer = $Timer


func move_fade_in() -> void:
	anim_player.play("MoveFadeIn")
	timer.start()
	yield(timer, "timeout")
	anim_player.play("FadeTransparent") 


func move_fade_out() -> void:
	anim_player.play("MoveFadeOut")

