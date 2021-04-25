extends Node
var Dirt : TileType
var Empty : TileType
var Rock : TileType
var Metal : TileType
var Coal : TileType

var All:Array

func _init():
	Empty = TileType.new()
	Empty.cell_type = 0
	Empty.generation_max_width = 15
	Empty.generation_max_height = 4
	Empty.vertcal_distance = 0
	
	Dirt = TileType.new()
	Dirt.cell_type = 1
	Dirt.hp = 100
	Dirt.generation_max_width = 12
	Dirt.generation_max_height = 4
	Dirt.vertcal_distance = 0

	Rock = TileType.new()
	Rock.cell_type = 2
	Rock.hp = 100000
	Rock.generation_max_width = 12
	Rock.generation_max_height = 2
	Rock.vertcal_distance = 1
	Rock.horizontal_limit = 3

	Metal = TileType.new()
	Metal.cell_type = 3
	Metal.hp = 500
	Metal.generation_max_width = 12
	Metal.generation_max_height = 2
	Metal.vertcal_distance = 5

	Coal = TileType.new()
	Coal.cell_type = 4
	Coal.hp = 500
	Coal.generation_max_width = 3
	Coal.generation_max_height = 3
	Coal.vertcal_distance = 2	
	Coal.horizontal_limit = 4
	
	All = [Empty, Dirt, Rock, Metal, Coal]
