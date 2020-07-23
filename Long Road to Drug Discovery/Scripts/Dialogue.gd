extends RichTextLabel

var dialogPhase1 = ["Phase 1: Build and test molecules for activity (in vitro)\nAt this step, the basic drug molecule is contructed then tested to see if it binds to cells in a test tube and produces an effect",
"1:  Your test molecule does not bind to the site where it would be active.  Do not advance \nCost:  40M + 1YR \nTry Again",
"2:  You had to spend extra time altering the formula for your drug because it does not bind to target organ \nCost: 60M + 2YR \nAdvance!",
"3 or 4:  Your drug binds to the target organ, but does not have any activity – it doesn’t seem to cause any changes.  You need to spend extra time and money on reformulation \nCost: 80M + 2YR. \nAdvance!",
"5 or 6:  Molecule binds to target and shows good activity.  \nCost 40M + 1YR \nAdvance!"]

var dialogPhase2 = ["Phase 2: Test molecules for biological activity (in vivo) \nAt this step molecules are tested in animals (usually a mouse or rat) to determine whether they have a measurable biologic effect",
"1: Poor absorption – Your molecule doesn’t get to the bloodstream.\nCost: 40M + 1Y\nTry again",
"2: Poor distribution – Your molecule does not get to target organ. \nCost 40M + 1Y\nReformulate, Try again",
"3: Metabolism problem – Your molecule is changed to something else \nCost 40M + 1Y\nReformulate, Try again",
"4: Fast elimination – Your molecule is eliminated from the body before it can have an effect.  You redesign drug, but you use more money and time\nCost: 80M + 2Y\nAdvance!\n\nFor an additional 80M each, you can purchase up to 3 back-up formulations to be used as you proceed.\nHighly recommend 2!  \n\nFact:  Drugs are not tested alone, but the main compound and multiple back-ups are explored.",
"5 or 6: Compound shows good biological activity IT WORKS!\nCost 40M + 1Y\nAdvance!\n\nFor an additional 80M each, you can purchase up to 3 back-up formulations to be used as you proceed.\nWe highly recommend at least 2!\n\nFact:  Drugs are not tested alone, but the main compound and multiple back-ups are explored."]

var dialogPhase3 = ["Phase 3: Safety and Toxicity Testing\nHere, molecules are tested in animals to determine whether they are safe to put into human patients",
"1: All your rats die, your drug mechanism is unsafe!  \nCost 100M + 1Y.\nGo back to step 1 OR Use your back-up molecule and roll again",
"2: All your rats are sick with kidney or liver toxicity issues. \nCost 100M + 1Y.\nGo back to step 1 OR Use your back-up molecule and roll again",
"3: Genetic toxicity – your drug causes a genetic mutation\nCost 100M + 1Y. \nGo back to step 1 OR Use your back-up molecule and roll again",
"4 or 5:  Animal studies look good!  It is safe to test your drug on humans.\nCost $100M+ 1Y.\nAdvance",
"6:  Your rats all develop tumors after taking the drug.\nCost $100M + 1Y.\nGo back to step 1 OR Use your back-up molecule and roll again"]

var dialogPhase4 = ["Phase 4: File IND (Investigational New Drug) Application\nAt this step you file your Investigational New Drug application to enable you to do your first studies in man in the USA.",
"1:  Paperwork nightmare!   You have difficulty collecting all supporting documents and data. \nCost: $20M, 1Y\nAdvance",
"2:  FDA suggests that you add additional safety studies.  \nCost $40M + 2Y\nAdvance",
"3:  You had the foresight to schedule a pre IND meeting.  Smooth sailing through IND process. \nNo Costs!\nAdvance",
"4, 5, 6: Uneventful filing! \nNo Costs\nAdvance"]

var dialogPhase5 = ["Phase 5:  Phase 1 testing – First in Human (FIH)\nThis is where your drug is tested in healthy, young, male volunteers",
"1 or 2:  Unexpected adverse events occur – all the volunteers faint after getting the drug!  \nCost $30M + 1Y. \nGo back to Step 1 OR use your back-up molecule and start at File IND",
"3:  You have difficulty enrolling volunteers for clinical trial, so it takes longer.\nCost 40M + 2Y \nAdvance!",
"4:  You have unexpected results – Perform more testing to understand issues.  \nCosts $40M + 2Y.\nAdvance!",
"5 or 6.  SUCCESSFUL trial. \nCost 30M + 1Y \nAdvance!"]

