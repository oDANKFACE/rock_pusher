extends CharacterBody2D

# Necessary loaded and exported variables
@export var spd: int = 35
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

# Player node constants
const walk_handle = "walk_"
const idle_handle = "idle_"

# Player node variables
var direction = "down"
var pushed_object = null


# Checks the player input and sets velocity.
# Checks velocity and sets direction
func handleInput():
	var move_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_dir * spd
	
	# Save previous direction to check for direction change below
	var prev_direction = direction
	
	if velocity.x > 0:
		direction = "right"
	elif velocity.x < 0:
		direction = "left"
	elif velocity.y < 0:
		direction = "up"
	elif velocity.y > 0:
		direction = "down"
	
	# If no input, velocity is 0 and direction remains unchanged
	
	# Check for direction change
	if prev_direction != direction:
		handleDirectionChange()
		
	if pushed_object:
		var force = 100
		pushed_object.apply_central_force(velocity * force)

# Checks if the new direction is left. 
# If so, flip the sprite. If not, set sprite to normal direction.
func handleDirectionChange():
	if direction == "left":
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
# Checks status and plays respective animation
func handleAnimation():
	if velocity.length() == 0:
		animation.play(idle_handle + direction)
	else:
		animation.play(walk_handle + direction)


func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleAnimation()



func _on_area_2d_body_entered(body):
	if body is RigidBody2D:
		pushed_object = body


func _on_area_2d_body_exited(body):
	if body is RigidBody2D:
		pushed_object = null
