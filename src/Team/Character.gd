class_name Character
extends Position2D

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

var team: int = Enum.Teams.LEFT setget _set_team

var anim_names: PoolStringArray = []

onready var selection_indic: TextureRect = $SelectionIndicator
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
	selection_indic.visible = is_hovered


func set_is_selected(val: bool) -> void:
	is_selected = val
	body.modulate = Color.blueviolet


func _set_team(val: int) -> void:
	if not val in Enum.Teams.values():
		printerr(name + " set to invalid team: " + str(val))
		return
	
	team = val
	body.scale.x = team
