extends Node2D
class_name Piece

#piece properties
var moneySpent = 0
var timeElapsed = 0 
var pieceName = 'Josiel'
export var money = 1000000


#Signals
signal leaving_tile

#access the board itself
onready var board = get_node("/root/Node2D")

func _ready():
	pass

#get the tile that the piece is currently on
func get_current_tile()-> BoardTile:
	#CHANGE DENOMINATOR TO SIZE OF SQUARE
	var tile_position = position/board.TILE_WIDTH
	tile_position.x = int(tile_position.x)
	tile_position.y = int(tile_position.y)
	return board.get_tile_by_pos(tile_position)

	
func getPlayerMoney():
	return moneySpent

func getPlayerYears():
	return timeElapsed
	

func alterPlayerMoney(changeValue):
	moneySpent += changeValue

func alterPlayerYears(changeValue):
	timeElapsed += changeValue
	
#When the piece is clicked:

func _on_Button_pressed():
	print(pieceName)
	print('--------------------------------')
	print("Current Tile ID " + str(get_current_tile().get_tile_ID()))
	print("Money Spent: $" + str(moneySpent))
	board.move_piece(self, Vector2(1,0))
	print('--------------------------------')