### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ a0eb9bed-cc1f-4315-a497-9f9d1d4e3273
using Test

# ╔═╡ 0cda3c42-2c22-401b-8866-5ca2544520ca
using MD5

# ╔═╡ 9857c330-e8fd-11ed-29c5-379ac854b524
md"""
# Day 04
"""

# ╔═╡ 6b8d0203-0e9d-4faf-96ce-cb039517eb4f
import Base.Iterators.countfrom

# ╔═╡ 7dcd8a0a-a26f-45b3-a62d-620785d5b208
md"""
# Input
"""

# ╔═╡ db9ed9b7-92fd-4ba6-9983-883ef0a0bf83
input = "bgvyzdsv"

# ╔═╡ 858e7d9e-8665-49c0-bcf2-eb6f76f91d75
hashes(input::AbstractString) = (md5(string(input, i)) for i in countfrom(1))

# ╔═╡ 53655fb9-c5dc-4128-8293-87ed9684b41f
function find_five_zeros(input::String) 
	for (i, message) in input |> hashes |> enumerate 
		a,b,c = message
		a == 0 && b == 0 && c < 16 && return i
	end
end

# ╔═╡ 71d3edcc-2b90-426b-a0a2-9857af3e2cf5
@testset "Part 1" begin
	@test find_five_zeros("abcdef") == 609043
	@test find_five_zeros("pqrstuv") == 1048970
end

# ╔═╡ 9c017f78-5200-4508-936a-d053e844d6ab
part1_answer = find_five_zeros(input)

# ╔═╡ 251cfd53-096e-4295-8dc5-33aa7ca911c4
md"""
# Part 1

Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts for all the economically forward-thinking little girls and boys.

To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal. To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

For example:

- If your secret key is `abcdef`, the answer is `609043`, because the MD5 hash of `abcdef609043` starts with five zeroes (`000001dbbfa...`), and it is the lowest such number to do so.
- If your secret key is `pqrstuv`, the lowest number it combines with to make an MD5 hash starting with five zeroes is `1048970`; that is, the MD5 hash of `pqrstuv1048970` looks like `000006136ef....`

*Part 1 answer: $part1_answer*
"""

# ╔═╡ fd179686-edee-43d1-85f7-1304f1329c71
function find_six_zeros(input::String) 
	for (i, message) in input |> hashes |> enumerate 
		message[1:3] == [0,0,0] && return i
	end
end

# ╔═╡ bdc3c242-83e3-4545-be76-2d89a501ba27
part2_answer = find_six_zeros(input)

# ╔═╡ 0c1d98a0-561d-4055-b626-cb0e3e70831c
md"""
# Part 2

Now find one that starts with six zeroes.

*Part 2 answer: $part2_answer*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
MD5 = "6ac74813-4b46-53a4-afec-0b5dc9d7885c"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
MD5 = "~0.2.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "957777d2422212144f29f3ba1fc30568028c114d"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MD5]]
deps = ["Random", "SHA"]
git-tree-sha1 = "eeffe42284464c35a08026d23aa948421acf8923"
uuid = "6ac74813-4b46-53a4-afec-0b5dc9d7885c"
version = "0.2.1"

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
# ╟─9857c330-e8fd-11ed-29c5-379ac854b524
# ╠═a0eb9bed-cc1f-4315-a497-9f9d1d4e3273
# ╠═0cda3c42-2c22-401b-8866-5ca2544520ca
# ╠═6b8d0203-0e9d-4faf-96ce-cb039517eb4f
# ╟─7dcd8a0a-a26f-45b3-a62d-620785d5b208
# ╠═db9ed9b7-92fd-4ba6-9983-883ef0a0bf83
# ╠═858e7d9e-8665-49c0-bcf2-eb6f76f91d75
# ╟─251cfd53-096e-4295-8dc5-33aa7ca911c4
# ╟─71d3edcc-2b90-426b-a0a2-9857af3e2cf5
# ╠═53655fb9-c5dc-4128-8293-87ed9684b41f
# ╠═9c017f78-5200-4508-936a-d053e844d6ab
# ╟─0c1d98a0-561d-4055-b626-cb0e3e70831c
# ╠═fd179686-edee-43d1-85f7-1304f1329c71
# ╠═bdc3c242-83e3-4545-be76-2d89a501ba27
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
