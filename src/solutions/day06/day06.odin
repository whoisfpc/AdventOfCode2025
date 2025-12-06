package day06

import "../utils"
import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	rows := len(input) - 1
	cols := 0
	for c in input[rows] {
		if c != ' ' {
			cols += 1
		}
	}
	mat := utils.make_2d(cols, rows, int)
	defer utils.destroy_2d(mat)
	for line, i in input {
		if (i == rows) {
			continue
		}

		idx0 := 0
		nj := 0
		for c, j in line {
			ns: string
			if j == len(line) - 1 {
				ns = transmute(string)line[idx0:]
				idx0 = -1
			} else if c == ' ' {
				if idx0 != -1 {
					ns = transmute(string)line[idx0:j]
					idx0 = -1
				}
			} else if c != ' ' {
				if idx0 == -1 {
					idx0 = j
				}
			}

			if len(ns) != 0 {
				number, _ := strconv.parse_int(ns)
				mat[nj][i] = number
				nj += 1
			}
		}
	}

	op_idx := -1
	for c in input[rows] {
		if c != ' ' {
			op_idx += 1
		}
		if c == '*' {
			res := 1
			for n in mat[op_idx] {
				res *= n
			}
			ans += res
		}; if c == '+' {
			res := 0
			for n in mat[op_idx] {
				res += n
			}
			ans += res
		}
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}
