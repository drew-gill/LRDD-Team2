extends Node
class_name HUD2

export (NodePath) var playerTrackerPath
var currentPlayer
var playerTracker

signal beginMoving
signal selectionMade
signal useBackup
signal transfer_phaseandroll

func _ready():
	_showAll(true)
	playerTracker = get_node(playerTrackerPath)
	randomize() #used to reset seed for dice roll
	
		
		
func _showAll(boolean):
	if(boolean == true):
		$VBoxContainer.show()
		$DialogueBox.show()

	else:
		$VBoxContainer.hide()
		$DialogueBox.hide()
	#always hide the warning, only want this when specifically called.
	$Warning.hide()
	
func _showWarning(text):
	$Warning.text = text
	$Warning.show()

func _on_EndTurn_pressed():
	playerTracker.endTurn()
	emit_signal("selectionMade")

func _on_BackUp_pressed():
	currentPlayer = playerTracker.getCurrentPlayerNode()
	if currentPlayer.getPlayerBackups()<3:
		currentPlayer.alterPlayerBackups(1)
		currentPlayer.alterPlayerMoney(-80000000)


func _on_Phase1_pressed():
	playerTracker.endTurn()
	emit_signal("selectionMade")


func _on_UseBackUp_pressed():
	if currentPlayer.getPlayerBackups()>0:
		var level = get_tree().get_root().find_node("Level"+str(currentPlayer.getCurrentLevel()),true,false)
		var tile = level.get_node("Tile"+str(currentPlayer.getCurrentTile()))
		connect("useBackup", tile, "_on_UseBackUp")
		emit_signal("useBackup")
		currentPlayer.alterPlayerBackups(-1)
		playerTracker.endTurn()
		emit_signal("selectionMade")


func _on_CoLicense_pressed():
	currentPlayer.colicense()
	currentPlayer.alterPlayerYears(-1)
	var level = get_tree().get_root().find_node("Level"+str(currentPlayer.getCurrentLevel()),true,false)
	var tile = level.get_node("Tile"+str(currentPlayer.getCurrentTile()))
	connect("colicense", tile, "_on_colicense")
	emit_signal("colicense")
	playerTracker.endTurn()
	emit_signal("selectionMade")

func _on_Phase2_pressed():
	playerTracker.endTurn()
	emit_signal("selectionMade")
	

func addCommas(value):
	var string = str(value)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res



func _process(delta):
	currentPlayer = playerTracker.getCurrentPlayerNode()
	if(currentPlayer != null):
		$VBoxContainer/Money.text = "Money: $" + addCommas(currentPlayer.getPlayerMoney())
		$VBoxContainer/Years.text = "Years left: " + str(currentPlayer.getPlayerYears())
		$VBoxContainer/BackupFormulations.text = "Backup Formulations: " + str(currentPlayer.getPlayerBackups())
		$PlayerTurn.text = "Player " + str(currentPlayer.getPlayerNumber()) +"'s Turn!"
		if(currentPlayer.getCurrentTile() < 1):
			$LevelText.text = "Level: " + str(currentPlayer.getCurrentLevel()) + "\n Please roll the dice!"
		else:
			$LevelText.text = "Level: " + str(currentPlayer.getCurrentLevel()) + "\n Roll: " + str(currentPlayer.getCurrentTile())
		
		if(playerTracker.getCurrentTurnSequence() != "Roll"):
			$RollDice.hide()
		else:
			$RollDice.show()
		
		if(playerTracker.getCurrentTurnSequence() == "Dialogue" or playerTracker.getCurrentTurnSequence() == "Confirm"):
			$DialogueBox.show()
		else:
			$DialogueBox.hide()
		
		
		if(playerTracker.getCurrentTurnSequence() != "Confirm"):
			$EndTurn.hide()
			$BackUp.hide()
			$Phase1.hide()
			$UseBackUp.hide()
			$CoLicense.hide()
			$Phase2.hide()
		else:
			#EndTurn.show()
			showButtons()
		
	else:
		_showAll(false)
		_showWarning("Warning! No players found in the scene.")


func showButtons():
	match currentPlayer.getCurrentLevel():
		1:
			$EndTurn.show()
		2:
			match currentPlayer.getCurrentTile():
				1,2,3:
					$EndTurn.show()
				4,5,6:
					$EndTurn.show()
					$BackUp.show()
		3:
			match currentPlayer.getCurrentTile():
				1,2,3,6:
					$Phase1.show()
					if currentPlayer.getPlayerBackups()>0:
						$UseBackUp.show()
				4,5:
					$EndTurn.show()
		4:
			$EndTurn.show()
		5:
			match currentPlayer.getCurrentTile():
				1 , 2:
					$Phase1.show()
					if currentPlayer.getPlayerBackups()>0:
						$UseBackUp.show()
				3,4,5,6:
					$EndTurn.show()
		6:
			match currentPlayer.getCurrentTile():
				1,2,6:
					$EndTurn.show()
				3,4,5:
					$Phase1.show()
					if currentPlayer.getPlayerBackups()>0:
						$UseBackUp.show()
					$CoLicense.show()
		7:
			match currentPlayer.getCurrentTile():
				1,3,4,5:
					$EndTurn.show()
				2:
					$Phase1.show()
					if currentPlayer.getPlayerBackups()>0:
						$UseBackUp.show()
					$CoLicense.show()
				6:
					$EndTurn.show()
		8:
			match currentPlayer.getCurrentTile():
				1,3,4:
					$EndTurn.show()
				2:
					$Phase1.show()
					if currentPlayer.getPlayerBackups()>0:
						$UseBackUp.show()
					$CoLicense.show()
				5,6:
					$Phase2.show()
		9:
			$EndTurn.show()
		10:
			$EndTurn.show()


func _on_RollDice_pressed():
	var roll = randi()%6 + 1
	currentPlayer.setCurrentTile(roll)
	connect("transfer_phaseandroll", get_node("DialogueBox/Dialogue"), "_on_transfer_phaseandroll")
	emit_signal("transfer_phaseandroll", int(currentPlayer.getCurrentLevel()), int(currentPlayer.getCurrentTile()))
	playerTracker.nextInTurnSequence()
	



#Change the active level of the parent camera object
func _on_OptionButton_item_selected(id):
	if(id == 0):
		id = currentPlayer.getCurrentLevel()
	get_parent().SetActiveLevelNumber(id)


func _on_MoreInfo_pressed():
	var infoLevels = ["https://www.pfizer.com/health-wellness/healthy-living/brain-nervous-system",
			"https://www.pfizer.com/health-wellness/healthy-living/heart-cardiovascular",
			"https://www.pfizer.com/health-wellness/healthy-living/cold-and-flu",
			"https://www.pfizer.com/health-wellness/healthy-living/digestive",
			"https://www.pfizer.com/health-wellness/healthy-living/healthy-aging",
			"https://www.pfizer.com/health-wellness/healthy-living/quit-smoking",
			"https://www.pfizer.com/health-wellness/healthy-living/mens-health",
			"https://www.pfizer.com/health-wellness/healthy-living/mental-health",
			"https://www.pfizer.com/health-wellness/healthy-living/diet-exercise"]
	OS.shell_open(infoLevels[currentPlayer.getCurrentLevel() - 1])
