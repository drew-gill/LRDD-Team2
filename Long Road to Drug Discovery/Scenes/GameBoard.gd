extends Node2D
const TILE_WIDTH = 124

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_pieces()
	generate_HUD()


func generate_pieces() -> void:
	var new_piece = load("res://Prefabs/Player.tscn").instance()
	add_child(new_piece)
	var starting = get_node("Level1/StartingTile")
	starting.set_piece(new_piece)
	
	
	
func generate_HUD():
	var newHUD = load("res://Scenes/HUD2.tscn").instance()
	add_child(newHUD)


