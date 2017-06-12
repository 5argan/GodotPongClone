extends KinematicBody2D

const speed = 100
var projectResolution=Vector2(Globals.get("display/width"),Globals.get("display/height"))
var size = Vector2()

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	size.x = get_scale().x * get_node("Sprite").get_item_rect().size.x
	size.y = get_scale().y * get_node("Sprite").get_item_rect().size.y
	
func _fixed_process(delta):
	var move_vector = Vector2(0, 0)
	if (Input.is_action_pressed("move_right")):
		move_vector.x = speed * delta
	if (Input.is_action_pressed("move_left")):
		move_vector.x = move_vector.x - speed * delta
	if (Input.is_action_pressed("move_down")):
		move_vector.y = speed * delta
	if (Input.is_action_pressed("move_up")):
		move_vector.y = move_vector.y - speed * delta
		
	var remaining_movement = move(move_vector)
	if is_colliding(): #fix objects getting stuck on collision
		var normal = get_collision_normal()
		var final_movement = normal.slide(remaining_movement)
		move(final_movement)
	
	var pos = get_pos()
	pos.x = clamp(pos.x, size.x/2, projectResolution.x/2 - size.x/2)
	pos.y = clamp(pos.y, size.y/2, projectResolution.y - size.y/2)
	move_to(pos)
	
