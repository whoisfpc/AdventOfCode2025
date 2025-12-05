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

	ranges := make([dynamic][2]int)
	defer delete(ranges)
	for line in input {
		if len(line) == 0 {
			break
		}
		ls := transmute(string)line
		idx := strings.index_byte(ls, '-')
		left, _ := strconv.parse_int(ls[:idx])
		right, _ := strconv.parse_int(ls[idx + 1:])

		n := len(ranges)
		should_add := true
		for i := 0; i < n; i += 1 {
			range := ranges[i]
			if (left <= range.x && right > range.y) || (left < range.x && right >= range.y) {
				// added fully contain existing
				unordered_remove(&ranges, i)
				i -= 1
				n -= 1
			} else if left >= range.x && right <= range.y {
				// fully contained
				should_add = false
				break
			} else if left >= range.x && left <= range.y && right > range.y {
				// overlap left
				left = range.x
				unordered_remove(&ranges, i)
				i -= 1
				n -= 1
			} else if right >= range.x && right <= range.y && left < range.x {
				// overlap right
				right = range.y
				unordered_remove(&ranges, i)
				i -= 1
				n -= 1
			}
		}
		if should_add {
			append(&ranges, [2]int{left, right})
		}
	}

	for range in ranges {
		ans += range.y - range.x + 1
	}

	return fmt.aprintf("%v", ans)
}
