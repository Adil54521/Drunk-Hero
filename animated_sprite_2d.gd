extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -400.0
@onready var animated_sprite = $AnimatedSprite2D
@export var jump_impulse = 200

var is_attacking = false
var is_jumping = false
var is_moving = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		is_attacking = true
		animated_sprite.play("fight")	
	elif Input.is_action_just_pressed("ui_select") and is_on_floor():
		jump()
	elif not is_attacking and not is_jumping:
		move()
		
	move_and_slide()
	
	if is_on_floor():
		is_jumping = false
	
		
func jump():
	velocity.y = JUMP_VELOCITY
	is_jumping = true
	animated_sprite.play("jump")
	
func move():
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")
		
func attack():
	if Input.is_physical_key_pressed(KEY_F):
		animated_sprite.play("fight")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	print("Function is workin")
	is_attacking = false