var dialogPhase6 = ["Phase 6:  Phase 2 Clinical trials in patients!\nAt this step you test your compound in a small group of patients who actually have the disease",
"1 or 2:   Successful trials!  Drug alleviates disease conditions in patients.  \nCosts $50 million + 1Y\nAdvance!",
"3.  Drug has no effect on disease in patients.\nCost; $50M +  3Y.\nGo back to step 1 OR\na.	Use back-up formulation.  Go to step IV (File IND)\nb.	Co-license a new drug with another company.  Cost 1Y and half your profits at the end. Advance",
"4 or 5:  Unexpected side effects!\nCost $50M + 3Y \nGo back to step 1  OR\na.	Use back-up formulation.  Go to step IV (File IND)\nb.	Co-license a new drug with another company.  Cost 1Y and half your profits at the end. Advance",
"6:  Results of studies are equivocal (difficult to determine if there is a significant effect.  \nCost 50M + 3Y\nDo not Advance.  Try Again."]

var dialogPhase7 = ["Phase 7:  Phase 3 Clinical Trials\nClinical testing in a large number of patients around the world with the disease",
"1.	You have difficulty getting enough patients to enroll in your study.  Study takes an extra year \nCost 160M + 2Y\nAdvance",
"2.	Unexpected side effects occur:\nCost: 160M + 2Y \nGo back to step 1 OR\na.	 Use back-up formulation.  Go to step IV (File IND)\nb.	 Co-license a new drug with another company.  Cost 1Y and half your profits at the end. Advance",
"3.	You have poor compliance with study design. You have to restart the study with increased oversight so it takes 3 years longer.  \nCost $160M + 4Y\nAdvance!",
"4 or 5 Congratulations! Drug works to reduce disease \nCost $160M +  2Y.\nAdvance!",
"6.  Drug works exceptionally well to reduce disease in this large test population \nCost $160M + 3Y \nGet extra throw of dice at Product Launch – Take Card"]

var dialogPhase8 = ["8. File NDA for approval by the FDA.  \nAt this step your file your New Drug Application with the Food & Drug Administration to get approval to put your drug on the market as a prescription medicine.",
"1.	Paperwork nightmare!  Someone lost some important data.  FDA refuses to accept your filing. \nCost 10M + 1Y \nTry again",
"2. FDA rejects your application!\nGo back to step 1 OR\nUse back-up formulation.  Go to step IV (File IND) OR\nCo-license a new drug with another company.  Cost 1Y and half your profits at the end. Advance",
"3 or 4:  Drug is approved!!  \nCost 10M + 1Y.\nLaunch Medicine!",
"5.  FDA disagrees with your conclusions from Phase 2 and 3 clinical studies.\nCost 10M + 1Y\nGo back to Phase 2",
"6. The FDA requires additional safety studies\nCost $10M 1Y\nGo back to Phase 2"]

var dialogPhase9Part1 = ["9.  Launch your new medicine!\nRoll the dice to determine how much profit before your patent expires you will make from this medicine (to reinvest in the next drugs in your pipeline) ",
"1.  Earn $800 million/year before patent expires",
"2.  Earn $1 billion/year before patent expires",
"3.  Earn $1.5 billion/year before patent expires",
"4.	Earn $2 billion/year before patent expires",
"5.	Earn $3.5 billion/year before patent expires",
"6.	Blockbuster.  Earn $5+ billion/year before patent expires"]

var dialogPhase9Part2 = ["Roll the dice to determine the number of lives saved or helped by your medicine!",
"1.	Save 100,000 lives",
"2.	Save 250,000 lives",
"3.	Save 400,000 lives",
"4.	Save 800,000 lives",
"5.	Save 1.2 million lives",
"6.	Save 5 million lives"]

var phase = 1
var roll = 0

func setDialogue(phaseValue,rollValue):
	phase = phaseValue
	roll = rollValue
	print(phase)
	print(roll)
	_ready()

