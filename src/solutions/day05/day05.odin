package day05

import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	scan_range := true
	ranges := make([dynamic][2]int)
	defer delete(ranges)
	for line in input {
		if len(line) == 0 {
			scan_range = false
			continue
		}
		if scan_range {
			ls := transmute(string)line
			idx := strings.index_byte(ls, '-')
			left, _ := strconv.parse_int(ls[:idx])
			right, _ := strconv.parse_int(ls[idx + 1:])
			append(&ranges, [2]int{left, right})
		} else {
			id, _ := strconv.parse_int(transmute(string)line)
			for range in ranges {
				if id >= range.x && id <= range.y {
					ans += 1
					break
				}
			}
		}
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}
