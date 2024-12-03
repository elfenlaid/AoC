def memory_sum []: string -> int {
    parse --regex 'mul\((?<lhs>\d{1,3}),(?<rhs>\d{1,3})\)' |
    each {($in.lhs | into int) * ($in.rhs | into int) } |
    math sum
}

let part_1 = open input_03.txt | each { memory_sum } | math sum

print $"Part 1: ($part_1)"

let part_2 = open input_03.txt |
    split row "don't()" |
    update 0 { "do()" + $in } |
    each { split row "do()" | drop nth 0 } |
    flatten |
    each { memory_sum } |
    math sum

print $"Part 2: ($part_2)"
