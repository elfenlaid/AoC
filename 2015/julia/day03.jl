### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 58fa96b2-e84a-11ed-27a3-7df456671fd3
using Test

# ╔═╡ 639e3fe0-759a-4fe8-ab9d-d1bdcfe6155e
md"""
# Day 3
"""

# ╔═╡ 301dcef2-fea4-4831-80b0-3d640ef25b6a
input = read("day03.txt", String) |> strip

# ╔═╡ 4d2d31f7-ad02-4444-ae84-99e033e6f4b0
md"""
`>` delivers presents to `2` houses: one at the starting location, and one to the east.
"""

# ╔═╡ cb0c4a30-65ff-4dfa-9ad0-7427d2a32d65
struct Location
	x::Int
	y::Int
end

# ╔═╡ 7bbfc9f6-23c6-43d0-8b79-f9610ffbb8f4
Base.:+(lhs::Location, rhs::Location) = Location(lhs.x + rhs.x, lhs.y + rhs.y)

# ╔═╡ fe06fca1-e543-41bc-9cd9-0ca133502828
function shift(c::Char)::Location
	shifts = Dict(
		'>' => Location(1, 0),
		'<' => Location(-1, 0),
		'^' => Location(0, 1),
		'v' => Location(0, -1),
	)

	get(shifts, c, Location(0,0))
end

# ╔═╡ a6c8663d-8bfc-4f5c-926a-57625e790f8c
function houses(path)
	current = Location(0,0)
	houses = Set([current])

	for direction in path 
		next = current + shift(direction)
		current = next
		push!(houses, current)
	end

	houses
end

# ╔═╡ 37cbdf1b-6cbe-40fa-9a60-edbf0d0c49a7
function houses_count(path)
	path |> houses |> length
end

# ╔═╡ 30c495f0-0a98-405a-8e4a-7c92b0e96ac3
md"""
- `^>v<` delivers presents to `4` houses in a square, including twice to the house at his starting/ending location.
"""

# ╔═╡ ada0ec3d-eae6-472c-aeb5-96868deed701
@test houses_count("^>v<") == 4

# ╔═╡ 637b5bb8-40c2-42a3-9b65-6b09a438586f
md"""
- ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
"""

# ╔═╡ 9134fb16-721d-46c1-8ebd-a0c9983ba9b7
@test houses_count("^v^v^v^v^v") == 2

# ╔═╡ 8d5da1ea-8f32-4435-878f-90b7378293b3
part1_answer = houses_count(input)

# ╔═╡ 55d539d7-f954-418c-9165-2b4ae16750f7
md"""
## Part 1

Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (`^`), south (`v`), east (`>`), or west (`<`). After each move, he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

*Part 1 answer: $part1_answer*
"""

# ╔═╡ 2f47d745-45ec-4d26-8f34-593d22399f0f
md"""
- `^v` delivers presents to `3` houses, because Santa goes north, and then Robo-Santa goes south.
"""

# ╔═╡ 4f1527aa-0284-4034-8ca9-3b98b2b26f4b
md"""
- `^>v<` now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
"""

# ╔═╡ c47b155c-e822-4592-aa5c-71414c533382
md"""
- `^v^v^v^v^v` now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.
"""

# ╔═╡ 726206d0-54df-4238-b4e8-b5fce4504508
function houses_count_with_robot(path)
	santa_path = path[1:2:end]
	robot_path = path[2:2:end]
	
	total_houses = union(
		houses(santa_path),
		houses(robot_path)
	)

	length(total_houses)
end

# ╔═╡ f28287c8-503f-4f21-b77b-400abb93d38b
@test houses_count_with_robot("^v") == 3

# ╔═╡ b33f8a96-6314-42bb-b133-47871051b0e2
@test houses_count_with_robot("^>v<") == 3

# ╔═╡ 4ba07f02-0fd2-4d0c-bf7c-c06a2e353b4c
@test houses_count_with_robot("^v^v^v^v^v") == 11

# ╔═╡ c3f23130-ecfa-4c63-b1a7-247d587fc81b
part2_answer = houses_count_with_robot(input)

# ╔═╡ 5be42215-3115-4532-b6da-9fbc293b0c45
md"""
## Part 2

The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

This year, how many houses receive at least one present?

*Part 2 answer: $part2_answer*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "71d91126b5a1fb1020e1098d9d492de2a4438fd2"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ Cell order:
# ╟─639e3fe0-759a-4fe8-ab9d-d1bdcfe6155e
# ╠═58fa96b2-e84a-11ed-27a3-7df456671fd3
# ╠═301dcef2-fea4-4831-80b0-3d640ef25b6a
# ╠═55d539d7-f954-418c-9165-2b4ae16750f7
# ╟─4d2d31f7-ad02-4444-ae84-99e033e6f4b0
# ╠═cb0c4a30-65ff-4dfa-9ad0-7427d2a32d65
# ╠═7bbfc9f6-23c6-43d0-8b79-f9610ffbb8f4
# ╠═fe06fca1-e543-41bc-9cd9-0ca133502828
# ╠═a6c8663d-8bfc-4f5c-926a-57625e790f8c
# ╠═37cbdf1b-6cbe-40fa-9a60-edbf0d0c49a7
# ╟─30c495f0-0a98-405a-8e4a-7c92b0e96ac3
# ╠═ada0ec3d-eae6-472c-aeb5-96868deed701
# ╟─637b5bb8-40c2-42a3-9b65-6b09a438586f
# ╠═9134fb16-721d-46c1-8ebd-a0c9983ba9b7
# ╠═8d5da1ea-8f32-4435-878f-90b7378293b3
# ╠═5be42215-3115-4532-b6da-9fbc293b0c45
# ╟─2f47d745-45ec-4d26-8f34-593d22399f0f
# ╠═f28287c8-503f-4f21-b77b-400abb93d38b
# ╟─4f1527aa-0284-4034-8ca9-3b98b2b26f4b
# ╠═b33f8a96-6314-42bb-b133-47871051b0e2
# ╟─c47b155c-e822-4592-aa5c-71414c533382
# ╠═4ba07f02-0fd2-4d0c-bf7c-c06a2e353b4c
# ╠═726206d0-54df-4238-b4e8-b5fce4504508
# ╠═c3f23130-ecfa-4c63-b1a7-247d587fc81b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
