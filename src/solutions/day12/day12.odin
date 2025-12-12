package day12

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	shapes: [6]int

	for i in 0 ..= 5 {
		idx := i * 5 + 1
		for j in idx ..< idx + 3 {
			for c in input[j] {
				if c == '#' {
					shapes[i] += 1
				}
			}
		}
	}

	// 并非通解
	for i in 30 ..< len(input) {
		line := transmute(string)input[i]
		sp := strings.index_byte(line, ':')
		regions := strings.split(line[:sp], "x")
		nums := strings.split(line[sp + 2:], " ")
		defer delete(regions)
		defer delete(nums)
		total_regions := 1
		total_shapes := 0
		for r in regions {
			rn := strconv.parse_int(r) or_else panic("bad region")
			total_regions *= rn
		}

		for num, j in nums {
			n := strconv.parse_int(num) or_else panic("bad shape num")
			total_shapes += n
		}
		if total_regions >= total_shapes * 9 {
			ans += 1
		}
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}
