extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Jumping")
	player.jump_power = Vector2.ZERO

func physics_process(_delta):
#	var desired_velocity = get_input() * max_speed
#	player.velocity = player.move_and_slide(player.velocity, Vector2(0,1), true)
#	player.velocity.y -= player.gravity.y * delta
	if not player.is_on_floor():
		player.velocity += player.move_speed * player.move_vector() + player.gravity
		player.move_and_slide(player.velocity, Vector2.UP)
#	if player.is_moving():
#		player.jump_power.x = clamp(player.jump_power.x + (player.move_vector().x * player.leap_speed), -player.max_leap, player.max_leap)
	if Input.is_action_pressed("jump"):
		player.jump_power.y = clamp(player.jump_power.y - player.jump_speed, -player.max_jump, 0)
#		if "jump" and player.is_on_floor():
#			player.jump_power.y += player.jump_speed
#			player.velocity.y += player.jump_speed
#			player.move_and_slide(player.velocity, Vector2.UP)	#added this line

	else:
		player.velocity.y = 0
		player.velocity += player.jump_power
		player.move_and_slide(player.velocity, Vector2.UP)
		SM.set_state("Falling")

#	SM.get_node("WallJump").check_walljump()
