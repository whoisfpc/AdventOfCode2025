package day06

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	line_count := len(input)
	cols := 0
	mat := make([][dynamic]int, line_count - 1)
	defer
	{
		for row in mat {
			delete(row)
		}
		delete(mat)
	}
	for line, i in input {
		if (i == line_count - 1) {
			continue
		}

		idx0 := 0
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
				append(&mat[i], number)
			}
		}
	}

	op_idx := -1
	for c in input[line_count - 1] {
		if c != ' ' {
			op_idx += 1
		}
		if c == '*' {
			res := 1
			for row in mat {
				res *= row[op_idx]
			}
			ans += res
		}; if c == '+' {
			res := 0
			for row in mat {
				res += row[op_idx]
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
