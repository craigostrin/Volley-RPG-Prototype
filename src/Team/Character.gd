class_name Character
extends Position2D

const RIGHT_SIDE_X = 200.0

var health   := 5
var stamina  := 3

var stats := {
	"Name" : "Rodrigo",
	"PWR" : 85,
	"AGI" : 85,
	"END" : 85,
	"INT" : 85,
	"WIS" : 85,
	"CHA" : 85
}

var is_hovered := false
var is_selected := false setget set_is_selected
export var is_weapon := false

var side: int = Side.LEFT setget _set_side

var anim_names: PoolStringArray = []

onready var body: KinematicBody2D = $KinematicBody2D
onready var anim_sprite: AnimatedSprite = $KinematicBody2D/AnimatedSprite


func _ready() -> void:
	anim_names = anim_sprite.frames.get_animation_names()
	play_anim("idle")


func play_anim(name: String) -> void:
	if not name in anim_names:
		printerr(name + " not in anim_names.")
		return
	
	anim_sprite.play(name)


func set_is_hovered(val: bool) -> void:
	is_hovered = val


func set_is_selected(val: bool) -> void:
	is_selected = val
	body.modulate = Color.blueviolet


func _set_side(val: int) -> void:
	if not val in Side.values():
		printerr(name + " set to invalid team: " + str(val))
		return
	
	side = val
	prints("side:", side)
	
	body.scale.x = side


# PUBLIC GETTERS
func get_selection_indic_global_pos() -> Vector2:
	return $SelectionIndicatorPosition.global_position

func get_global_position() -> Vector2:
	return global_position
