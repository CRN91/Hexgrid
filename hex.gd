# The 6 direction vectors for cube coordinates
var cube_direction_vectors = [
#   E                    NE                   NW                                    
	Vector3i(+1, 0, -1), Vector3i(+1, -1, 0), Vector3i(0, -1, +1), 
#   W                    SW                   SE
	Vector3i(-1, 0, +1), Vector3i(-1, +1, 0), Vector3i(0, +1, -1), 
]

func axial_to_cube(ax):
	return Vector3i(ax.x, ax.y, -(ax.x + ax.y))

# Converts axial to odd right offset coordinates
func axial_to_oddr(hex):
	var col = hex.x + (hex.y - (hex.y&1)) / 2
	var row = hex.y
	return Vector2i(col, row)
	
func oddr_to_axial(hex):
	var q = hex.x - (hex.y - (hex.y&1)) / 2
	var r = hex.y
	return Vector2i(q, r)

# Returns the distance between two cube coordinates
func cube_distance(a, b):
	var vec = a - b
	return max(abs(vec.x), abs(vec.y), abs(vec.z)) 

# Returns the neighbouring hex in a given direction
func cube_neighbor(cube, direction):
	return cube + cube_direction_vectors[direction]

# Returns a list of cube coordinates that make up a ring of hexagons
# of radius distance away from the center
func cube_ring(center, radius):
	var results = []
	var hex = center + cube_direction_vectors[4] * radius

	for i in range(6):
		for j in range(radius):
			results.append(hex)
			hex = cube_neighbor(hex, i)
	return results

# Returns a list of cube coordinates that make up a spiral hexagons
func cube_spiral(center, radius):
	var results = [center]
	for k in range(1,radius):
		results = results + cube_ring(center, k)
	return results
