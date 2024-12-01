let side_by_side = open input_01.txt | detect columns -n

let part_1 = $side_by_side.column0 | sort | zip ($side_by_side.column1 | sort) | each { $in | into int | $in.0 - $in.1 | math abs } | math sum
print "Part 1: " $part_1 -n

print ""

let frequences = $side_by_side.column1 | group-by
let part_2 = $side_by_side.column0 | each { |elem| ($frequences | get $elem -i | length) * ($elem | into int) } | math sum
print "Part 2: " $part_2 -n
