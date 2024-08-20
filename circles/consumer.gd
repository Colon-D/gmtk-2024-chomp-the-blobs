extends Node

# skips processing some circles to avoid lag (only needed if like 300+ circles)
# even then, the problem is exponential, not linear, so not the best solution
var i_cont = 0
const i_size = 32

@onready var circle = $".."

signal on_consume(consumer, other)

func consume(consumer, other):
	other.on_consumed.emit()
	other.queue_free()

	consumer.area += other.area

	on_consume.emit(consumer, other)

func _physics_process(_delta: float) -> void:
	var circles = get_tree().get_nodes_in_group("circle")

	if i_cont >= circles.size():
		i_cont = 0

	for i in range(i_cont, min(circles.size(), i_cont + i_size), 1):
		var other = circles[i]
		if other == circle:
			continue

		# needs to be 25% bigger in radius (should this be area?)
		# spikes don't have this ratio requirement
		if circle.get_relative_size(other) != circle.relative_size.SMALL:
			continue;

		var distance = other.position.distance_to(circle.position)
		# needs to be over 50% consumed, thus other radius is not added
		if distance < circle.radius:
			# spikes split circles, but are still consumed
			if other.is_in_group("spike"):
				consume(circle, other)
				circle.call_deferred("explode")
			# don't want the boss to get eaten by its own attacks
			elif other.is_in_group("boss") and not circle.is_in_group("player"):
				other.position = circle.position
				consume(other, circle)
			else:
				consume(circle, other)
		
	i_cont += i_size
