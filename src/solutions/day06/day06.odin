package day06

import "../utils"
import "core:fmt"
import "core:hash"
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
		} else if c == '+' {
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

	rows := len(input) - 1
	cols := 0
	for c in input[rows] {
		if c != ' ' {
			cols += 1
		}
	}

	pivots := make([]int, cols)
	defer delete(pivots)
	mat := utils.make_2d(cols, rows, []u8)
	defer utils.destroy_2d(mat)

	// all byte is space in idx as pivot
	line_len := len(input[0])
	pivot_count := 0
	for i in 0 ..< line_len {
		is_pivot := true
		for j in 0 ..< len(input) {
			if input[j][i] != ' ' {
				is_pivot = false
				break
			}
		}
		if is_pivot {
			pivots[pivot_count] = i
			pivot_count += 1
		}
	}
	pivots[pivot_count] = line_len

	assert(pivot_count == len(pivots) - 1)

	for line, i in input {
		if (i == rows) {
			continue
		}
		pp := 0
		for p, j in pivots {
			mat[j][i] = line[pp:p]
			pp = p + 1
		}
	}

	// for row in mat {
	// 	for col in row {
	// 		fmt.printf("%v|", transmute(string)col)
	// 	}
	// 	fmt.println()
	// }

	op_idx := -1
	for c in input[rows] {
		if c != ' ' {
			op_idx += 1
		}
		if c == '*' {
			res := 1
			nn := ltor(mat[op_idx])
			for n in nn {
				res *= n
			}
			delete(nn)
			ans += res
		} else if c == '+' {
			res := 0
			nn := ltor(mat[op_idx])
			for n in nn {
				res += n
			}
			delete(nn)
			ans += res
		}
	}

	return fmt.aprintf("%v", ans)
}

ltor :: proc(numbers: [][]u8) -> [dynamic]int {
	res := make([dynamic]int)

	rows := len(numbers)
	cols := len(numbers[0])
	for j in 0 ..< cols {
		n := 0
		for i in 0 ..< rows {
			if numbers[i][j] == ' ' {
				continue
			} else {
				n = n * 10
				n += int(numbers[i][j] - '0')
			}
		}
		append(&res, n)
	}

	// fmt.println(res)
	return res
}
