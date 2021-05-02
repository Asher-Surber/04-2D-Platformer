extends Area2D

#onready var player = get_node("/root/Level1/Player_Container/Player")


func _on_Red_Gem_body_entered(body):
	Global.gems.append(position)
	Global.gem_count += 1
	queue_free()
