extends Camera2D

#region Zoom var
const MIN_ZOOM = Vector2(0.25, 0.25)
const MAX_ZOOM = Vector2(4, 4)
#endregion

#region Zoom functions
func _input(_event):
	if Input.is_action_pressed("zoom_in"):
		zoom_in()

	elif Input.is_action_pressed("zoom_out"):
		zoom_out()

func zoom_in():
	if zoom < MAX_ZOOM:
		zoom *= 1.1

func zoom_out():
	if zoom > MIN_ZOOM:
		zoom /= 1.1
#endregion
