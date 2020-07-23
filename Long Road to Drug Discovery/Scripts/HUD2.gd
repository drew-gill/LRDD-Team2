extends Node
class_name HUD2


var currentPlayerNumber
var currentPlayer

#signal transfer_phaseandroll
signal beginMoving

func _ready():
	_showAll(false)
	$Start.show()
	
	

func _on_Start_pressed():
	_showAll(true)
	$Start.hide()
	
func toggleDialogueBox():
	if(!$DialogueBox.visible):
		$DialogueBox.show()
		$DialogueBox/Dialogue.resetText()
	else:
		$DialogueBox.hide()
		
		
func _showAll(boolean):
	if(boolean == true):
		$Start.show()
		$AddYear.show()
		$AddMoney.show()
		$SubtractMoney.show()
		$SubtractYear.show()
		$Money.show()
		$Years.show()
		$BackupFormulations.show()
		$DialogueBox.show()

	else:
		$Start.hide()
		$AddYear.hide()
		$AddMoney.hide()
		$SubtractMoney.hide()
		$SubtractYear.hide()
		$Money.hide()
		$Years.hide()
		$BackupFormulations.hide()
		$DialogueBox.hide()

	
	#always hide the warning, only want this when specifically called.
	$Warning.hide()
	
func _showWarning(text):
	$Warning.text = text
	$Warning.show()

func _on_AddMoney_pressed():
	currentPlayer.alterPlayerMoney(1000)

func _on_SubtractMoney_pressed():
	currentPlayer.alterPlayerMoney(-1000)


func _on_AddYear_pressed():
	currentPlayer.alterPlayerYears(1)


func _on_SubtractYear_pressed():
	currentPlayer.alterPlayerYears(-1)

func _on_EndTurn_pressed():
	$"../PlayerTracker".endTurn()

	

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
	currentPlayer = get_node("../Player")
	if(currentPlayer != null):
		$Money.text = "Money: $" + addCommas(currentPlayer.getPlayerMoney())
		$Years.text = "Years left: " + str(currentPlayer.getPlayerYears())
		$BackupFormulations.text = "Backup Formulations: " + str(currentPlayer.getPlayerBackups())
		$PlayerTurn.text = "Player " + str(currentPlayerNumber) +"'s Turn!"
		#print(str(currentPlayer.getCurrentLevel()) + ":" + str(currentPlayer.getCurrentTile()))
		$LevelText.text = "Level: " + str(currentPlayer.getCurrentLevel()) + "\n Roll: " + str(currentPlayer.getCurrentTile())
		
	else:
		_showAll(false)
		_showWarning("Warning! No players found in the scene.")




func _on_RollDice_pressed():
	var roll = randi()%6 + 1
	currentPlayer.setCurrentTile(roll)
	emit_signal("beginMoving")
	#connect("transfer_phaseandroll", get_node("DialogueBox/Dialogue"), "_on_transfer_phaseandroll")
	#emit_signal("transfer_phaseandroll", int(currentPlayer.getCurrentLevel()), int(currentPlayer.getCurrentTile()))
	
