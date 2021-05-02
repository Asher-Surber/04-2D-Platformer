extends Node

const SAVE_PATH = "user://savegame.sav"
const SECRET = "When will I finish one game"
var save_file = ConfigFile.new()

var save_data = {
	"general": {
		"score":0
		,"health":100
		,"enemies":[]
		,"gems":[]
		,"gem_count":0
		,"level": level
	}
}

export var gems = []
export var gem_count = 0

func level_complete():
	if gem_count == 4:
		level = levels[2]
		get_tree().change_scene(levels[2])

export var levels = {1 : "res://Levels/Level1.tscn", 2 : "res://Levels/Level2.tscn"}
export(String) var level = levels[1]

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("save"):
		save_game()
	if event.is_action_pressed("load"):
		load_game()

var fade = null
var fade_speed = 0.015

var fade_in = false
var fade_out = ""

var death_zone = 1000


func _physics_process(_delta):
	if fade == null:
		fade = get_node_or_null("/root/Game/Camera/Fade")
	if fade_out != "":
		execute_fade_out(fade_out)
	if fade_in:
		execute_fade_in()
		

func start_fade_in():
	if fade != null:
		fade.visible = true
		fade.color.a = 1
		fade_in = true

func start_fade_out(target):
	if fade != null:
		fade.color.a = 0
		fade.visible = true
		fade_out = target

func execute_fade_in():
	if fade != null:
		fade.color.a -= fade_speed
		if fade.color.a <= 0:
			fade_in = false

# warning-ignore:unused_argument
func execute_fade_out(target):
	if fade != null:
		fade.color.a += fade_speed
		if fade.color.a >= 1:
			fade_out = ""

func save_game():
	save_data["general"]["enemies"] = []
	save_data["general"]["gems"] = []
	for e in $Enemy_Container.get_children():
		save_data["general"]["enemies"].append(var2str(e.position))
	for g in gems:
		save_data["general"]["gems"].append(var2str(g))
	save_data["general"]["gem_count"] = gem_count

	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)
	save_game.store_string(to_json(save_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)
	var contents = save_game.get_as_text()
	var result_json = JSON.parse(contents)
	if result_json.error == OK:
		save_data = result_json.result
	else:
		print("Error: ", result_json.error)
	save_game.close()
	
	var _scene = get_tree().change_scene_to(level)
	call_deferred("restart_level")
