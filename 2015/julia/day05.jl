### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 95cc4502-6fe1-4e2a-841d-c5953654e1ff
using Test

# ╔═╡ 2c9f36ca-ec2f-11ed-3a8a-8d8659dbf951
md"""
# Day 05
"""

# ╔═╡ de451871-5ae9-45dc-91d8-7378ec8870a9
md"""
## Input
"""

# ╔═╡ 8107f216-a79e-4451-9bf5-6390b963cfea
input = readlines("day05.txt")

# ╔═╡ 45d05191-c3fc-4333-a716-970698962847
function has_three_vowels(str)
	vowels = "aeiou"
	count = 0
	
	for c in str 
		c in vowels || continue
		
		count += 1
		count >= 3 && return true
	end

	false
end

# ╔═╡ 57bc0505-6834-49d9-a0af-553455932ba3
@testset "three vowels" begin
	@test has_three_vowels("aei")
	@test has_three_vowels("xazegov")
	@test has_three_vowels("aeiouaeiouaeiou")

	@test !has_three_vowels("abc")
end

# ╔═╡ 137fafdb-51f5-4c64-9d9e-80f2e1351ab0
function has_twice_letters(str)
	letters = zip(str, str[2:end])
	
	for (x, y) in letters
		x == y && return true
	end
		
	false
end

# ╔═╡ 3956d73c-d2f2-437a-81fe-06d6502d4652
@testset "letters twice in a row" begin
	@test has_twice_letters("xx")
	@test has_twice_letters("abcdde")
	@test has_twice_letters("aabbccdd")

	@test !has_twice_letters("abc")
end

# ╔═╡ 04fd07cf-35c4-4eef-9bd7-2adb8ee07ed3
function has_banned_strings(str)
	banned = [('a', 'b'), ('c', 'd'), ('p', 'q'), ('x', 'y')]
	letters = zip(str, str[2:end])

	for pair in letters
		pair in banned && return true
	end

	false
end

# ╔═╡ ec3296c7-cabd-42c1-92de-e33c29f872b1
@testset "has banned strings" begin
	@test has_banned_strings("ab")
	@test has_banned_strings("cd")
	@test has_banned_strings("pq")
	@test has_banned_strings("xy")

	@test !has_banned_strings("azx")
end

# ╔═╡ c8c67ca2-dc49-45de-a231-c61ee1b6420f
isnice(str) = has_three_vowels(str) && has_twice_letters(str) && !has_banned_strings(str)

# ╔═╡ 4aca144d-3f47-4f56-ab63-761a8572b2d2
@testset "nice strings" begin
	@test isnice("ugknbfddgicrmopn")
	@test isnice("aaa")

	@test !isnice("jchzalrnumimnmhp")
	@test !isnice("haegwjzuvuyypxyu")
	@test !isnice("dvszwmarrgswjxmb")
end

# ╔═╡ 9c597e95-6b45-425d-80e5-5fb6a8ff60b5
part1_answer = count(isnice, input)

# ╔═╡ b0e3e7cb-346f-4c86-83c7-39ceca86d56d
md"""
## Part 1

A nice string is one with all of the following properties:

- It contains at least three vowels (`aeiou` only), like `aei`, `xazegov`, or `aeiouaeiouaeiou`.
- It contains at least one letter that appears twice in a row, like `xx`, `abcdde` (`dd`), or `aabbccdd` (`aa`, `bb`, `cc`, or `dd`).
- It does not contain the strings `ab`, `cd`, `pq`, or `xy`, even if they are part of one of the other requirements.

*Part 1 answer: $part1_answer*
"""

# ╔═╡ aaa97058-b012-4bd4-a983-88a1364dd7bb


# ╔═╡ fdff7ad8-a858-41db-98f5-8b0ffd27b694
function has_repeating_letter(str)
	len = length(str)
	len < 3 && return false
	
	for i in 1:(len - 2)
		str[i] == str[i + 2] && return true
	end

	return false
end

