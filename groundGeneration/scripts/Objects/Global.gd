extends Node
var Dirt : TileType
var Empty : TileType
var Rock : TileType
var Metal : TileType
var Coal : TileType
var Ice : TileType

func _init():
	Empty = TileType.new()
	Empty.cell_type = 0
	Empty.hp = 0
	Empty.conductivity = 1
	Empty.temperature = 3
	Empty.static = false
	Empty.generation_max_width = 20
	Empty.generation_max_height = 5
	Empty.vertcal_distance = 0
	
	Dirt = TileType.new()
	Dirt.cell_type = 1
	Dirt.hp = 100
	Dirt.conductivity = 3
	Dirt.temperature = 3
	Dirt.static = false
	Dirt.generation_max_width = 12
	Dirt.generation_max_height = 4
	Dirt.vertcal_distance = 0

	Rock = TileType.new()
	Rock.cell_type = 2
	Rock.hp = 100000
	Rock.conductivity = 3
	Rock.temperature = 10
	Rock.static = false
	Rock.generation_max_width = 8
	Rock.generation_max_height = 4
	Rock.vertcal_distance = 1

	Metal = TileType.new()
	Metal.cell_type = 3
	Metal.hp = 500
	Metal.conductivity = 10
	Metal.temperature = 10
	Metal.static = false
	Metal.generation_max_width = 12
	Metal.generation_max_height = 2
	Metal.vertcal_distance = 5

	Coal = TileType.new()
	Coal.cell_type = 4
	Coal.hp = 500
	Coal.conductivity = 3
	Coal.temperature = 10
	Coal.static = true
	Coal.generation_max_width = 3
	Coal.generation_max_height = 4
	Coal.vertcal_distance = 2

	Ice = TileType.new()
	Ice.cell_type = 5
	Ice.hp = 1000
	Ice.conductivity = 0
	Ice.temperature = 0
	Ice.static = true
	Ice.generation_max_width = 9
	Ice.generation_max_height = 4
	Ice.vertcal_distance = 6
