extends Node

const SERVE   = 0
const RECEIVE = 1
const SET     = 2
const SPIKE   = 3
const BLOCK   = 4

# I forget the point of this
enum Enum { SERVE = 0, RECEIVE = 1, SET = 2, SPIKE = 3, BLOCK = 4 }

func values() -> Array:
	return [ SERVE, RECEIVE, SET, SPIKE, BLOCK ]
