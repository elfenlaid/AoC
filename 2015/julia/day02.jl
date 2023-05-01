### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ fd4d152a-e807-11ed-03cb-b327e60c4f75
using Test

# ╔═╡ 01500708-e3a3-497c-b6f8-c641bb276231
using PlutoUI

# ╔═╡ 9dce1ad3-18fa-495a-a2e2-cf4ff0eaad71
TableOfContents()

# ╔═╡ 9bfa409e-f2dc-4b81-8c96-6a695f35f2c8
md"""
# Input
"""

# ╔═╡ 0a4e8ab8-da3b-424c-b082-1bf548a2d117
input = readlines("day02.txt")

# ╔═╡ 2f51b4bf-c6ae-4bf0-8ea9-149210274ad0
function parse_line(line::String)
	dimensions = split(line, "x")
	l, w, h = parse.([Int], dimensions)
	(; l, w, h)
end

# ╔═╡ 42095028-9d3a-479c-88a6-c803323be6aa
boxes = map(parse_line, input)

# ╔═╡ cb76a728-b8af-4399-a323-968a3894dbef
@test parse_line("3x11x24") == (l = 3, w = 11, h = 24)

# ╔═╡ 323e6e28-7ccc-46c9-8de2-b49d93bc7b3d
box_area((; l, w, h)) = 2*l*w + 2*w*h + 2*h*l

# ╔═╡ 5252414b-d4db-4276-bd37-1ff8fc76b63a
box_slack((; l, w, h)) = min(l*w, w*h, h*l)

# ╔═╡ d80f033e-2a01-4835-9e04-bb24b64b38a0
md"""
- A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
"""

# ╔═╡ 780aec29-65aa-4d55-98a7-ebbe8e43aae0
@test box_area((l = 2, w = 3, h = 4)) == 52

# ╔═╡ 2144f044-797e-4601-a78e-bcd2d815ddc5
@test box_slack((l = 2, w = 3, h = 4)) == 6

# ╔═╡ cd3baa07-ed91-4627-9678-0aa417dada05
md"""
- A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.
"""

# ╔═╡ e0e5d99c-4187-4a4e-989a-06a018e21248
@test box_area((l = 1, w = 1, h = 10)) == 42

# ╔═╡ 7c747eee-ca4e-45de-a8f8-4b3996cde5ce
@test box_slack((l = 1, w = 1, h = 10)) == 1

# ╔═╡ d0e9a6af-ff85-47ed-9645-ea2650dc2f55
part1_answer = mapreduce(box -> box_area(box) + box_slack(box), +, boxes)

# ╔═╡ 9066854b-f71c-48f8-b88c-eeed8c72350f
md"""
# Part 1

The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

*Part 1 answer: $(part1_answer)*
"""

# ╔═╡ 8910c251-48ae-423b-b0ee-a620101b243a
ribbon_length((; l, w, h)) = min(l+w, w+h, h+l) * 2

# ╔═╡ 701a3e6b-b55e-40db-9f03-b17738a8999d
bow_length((; l, w, h)) = l * w * h

# ╔═╡ a104395e-22ab-4376-a234-d767e638ef0f
md"""
- A present with dimensions `2x3x4` requires `2+2+3+3 = 10` feet of ribbon to wrap the present plus `2*3*4 = 24` feet of ribbon for the bow, for a total of `34` feet.
"""

# ╔═╡ 7e57a315-2065-45f7-b75e-051433526d23
@test ribbon_length((l = 1, w = 1, h = 10)) == 4

# ╔═╡ ea00eb1d-f279-4f43-b813-00971ebb5261
@test bow_length((l = 2, w = 3, h = 4)) == 24

# ╔═╡ 9474311c-e7fb-4e1f-8044-aad3ffcebe71
md"""
- A present with dimensions `1x1x10` requires `1+1+1+1 = 4` feet of ribbon to wrap the present plus `1*1*10 = 10` feet of ribbon for the bow, for a total of `14` feet.
"""

# ╔═╡ f6dbe233-e150-4a24-95e9-9b0a411fdcd0
@test ribbon_length((l = 2, w = 3, h = 4)) == 10

# ╔═╡ 12c0472c-73e7-49a3-b30f-6cb09cf50dd5
@test bow_length((l = 1, w = 1, h = 10)) == 10

# ╔═╡ 4aac49e8-9e45-474d-a224-1ecd0aab07d9
part2_answer = mapreduce(box -> ribbon_length(box) + bow_length(box), +, boxes)

# ╔═╡ 8018f154-c1c6-45c1-978a-83fba3fca916
md"""
# Part 2

The elves are also running low on ribbon. Ribbon is all the same width, so they only have to worry about the length they need to order, which they would again like to be exact.

The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present. Don't ask how they tie the bow, though; they'll never tell.

*Part 2 answer: $(part2_answer)*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "9a496364751e04859abcf52362df2e31b4c2535f"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═fd4d152a-e807-11ed-03cb-b327e60c4f75
# ╠═01500708-e3a3-497c-b6f8-c641bb276231
# ╠═9dce1ad3-18fa-495a-a2e2-cf4ff0eaad71
# ╟─9bfa409e-f2dc-4b81-8c96-6a695f35f2c8
# ╠═0a4e8ab8-da3b-424c-b082-1bf548a2d117
# ╠═42095028-9d3a-479c-88a6-c803323be6aa
# ╟─2f51b4bf-c6ae-4bf0-8ea9-149210274ad0
# ╟─cb76a728-b8af-4399-a323-968a3894dbef
# ╟─9066854b-f71c-48f8-b88c-eeed8c72350f
# ╠═323e6e28-7ccc-46c9-8de2-b49d93bc7b3d
# ╠═5252414b-d4db-4276-bd37-1ff8fc76b63a
# ╟─d80f033e-2a01-4835-9e04-bb24b64b38a0
# ╠═780aec29-65aa-4d55-98a7-ebbe8e43aae0
# ╠═2144f044-797e-4601-a78e-bcd2d815ddc5
# ╟─cd3baa07-ed91-4627-9678-0aa417dada05
# ╠═e0e5d99c-4187-4a4e-989a-06a018e21248
# ╠═7c747eee-ca4e-45de-a8f8-4b3996cde5ce
# ╠═d0e9a6af-ff85-47ed-9645-ea2650dc2f55
# ╟─8018f154-c1c6-45c1-978a-83fba3fca916
# ╠═8910c251-48ae-423b-b0ee-a620101b243a
# ╠═701a3e6b-b55e-40db-9f03-b17738a8999d
# ╟─a104395e-22ab-4376-a234-d767e638ef0f
# ╠═7e57a315-2065-45f7-b75e-051433526d23
# ╠═ea00eb1d-f279-4f43-b813-00971ebb5261
# ╟─9474311c-e7fb-4e1f-8044-aad3ffcebe71
# ╠═f6dbe233-e150-4a24-95e9-9b0a411fdcd0
# ╠═12c0472c-73e7-49a3-b30f-6cb09cf50dd5
# ╠═4aac49e8-9e45-474d-a224-1ecd0aab07d9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
