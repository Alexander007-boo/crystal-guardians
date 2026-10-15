extends Node2D

@onready var interactive_area: Area2D = $InteractiveArea
var player_nearby: bool = false

func _ready() -> void:
	interactive_area.body_entered.connect(
		_on_interactive_area_body_entered
	)
	interactive_area.body_exited.connect(
		_on_interactive_area_body_exited
	)
	
func _process(delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("interact"):
		interact()

func interact() -> void:
	var dialogue_ui = get_tree().current_scene.get_node("DialogueUI")
	if dialogue_ui.is_open:
		return
	match QuestManager.quest_state:
		QuestManager.QuestState.NOT_STARTED:
			dialogue_ui.show_dialogue(
				"Han Solo",
				[
					"Guardian, necesito tu ayuda!",
					"Los enemigos han dispersado los 3 cristales mágicos
					alrededor de la ciudad",
					"Recupéralos rápido y tráemelos antes de que se
					pierdan"
				]
			)
			QuestManager.start_quest()
		QuestManager.QuestState.ACTIVE:
			dialogue_ui.show_dialogue(
				"Han Solo",
				[
					"Todavía faltan cristales.",
					"Solo encontraste %d de %d" % [
						QuestManager.collected_crystals,
						QuestManager.required_crystals
					]
				]
			)
		QuestManager.QuestState.READY_TO_DELIVER:
			dialogue_ui.show_dialogue(
				"Han Solo",
				[
					"Perfecto!, muchas gracias por ayudarme",
					"Has recuperado todos los cristales a tiempo.",
					"Ahora podemos activar el portal."
				]
			)
			QuestManager.complete_quest()
		QuestManager.QuestState.COMPLETED:
			dialogue_ui.show_dialogue(
				"Han Solo",
				[
					"Gracias por tu gran ayuda!",
					"El portal está listo para ser utilizado.",
					"Buen viaje!"
				]
			)

func _on_interactive_area_body_entered(body: Node2D) -> void:
	#COMPLETAR CORROBORANDO QUE SEA EL PLAYER EL QUE INGRESE A SU ZONA
	pass # Replace with function body.


func _on_interactive_area_body_exited(body: Node2D) -> void:
	#COMPLETAR CORROBORANDO QUE SEA EL PLAYER EL QUE SALGA A SU ZONA
	pass # Replace with function body.
