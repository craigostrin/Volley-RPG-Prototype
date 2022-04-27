class_name UI
extends Control

signal ch_slot_selected(slot)

var _hovered_slot := Vector2.ZERO
var _active_side: int = Side.LEFT

onready var selection_indicator: TextureRect = $SelectionIndicator


func select_hovered_ch_slot() -> void:
	pass
