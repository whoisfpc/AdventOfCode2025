package day04

import "../utils"
import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

KR := [8]int{-1, -1, -1, 0, 0, 1, 1, 1}
KC := [8]int{-1, 0, 1, -1, 1, -1, 0, 1}

part1 :: proc(input: [][]u8) -> string {
	ans: int

	rows := len(input)
	cols := len(input[0])
	papers := utils.make_2d(rows, cols, bool)
	defer utils.destroy_2d(papers)
	for line, i in input {
		for c, j in line {
			if c == '.' {
				papers[i][j] = false
			} else {
				papers[i][j] = true
			}
		}
	}

	for i in 0 ..< rows {
		for j in 0 ..< cols {
			if !papers[i][j] {
				continue
			}
			can_see := 0
			for dir in 0 ..< 8 {
				ni := i + KR[dir]
				nj := j + KC[dir]
				if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
					if papers[ni][nj] {
						can_see += 1
					}
				}
			}
			if can_see < 4 {
				ans += 1
			}
		}
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}
