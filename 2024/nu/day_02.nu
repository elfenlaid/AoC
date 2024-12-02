let reports = open input_02.txt | lines -s | each {$in | split words | each {$in | into int}}

let safe_inc = {$in.0 < $in.1 and ($in.1 - $in.0) < 4}
let safe_dec = {$in.0 > $in.1 and ($in.0 - $in.1) < 4}

let safe_report = {|report|
    ($report | window 2 | all $safe_inc) or ($report | window 2 | all $safe_dec)
}

let part_1 = $reports | filter $safe_report | length
print $"Part 1: ($part_1)"

let dampened_safe_report = {|report|
    let indexed_pairs = $report | window 2 | enumerate

    let check_pair = {|pair|
        (do $safe_report ($report | drop nth ($pair.index))) or (do $safe_report ($report | drop nth ($pair.index + 1)))
    }

    [
        {do $safe_report $report},
        {do $check_pair ($indexed_pairs | skip while {$in.item | do $safe_inc} | first) },
        {do $check_pair ($indexed_pairs | skip while {$in.item | do $safe_dec} | first) }
    ] | any {do $in }
}

let part_2 = $reports | filter $dampened_safe_report | length
print $"Part 2: ($part_2)"
