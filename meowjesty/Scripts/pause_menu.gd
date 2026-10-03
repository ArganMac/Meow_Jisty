extends Control

@export var died_scene: PackedScene

func resume():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func test_esc():
	if !get_tree().paused and Input.is_action_just_pressed("esc"):
		pause()
	elif get_tree().paused and Input.is_action_just_pressed("esc"):
		resume()

func _ready() -> void:
	resume()

func _process(delta):
	if get_tree().current_scene == died_scene:
		pause()
		$"PanelContainer/VBoxContainer/Resume".visible = false
	test_esc()

func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	if get_tree().current_scene == died_scene:
		get_tree().change_scene_to_file("res://level_2.tscn")
	else:
		get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
