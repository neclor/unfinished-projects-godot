extends AnimatedSprite2D
class_name AttackAnimatedSprite


#region Animation var
var animation_name := "normal_melee_attack"
#endregion


func _ready():
	self.visible = false


#region Animation functions
func start_animation():
	self.visible = true
	self.play(animation_name)

func _on_animation_finished():
	self.visible = false
#endregion
