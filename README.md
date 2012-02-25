# Curry

Adds currying and function composition to Ruby 1.8.


# Examples

	sum = foldl1[:+.to_proc]
	product = foldl1[:*.to_proc]

	puts product[(1..10).to_a]
