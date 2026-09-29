extends Control

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
	test_esc()

func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
