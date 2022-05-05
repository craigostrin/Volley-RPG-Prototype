extends PanelContainer

signal selector_moved(ch_slot_hovered)
signal ch_selected(ch_slot)

const OPAQUE = 255
const TRANSP = 0

onready var _slots := $Actions.get_children()
var _slot_index := 0 setget _set_slot_index


func _ready() -> void:
	reset()


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	
	if event.is_action_pressed("ui_down"):
		move_selector_down()
	if event.is_action_pressed("ui_up"):
		move_selector_up()


# PUBLIC
## SELECTION
func reset() -> void:
	self._slot_index = 0

func move_selector_down() -> void:
	self._slot_index += 1

func move_selector_up() -> void:
	self._slot_index -= 1

func select_ch() -> void:
	emit_signal("ch_selected", _slot_index)


## SETUP
func populate_actions(avail_actions: Array) -> void:
	var i := 0
	for slot in _slots:
		slot.get_node("Label").text = avail_actions[i].label
		i += 1


# PRIVATE
func _activate_selector(index: int) -> void:
	for slot in _slots:
		var selector: TextureRect = slot.get_node("Selector")
		selector.hide()
	
	var selector_to_activate: TextureRect = _slots[index].get_node("Selector")
	selector_to_activate.show()


func _set_slot_index(val: int) -> void:
	_slot_index = wrapi(val, 0, _slots.size())
	_activate_selector(_slot_index)
	emit_signal("selector_moved", _slot_index)
