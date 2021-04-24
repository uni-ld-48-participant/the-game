extends Node

const TileTypes = {
	Empty = {
		cell_type = 2,
		durability = 0,
		conductivity = 1,
		temperature = 3,
		static = false
	},
	Dirt = {
		cell_type = 3,
		durability = 100,
		conductivity = 3,
		temperature = 3,
		static = false
	},
	Rock = {
		cell_type = 3,
		durability = 0,
		conductivity = 3,
		temperature = 10,
		static = false
	},
	Metal = {
		cell_type = 3,
		durability = 500,
		conductivity = 10,
		temperature = 10,
		static = false
	},
	Coal = {
		cell_type = 3,
		durability = 500,
		conductivity = 3,
		temperature = 10,
		static = false
	},
	Ice = {
		cell_type = 3,
		durability = 1000,
		conductivity = 0,
		temperature = 0,
		static = true
	}
}
