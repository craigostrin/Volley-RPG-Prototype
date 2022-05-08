extends PanelContainer

signal action_hovered(description)
signal action_selected(action)

var action_slot_scene := preload("res://src/UI/ActionSlot.tscn")

const OPAQUE = 255
const TRANSP = 0

var _slots := []
var _slot_index := 0 setget _set_slot_index
var _actions := []


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

func select_action() -> void:
	var action = _actions[_slot_index]
	emit_signal("action_selected", action)


## SETUP
func populate_actions(avail_actions: Array) -> void:
	_actions = avail_actions
	
	# Create the ActionSlot HBox
	for action in _actions:
		var action_slot = action_slot_scene.instance()
		$Actions.add_child(action_slot)
		_slots.append(action_slot)
	
	# Put the correct text into the ActionSlot
	var i := 0
	for slot in _slots:
		slot.get_node("Label").text = _actions[i].label
		i += 1


# When a ch is de-selected, we need to clear the ActionSlots of the prev ch
func clear_actions() -> void:
	for slot in _slots:
		slot.queue_free()
	_slots.clear()


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
	
	var description = _actions[_slot_index].description
	emit_signal("action_hovered", description)
