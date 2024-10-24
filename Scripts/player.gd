extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		if direction != 0:
			animated_sprite_2d.play("Run")

	if not is_on_floor():
		if velocity.y > 0:
			animated_sprite_2d.play("Fall")
		if velocity.y < 0:		
			animated_sprite_2d.play("Jump")
			
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0: 
		animated_sprite_2d.flip_h = true
		
	move_and_slide()
