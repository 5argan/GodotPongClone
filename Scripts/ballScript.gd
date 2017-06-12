extends KinematicBody2D

const velocity = Vector2(-100, 0)
const speed = 200
const MAXBOUNCEANGLE = 75
var direction = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var remaining_movement = move(velocity*delta)
	if is_colliding(): #fix objects getting stuck on collision
		var target = get_collider()
		var normal = get_collision_normal()
		
		var final_movement = normal.slide(remaining_movement)
		move(final_movement)
		
		if target.is_in_group("paddles"):
			var bounce_angle = get_bounce_angle(get_pos().y, target.get_pos().y, target.size.y)
			bounce_off_bat(bounce_angle)
		else:
			bounce_off_wall()

func get_bounce_angle(my_pos_y, target_pos_y, target_size_y):
	var relative_y = my_pos_y - target_pos_y;
	var normalized_y = (relative_y/(target_size_y/2));
	return normalized_y * MAXBOUNCEANGLE / 360 * 2 * PI;
	
func bounce_off_bat(bounce_angle):
	direction = direction * -1
	velocity.x = direction * speed * cos(bounce_angle)
	velocity.y = speed * sin(bounce_angle)

func bounce_off_wall():
	velocity.y = -velocity.y