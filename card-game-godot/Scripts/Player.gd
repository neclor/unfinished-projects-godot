extends Node

const start_rank = 4

const max_rank = 5
const min_rank = 1

const ranks = {
	5 : "King",
	4 : "Prince",
	3.5 : "Merchant",
	3 : "Citizen",
	2.5 : "Servant",
	2 : "Poor",
	1 : "Beggar",
	0 : "Dead"
}

var player_id
var player_name

var in_game

var rank

var card
var kings

func init(id, _name):
	player_id = id
	player_name = _name

	$Name.text = player_name

	in_game = true

	rank = start_rank

	card = []
	kings = []

	update_rank()

func update_rank():
	$Rank.text = ranks[rank]

func increase_rank():
	if (in_game):
		match rank:
			max_rank:
				print("")

			3.5:
				rank = 4

			2.5:
				print("")

			2:
				rank = 2.5

			_:
				rank += 1

		update_rank()

func demote_rank():
	if (in_game):
		match rank:
			3.5:
				rank = 3

			2.5:
				rank = 2

			min_rank:
				rank = 0
				in_game = false

			_:
				rank -= 1

		update_rank()