func _on_transfer_phaseandroll(phaseValue, rollValue):
	phase = phaseValue
	roll = rollValue
	_ready()

# Called when the node enters the scene tree for the first time.
func _ready():
	match phase:
		1:
			match roll:
				0:
					set_bbcode(dialogPhase1[roll])
				1:
					set_bbcode(dialogPhase1[roll])
				2:
					set_bbcode(dialogPhase1[roll])
				3,4:
					set_bbcode(dialogPhase1[3])
				5,6:
					set_bbcode(dialogPhase1[4])
		2:
			match roll:
				0:
					set_bbcode(dialogPhase2[roll])
				1:
					set_bbcode(dialogPhase2[1])
				2:
					set_bbcode(dialogPhase2[2])
				3:
					set_bbcode(dialogPhase2[3])
				4:
					set_bbcode(dialogPhase2[4])
				5,6:
					set_bbcode(dialogPhase2[5])
		3:
			match roll:
				0:
					set_bbcode(dialogPhase3[roll])
				1:
					set_bbcode(dialogPhase3[1])
				2:
					set_bbcode(dialogPhase3[2])
				3:
					set_bbcode(dialogPhase3[3])
				4,5:
					set_bbcode(dialogPhase3[4])
				6:
					set_bbcode(dialogPhase3[5])
		4:
			match roll:
				0:
					set_bbcode(dialogPhase4[roll])
				1:
					set_bbcode(dialogPhase4[1])
				2:
					set_bbcode(dialogPhase4[2])
				3:
					set_bbcode(dialogPhase4[3])
				4 , 5 , 6:
					set_bbcode(dialogPhase4[4])
		5:
			match roll:
				0:
					set_bbcode(dialogPhase5[roll])
				1 , 2:
					set_bbcode(dialogPhase5[1])
				3:
					set_bbcode(dialogPhase5[2])
				4:
					set_bbcode(dialogPhase5[3])
				5 , 6:
					set_bbcode(dialogPhase5[4])
		6:
			match roll:
				0:
					set_bbcode(dialogPhase6[roll])
				1 , 2:
					set_bbcode(dialogPhase6[1])
				3:
					set_bbcode(dialogPhase6[2])
				4 , 5:
					set_bbcode(dialogPhase6[3])
				6:
					set_bbcode(dialogPhase6[4])
		7:
			match roll:
				0:
					set_bbcode(dialogPhase7[roll])
				1:
					set_bbcode(dialogPhase7[1])
				2:
					set_bbcode(dialogPhase7[2])
				3:
					set_bbcode(dialogPhase7[3])
				4 , 5:
					set_bbcode(dialogPhase7[4])
				6:
					set_bbcode(dialogPhase7[5])
		8:
			match roll:
				0:
					set_bbcode(dialogPhase8[roll])
				1:
					set_bbcode(dialogPhase8[1])
				2:
					set_bbcode(dialogPhase8[2])
				3 , 4:
					set_bbcode(dialogPhase8[3])
				5:
					set_bbcode(dialogPhase8[4])
				6:
					set_bbcode(dialogPhase8[5])
		9:
			match roll:
				0:
					set_bbcode(dialogPhase9Part1[roll])
				1:
					set_bbcode(dialogPhase9Part1[1])
				2:
					set_bbcode(dialogPhase9Part1[2])
				3:
					set_bbcode(dialogPhase9Part1[3])
				4:
					set_bbcode(dialogPhase9Part1[4])
				5:
					set_bbcode(dialogPhase9Part1[5])
				6:
					set_bbcode(dialogPhase9Part1[6])
		10:
			match roll:
				0:
					set_bbcode(dialogPhase9Part2[roll])
				1:
					set_bbcode(dialogPhase9Part2[1])
				2:
					set_bbcode(dialogPhase9Part2[2])
				3:
					set_bbcode(dialogPhase9Part2[3])
				4:
					set_bbcode(dialogPhase9Part2[4])
				5:
					set_bbcode(dialogPhase9Part2[5])
				6:
					set_bbcode(dialogPhase9Part2[6])
	visible_characters = 0

func resetText():
	visible_characters = -1

func _on_Timer_timeout():
	visible_characters += 1
