extends Label

func change_label():
	if Global.gem_count == 0:
		text = "Gems: 0/4"
	if Global.gem_count == 1:
		text = "Gems: 1/4"
	if Global.gem_count == 2:
		text = "Gems: 2/4"
	if Global.gem_count == 3:
		text = "Gems: 3/4"
	if Global.gem_count == 4:
		text = "Gems: 4/4"
