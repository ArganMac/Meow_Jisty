extends CharacterBody2D
class_name Enemy


var SPEED = -500.0
const JUMP_VELOCITY = -400.0
var YSPEED = -200.0
var is_dead = false
var in_player = false
var health = 100
var most_left


func _physics_process(delta: float) -> void:
	var diff = position.x - $"../player".position.x
	if diff < -250 and not is_dead:
		$"../player".indicator = "Miss"
		$"../player".health -= 20
		is_dead = true
		print("died")
		queue_free()
		$KillTimer.start()
	
	
	# Add the gravity.
	if not is_on_floor() and not is_dead:
		velocity += get_gravity() * delta
	elif is_dead:
		$"AnimatedSprite2D".animation = "hurt"

		velocity.y = YSPEED
		SPEED = -300
	
	velocity.x = SPEED
	move_and_slide()
		
	if is_dead:
		$AnimatedSprite2D.animation = "hurt"
		SPEED = -300
		
	
	
func take_damage() -> void:
	is_dead = true
	$KillTimer.start()
	
	
func check_accuracy() -> void:
	var diff = position.x - $"../player".position.x
	if diff > 200 and diff < 300:
		$"../player".indicator = "Perfect"
		$"../player".score += 300
		if $"../player".health < 100:
			$"../player".health += 2.5
		print("adding health by 5")
	elif diff > 100 and diff < 400:
		$"../player".indicator = "Okay"
		$"../player".score += 100
		print("OKAY")
	elif diff <= 100 or diff > 400:
		$"../player".indicator = "Miss"
		$"../player".health -= 10
		print("lowering health by 20")
		print("lowering health by 20")
	print("HIT REGISTERED")

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		in_player = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	in_player = false
	
func set_dead(isDead: bool) -> void:
	is_dead = isDead

#func get_most_left():
	#var leftest = $"../".instantiate()
	#for enemy in Enemy:
	#	if enemy.position.x < leftest:
	#		leftest = enemy
	#return leftest
	
func _on_kill_timer_timeout() -> void:
	queue_free()
	pass
