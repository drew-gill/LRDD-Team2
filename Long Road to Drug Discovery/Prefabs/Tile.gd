extends Area2D

export var tileNumber = 1
export (int) var LandOnCost = -1000
export (int) var LandOnTime = -1
export (NodePath) var NextTilePath
export (NodePath) var LandOnLevelPath
var NextTile
var LandOnLevel

signal transfer_phaseandroll

enum tiletype {START, GOOD, BAD, NEUTRAL}
export (tiletype) var TileType = tiletype.START


func _ready():
	NextTile = get_node(NextTilePath)
	LandOnLevel = get_node(LandOnLevelPath)
	var LevelProgression = 0
	if(LandOnLevel != null):
		LevelProgression = LandOnLevel.getLevelNumber() - get_parent().getLevelNumber()
	
	if(TileType == tiletype.GOOD or TileType == tiletype.NEUTRAL or TileType == tiletype.START):
		if(TileType == tiletype.GOOD):
			$Sprite.texture = load("res://Custom Assets/TileSprites/shipGreen.png")
		elif(TileType == tiletype.BAD):
			$Sprite.texture = load("res://Custom Assets/TileSprites/shipPink.png")
		elif(TileType == tiletype.NEUTRAL):
			$Sprite.texture = load("res://Custom Assets/TileSprites/shipBeige.png")
		else:
			$Sprite.texture = load("res://Custom Assets/TileSprites/shipBlue.png")
	else:
		if(TileType == tiletype.GOOD):
			$Sprite.texture = load("res://Custom Assets/TileSprites/laserGreen3.png")
		elif(TileType == tiletype.BAD):
			$Sprite.texture = load("res://Custom Assets/TileSprites/laserPink3.png")
		elif(TileType == tiletype.NEUTRAL):
			$Sprite.texture = load("res://Custom Assets/TileSprites/laserBeige3.png")
		else:
			$Sprite.texture = load("res://Custom Assets/TileSprites/laserBlue3.png")

func updateDialogue(player,num):
	var dialogue = get_tree().get_root().find_node("Dialogue",true,false)
	connect("transfer_phaseandroll", dialogue, "_on_transfer_phaseandroll")
	if num == 0:
		emit_signal("transfer_phaseandroll", int(player.getCurrentLevel()), 0)
	else:
		emit_signal("transfer_phaseandroll", int(player.getCurrentLevel()), player.getCurrentTile())



func LandOn(player):
	player.alterPlayerMoney(LandOnCost)
	player.alterPlayerYears(LandOnTime)
	updateDialogue(player,1)
	if(TileType == tiletype.GOOD or TileType == tiletype.NEUTRAL):
		levelUp(player)
	else:
		tryAgain(player)


func levelUp(player):
	var starting = LandOnLevel.getStartingTile()
	starting.set_piece(player)
	player.alterCurrentLevel(1)
	#updateDialogue(player,0)
	
func tryAgain(player):
	var starting = get_parent().getStartingTile()
	starting.set_piece(player)
	#updateDialogue(player,0)
	

func GoToNextTile(player):
	if(NextTile != null):
		player.setMovementTarget(NextTile.position + Vector2(0,-50))
		
func StopPlayer(player):
	player.setMovementTarget(self.position) #set target with offset
	
func _on_Tile_player_entered(player):
	if(player.getCurrentTile() == tileNumber):
		if(TileType == tiletype.START):
			StopPlayer(player)
		else:
			LandOn(player)
	else:
		GoToNextTile(player)

func set_piece(player) -> void:
	player.position = position + Vector2(0,-50)
	GoToNextTile(player)
