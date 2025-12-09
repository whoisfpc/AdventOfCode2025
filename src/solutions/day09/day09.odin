package day09

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"

Dir :: enum {
	N,
	E,
	S,
	W,
}

Star :: struct {
	p:     [2]int,
	max_d: [Dir]int,
}

Segment :: struct {
	a, b: [2]int,
	is_v: bool,
}

part1 :: proc(input: [][]u8) -> string {
	ans: int

	n := len(input)
	points := make([][2]int, n)
	defer delete(points)

	for line, i in input {
		idx := slice.linear_search(line, ',') or_else panic("bad input")
		x, _ := strconv.parse_int(transmute(string)line[:idx])
		y, _ := strconv.parse_int(transmute(string)line[idx + 1:])
		points[i] = {x, y}
	}

	last_is_v := true
	for i in 0 ..< n {
		a := points[i]
		b := points[(i + 1) % n]
		assert(a.x == b.x || a.y == b.y)
		is_v := a.y == b.y
		if i > 0 {
			assert(is_v != last_is_v)
		}
		last_is_v = is_v
	}

	for i in 0 ..< n - 1 {
		for j in i + 1 ..< n {
			ans = max(ans, rect_area(points[i], points[j]))
		}
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}

rect_area :: proc(a, b: [2]int) -> int {
	diff := a - b
	return (abs(diff.x) + 1) * (abs(diff.y) + 1)
}
