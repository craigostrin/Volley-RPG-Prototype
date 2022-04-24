extends PanelContainer


var left_config := {
	"anchor_left"     : 0,
	"anchor_right"    : 0,
	"grow_horizontal" : GROW_DIRECTION_END,
	"rect_position"   : Vector2.ZERO
}

var right_config := {
	"anchor_left"     : 1,
	"anchor_right"    : 1,
	"grow_horizontal" : GROW_DIRECTION_BEGIN,
	"rect_position"   : Vector2(400, 0)
}


onready var ch_select_panel = $VBox/ChSelectPanelContainer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		ch_select_panel.move_selector_down()
	elif event.is_action_pressed("ui_up"):
		ch_select_panel.move_selector_up()
	elif event.is_action_pressed("ui_accept"):
		ch_select_panel.select_ch()


func set_config(team: int) -> void:
	if Enum.Teams.LEFT:
		_set_config(left_config)
	elif Enum.Teams.RIGHT:
		_set_config(right_config)
	else:
		printerr("Wrong config set.")
		return


func _set_config(dict: Dictionary) -> void:
	anchor_left = dict.anchor_left
	anchor_right = dict.anchor_right
	grow_horizontal = dict.grow_horizontal
	rect_position = dict.rect_position
