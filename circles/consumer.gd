extends Node

# skips processing some circles to avoid lag (only needed if like 300+ circles)
# even then, the problem is exponential, not linear, so not the best solution
var i_cont = 0
const i_size = 32

@onready var e = $".."

func _physics_process(_delta: float) -> void:
	var circles = get_tree().get_nodes_in_group("circle")

	if i_cont >= circles.size():
		i_cont = 0

	for i in range(i_cont, min(circles.size(), i_cont + i_size), 1):
		var circle = circles[i]
		if circle == self:
			continue
		
		var ratio = e.radius / circle.radius
		# needs to be 25% bigger in radius (should this be area?)
		if ratio < 1.25:
			continue;

		var distance = circle.position.distance_to(e.position)
		# needs to be over 50% consumed, thus other radius is not added
		if distance < e.radius:
			circle.queue_free()

			var area = e.radius * e.radius * PI
			var other_area = circle.radius * circle.radius * PI

			area += other_area

			e.radius = sqrt(area / PI)
		
	i_cont += i_size
