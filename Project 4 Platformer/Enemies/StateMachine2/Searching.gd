extends Node

onready var SM = get_parent()
onready var enemy1 = get_node("../..")
onready var floorAheadCheck = enemy1.get_node("floorAheadCheck")
onready var checkRight = enemy1.get_node("checkRight")
onready var checkLeft = enemy1.get_node("checkLeft")
onready var animSprite = enemy1.get_node("AnimatedSprite")


func _ready():
	yield(enemy1, "ready")

func start():
	enemy1.set_animation("walk right")

func _physics_process(_delta):
	if floorAheadCheck.is_colliding() == true:
		enemy1.velocity.x = 1
		enemy1.move_and_slide(Vector2(enemy1.speed,0), enemy1.velocity)
	if floorAheadCheck.is_colliding() == false:
#		enemy1.speed = 0
		enemy1.velocity.x *= -1
		enemy1.speed *= -1
		enemy1.move_and_slide(Vector2(enemy1.speed,0), enemy1.velocity)
		if animSprite.animation == "walk right":
			enemy1.set_animation("walk left")
		elif animSprite.animation == "walk left":
			enemy1.set_animation("walk right")
		if checkRight.is_colliding() == true or checkLeft.is_colliding() == true:
			SM.set_state("Attacking")
	
