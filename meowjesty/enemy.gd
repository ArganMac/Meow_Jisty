extends CharacterBody2D
class_name Enemy


var SPEED = -500.0
const JUMP_VELOCITY = -400.0
var YSPEED = -200.0
var is_dead = false
var in_player = false
var health = 100


func _physics_process(delta: float) -> void:
	if position.x < -20:
		check_accuracy()
		queue_free()
	
	
	
	# Add the gravity.
	if not is_on_floor() and not is_dead:
		velocity += get_gravity() * delta
	elif is_dead:
		velocity.y = YSPEED

	# Continuously moving
	velocity.x = SPEED
	
		
	if is_dead:
		$"AnimatedSprite2D".animation = "hurt"
		SPEED = -300
		
	move_and_slide()
	
	
func take_damage() -> void:
	is_dead = true
	
func check_accuracy() -> void:
	var diff = position.x - $"../player".position.x
	if diff > 85 and diff < 145:
		$"../player".indicator = "Perfect"
		$"../player".score += 300
		$"../player".hits += 1.0
		$"../KillTimer".start()
	elif diff > 0 and diff < 145:
		$"../player".indicator = "Okay"
		$"../player".score += 100
		$"../player".hits += 0.5
		$"../KillTimer".start()
	elif diff < 0:
		$"../player".indicator = "Miss"
	
	$"../player".total += 1
		
	pass

func _on_attack_area_body_entered(body: Node2D) -> void:
	
	if body is Player:
		in_player = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	in_player = false
	
func set_dead(isDead: bool) -> void:
	is_dead = isDead


func _on_kill_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
