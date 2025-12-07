package day07

import "core:c"
import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	width := len(input[0])
	cur_beams := make([]bool, width)
	next_beams := make([]bool, width)
	defer delete(cur_beams)
	defer delete(next_beams)

	for line, i in input {
		if i == 0 {
			s_idx := slice.linear_search(line, 'S') or_else panic("input line has no S")
			cur_beams[s_idx] = true
			continue
		}

		for c, j in line {
			if cur_beams[j] {
				if (c == '^') {
					ans += 1
					l, r := j - 1, j + 1
					if l >= 0 {
						next_beams[l] = true
					}
					if r < width {
						next_beams[r] = true
					}
				} else {
					next_beams[j] = true
				}
			}
		}

		cur_beams, next_beams = next_beams, cur_beams
		slice.zero(next_beams)
	}


	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}
