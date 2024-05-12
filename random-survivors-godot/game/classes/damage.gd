class_name Damage


#region Damage var
enum Type {
	NONE,
	MELEE,
	SHOT,
	MAGIC,
}
enum Element {
	NONE,
	FIRE,
	CRYO,
	SHOCK,
	POISON,
	EXPLOSIVE,
}

var damage_type : Type
var damage_element : Type
var damage_power := 0
#endregion


#region Init functions
func _init(new_damage_power: int, new_damage_type: Type = Type.NONE, new_damage_element: Type = Type.NONE):
	damage_power = new_damage_power
	damage_type = new_damage_type
	damage_element = new_damage_element
#endregion


#region Damage functions

#endregion
