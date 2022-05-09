#TODO - fix the health / max_health issue

class_name Character
extends Position2D

signal selected( available_actions )

const RIGHT_SIDE_X = 200.0

export(Resource) var _data
export(Resource) var _action_data

var _name: String
var stamina: int
var morale: int

var _stats: Dictionary
var _ability_scores: Array
var _available_actions: Array # Array of Dicts with up-to-date action data

var is_hovered := false
var is_selected := false
export var is_weapon := false

var side: int = Side.LEFT setget _set_side

var anim_names: PoolStringArray = []

onready var body: KinematicBody2D = $KinematicBody2D
onready var anim_sprite: AnimatedSprite = $KinematicBody2D/AnimatedSprite


func _ready() -> void:
	anim_names = anim_sprite.frames.get_animation_names()
	_stats = _data.get_stats()
	_ability_scores = _data.get_ability_scores()
	_available_actions = _action_data.get_actions()
	
	_name = _stats.name
	stamina = _stats.max_stamina
	morale = _stats.max_morale
	play_anim("idle")


func play_anim(name: String) -> void:
	if not name in anim_names:
		printerr(name + " not in anim_names.")
		return
	
	anim_sprite.play(name)


func _set_side(val: int) -> void:
	if not val in Side.values():
		printerr(name + " set to invalid team: " + str(val))
		return
	
	side = val
	
	body.scale.x = side


# PUBLIC GETTERS
func get_indic_pos() -> Vector2:
	return $SelectionIndicatorPosition.position

func get_global_position() -> Vector2:
	return global_position

func get_dict() -> Dictionary:
	return {
		 "stats" : get_stats(),
		"scores" : get_ability_scores()
	}

func get_stats() -> Dictionary:
	return {
		   "name" : _name,
		"stamina" : stamina,
		 "morale" : morale
	}

func get_ability_scores() -> Array:
	return _ability_scores

func get_avail_actions() -> Array:
	return _available_actions
