class_name CombatManager
extends Node

signal defense_action_completed
signal attack_action_completed

onready var test_timer: Timer = $PlaceholderTimer

func init_defense_action(action) -> void:
	yield(test_timer.start(), "timeout")
	prints(self, "defense selected -", "init action")


func init_attack_action(action) -> void:
	yield(test_timer.start(), "timeout")
	prints(self, "attack action selected -", "init action")


func _on_defense_action_completed() -> void:
	#calculate active player's possible attack options
	emit_signal("defense_action_completed")

func _on_attack_action_completed() -> void:
	#calculate opponent's possible defense options
	emit_signal("attack_action_completed")