# ╔═╡ 555cc30c-83b0-4eb1-8e2d-36ec65a48e69
function has_letter_pairs(str)
	len = length(str)
	len < 2 && return false

	pairs = Set()

	i = 1
	while i <= (len - 1)
		first = str[i]
		second = str[i+1]
		third = nothing

		if i + 2 <= len
			third = str[i+2]
		end

		pair = (first, second)
		pair in pairs && return true
		push!(pairs, pair)

		i += (first == second == third) ? 2 : 1
	end

	false
end

# ╔═╡ a8ab853a-8fe1-46d8-b26e-66c8006a198a
isnicer(str) = has_repeating_letter(str) && has_letter_pairs(str)

# ╔═╡ f608ca83-f2f7-4a7c-965e-5e7e760c085b
@testset "nicer string" begin
	@test has_letter_pairs("xyxy")
	@test has_letter_pairs("aabcdefgaa")
	@test has_letter_pairs("xxyxx")
	@test !has_letter_pairs("aaa")

	@test has_repeating_letter("xyx")
	@test has_repeating_letter("abcdefeghi")
	@test has_repeating_letter("aaa")
	@test !has_repeating_letter("abc")

	@test isnicer("qjhvhtzxzqqjkmpb")
	@test isnicer("xxyxx")
end

# ╔═╡ 1d09d834-9f17-406f-aad6-e51975e5267f
part2_answer = count(isnicer, input)

# ╔═╡ b680deb9-e179-4cef-8c14-65cbea371586
md"""
## Part 2

Realizing the error of his ways, Santa has switched to a better model of determining whether a string is naughty or nice. None of the old rules apply, as they are all clearly ridiculous.

Now, a nice string is one with all of the following properties:

- It contains a pair of any two letters that appears at least twice in the string without overlapping, like `xyxy` (`xy`) or `aabcdefgaa` (`aa`), but not like `aaa` (`aa`, but it overlaps).
- It contains at least one letter which repeats with exactly one letter between them, like `xyx`, `abcdefeghi` (`efe`), or even `aaa`.

For example:

- `qjhvhtzxzqqjkmpb` is nice because is has a pair that appears twice (`qj`) and a letter that repeats with exactly one letter between them (`zxz`).
- `xxyxx` is nice because it has a pair that appears twice and a letter that repeats with one between, even though the letters used by each rule overlap.
- `uurcxstgmygtbstg` is naughty because it has a pair (`tg`) but no repeat with a single letter between them.
- `ieodomkazucvgmuy` is naughty because it has a repeating letter with one between (`odo`), but no pair that appears twice.

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
# ╟─2c9f36ca-ec2f-11ed-3a8a-8d8659dbf951
# ╠═95cc4502-6fe1-4e2a-841d-c5953654e1ff
# ╟─de451871-5ae9-45dc-91d8-7378ec8870a9
# ╠═8107f216-a79e-4451-9bf5-6390b963cfea
# ╟─b0e3e7cb-346f-4c86-83c7-39ceca86d56d
# ╠═45d05191-c3fc-4333-a716-970698962847
# ╠═57bc0505-6834-49d9-a0af-553455932ba3
# ╠═137fafdb-51f5-4c64-9d9e-80f2e1351ab0
# ╠═3956d73c-d2f2-437a-81fe-06d6502d4652
# ╠═04fd07cf-35c4-4eef-9bd7-2adb8ee07ed3
# ╠═ec3296c7-cabd-42c1-92de-e33c29f872b1
# ╠═c8c67ca2-dc49-45de-a231-c61ee1b6420f
# ╠═4aca144d-3f47-4f56-ab63-761a8572b2d2
# ╠═9c597e95-6b45-425d-80e5-5fb6a8ff60b5
# ╟─b680deb9-e179-4cef-8c14-65cbea371586
# ╠═aaa97058-b012-4bd4-a983-88a1364dd7bb
# ╠═fdff7ad8-a858-41db-98f5-8b0ffd27b694
# ╠═555cc30c-83b0-4eb1-8e2d-36ec65a48e69
# ╠═a8ab853a-8fe1-46d8-b26e-66c8006a198a
# ╠═f608ca83-f2f7-4a7c-965e-5e7e760c085b
# ╠═1d09d834-9f17-406f-aad6-e51975e5267f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
