extends Area2D

export var tileNumber = 1
export (int) var LandOnCost = -1000
export (int) var LandOnTime = -1
export (NodePath) var NextTilePath
export (NodePath) var LandOnLevelPath
var NextTile
var LandOnLevel

enum tiletype {START, GOOD, BAD, NEUTRAL}
export (tiletype) var TileType = tiletype.START

export var SpecialParameters = ""

signal transfer_phaseandroll



func _ready():
	NextTile = get_node(NextTilePath)
	LandOnLevel = get_node(LandOnLevelPath)
	var forwardMovement = false
	if(LandOnLevel != null):
		forwardMovement = (LandOnLevel.getLevelNumber() - get_parent().getLevelNumber() > 0)
	
	if(forwardMovement):
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


func LandOn(player):
	
	#Pause for 2 seconds- add animation
	
	updateDialogue(player,1)
	#change from Move to Dialogue state
	get_node("../../PlayerTracker").nextInTurnSequence()
	#yield(get_tree().create_timer(5.0), "timeout")
	
	if(SpecialParameters != ""):
		_EndOfGame(player)
	else:
		#Alter money and years
		player.alterPlayerMoney(LandOnCost)
		player.alterPlayerYears(LandOnTime)
			
	get_node("../../PlayerTracker").nextInTurnSequence()
	var currentLevelNumber = get_parent().getLevelNumber()
	 
	var forwardMovement = (LandOnLevel.getLevelNumber() - currentLevelNumber > 0)
	
	yield(get_tree().get_root().find_node("HUD2",true,false), "selectionMade")
	
	if(currentLevelNumber == 1):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 2):
		if(forwardMovement):
			#INSERT CODE FOR PURCHASING BACK-UP FORMULATIONS
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 3):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 4):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 5):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 6):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 7):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 8):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			
	if(currentLevelNumber == 9):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
		
	if(currentLevelNumber == 10):
		if(forwardMovement):
			levelUp(player)
		else:
			tryAgain(player)
			

func updateDialogue(player,num):
	var dialogue = get_tree().get_root().find_node("Dialogue",true,false)
	connect("transfer_phaseandroll", dialogue, "_on_transfer_phaseandroll")
	if num == 0:
		emit_signal("transfer_phaseandroll", int(player.getCurrentLevel()), 0)
	else:
		emit_signal("transfer_phaseandroll", int(player.getCurrentLevel()), player.getCurrentTile())
		
		
	 

func levelUp(player):
	#yield(get_tree().get_root().find_node("HUD2",true,false), "selectionMade")
	get_node("Teleport/AnimationPlayer").play("Teleport")
	yield(get_tree().create_timer(0.8), "timeout")
	player.alterCurrentLevel(1)
	updateDialogue(player,0)
	
	var starting = LandOnLevel.getStartingTile()	
	starting.set_piece(player)
	get_node("../../ScrollingCamera").SetActiveLevelNumber(player.getCurrentLevel())
	
	starting.get_node("Teleport/AnimationPlayer").play("TeleportIn")
	yield(get_tree().create_timer(0.8), "timeout")
	
func tryAgain(player):
	#yield(get_tree().get_root().find_node("HUD2",true,false), "selectionMade")
	get_node("Teleport/AnimationPlayer").play("Teleport")
	yield(get_tree().create_timer(0.8), "timeout")
	player.setCurrentLevel(LandOnLevel.getLevelNumber())
	updateDialogue(player,0)
	
	var starting = LandOnLevel.getStartingTile()
	starting.set_piece(player)
	get_node("../../ScrollingCamera").SetActiveLevelNumber(player.getCurrentLevel())
	
	starting.get_node("Teleport/AnimationPlayer").play("TeleportIn")
	yield(get_tree().create_timer(0.8), "timeout")

func GoToNextTile(player):
	if(NextTile != null):
		player.setMovementTarget(NextTile._getTilePosition() + Vector2(0,-50))
		
func StopPlayer(player):
	player.setMovementTarget(self.position) #set target with offset
	
func _on_Tile_player_entered(player):
	get_node("Sprite/AnimationPlayer").play("UpAndDown")
	if(player.getCurrentTile() == tileNumber):
		if(TileType == tiletype.START):
			StopPlayer(player)
			yield(get_tree().create_timer(2.0), "timeout")
			get_node("Sprite/AnimationPlayer").stop()
			
		else:
			LandOn(player)
			yield(get_tree().create_timer(2.0), "timeout")
			get_node("Sprite/AnimationPlayer").stop()
	else:
		GoToNextTile(player)
		yield(get_tree().create_timer(2.0), "timeout")
		get_node("Sprite/AnimationPlayer").stop()
		

#The tile's position, with the level position accounted for.
func _getTilePosition():
	return self.get_position() + self.get_parent().get_position()

func set_piece(player) -> void:
	player.position = _getTilePosition() + Vector2(0,-50)
	GoToNextTile(player)
	
func _EndOfGame(player):
	#use the landOnCost to set the profit per year
	if(SpecialParameters == "ProfitPerYear"):
		player.setProfitPerYear(LandOnCost)
	#use LandOnCost to set lives saved
	elif(SpecialParameters == "LivesSaved"):
		player.setLivesSaved(LandOnCost)
		print("Player score: " + str(player.getFinalScore()))
