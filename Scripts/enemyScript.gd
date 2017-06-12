extends KinematicBody2D

const speed = 150
var projectResolution=Vector2(Globals.get("display/width"),Globals.get("display/height"))
var size = Vector2()

func _ready():
	randomize()
	set_fixed_process(true)
	size.x = get_scale().x * get_node("Sprite").get_item_rect().size.x
	size.y = get_scale().y * get_node("Sprite").get_item_rect().size.y
	
func _fixed_process(delta):
	var move_vector = Vector2(0, 0)
	
	var ball_y = get_node("../Ball").get_pos().y
	var current_y = get_pos().y
	var rand = randi() % 5
	
	if ball_y < current_y:
		rand = -1 #* rand
	else:
		rand = 1
	move_vector.y = speed * delta * rand
			
	var remaining_movement = move(move_vector)
	if is_colliding(): #fix objects getting stuck on collision
		var normal = get_collision_normal()
		var final_movement = normal.slide(remaining_movement)
		move(final_movement)
