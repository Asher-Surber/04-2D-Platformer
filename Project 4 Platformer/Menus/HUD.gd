extends Control

func win_label():
	if Global.gem_count == 4 and Global.level == Global.levels[2]:
		$Win.visible
