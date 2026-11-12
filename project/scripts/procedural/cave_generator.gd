class_name CaveGenerator
extends RefCounted

static func generate(width: int, height: int, fill_percent: int, iterations: int, seed_value: int) -> Array[PackedInt32Array]:
    var rng := RandomNumberGenerator.new()
    rng.seed = seed_value
    var grid: Array[PackedInt32Array] = []
    for y in range(height):
        var row := PackedInt32Array()
        for x in range(width):
            row.append(1 if rng.randi_range(0, 99) < fill_percent else 0)
        grid.append(row)
    for _iteration in range(iterations):
        var next_grid: Array[PackedInt32Array] = []
        for y in range(height):
            var row := PackedInt32Array()
            for x in range(width):
                var walls := _neighbor_walls(grid, x, y, width, height)
                row.append(1 if walls >= 5 else 0)
            next_grid.append(row)
        grid = next_grid
    return grid

static func _neighbor_walls(grid: Array[PackedInt32Array], x: int, y: int, width: int, height: int) -> int:
    var total := 0
    for oy in range(-1, 2):
        for ox in range(-1, 2):
            if ox == 0 and oy == 0:
                continue
            var nx := x + ox
            var ny := y + oy
            if nx < 0 or ny < 0 or nx >= width or ny >= height:
                total += 1
            else:
                total += grid[ny][nx]
    return total
