package day09

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"

Rect :: struct {
	min_x, min_y: int,
	max_x, max_y: int,
}

Segment :: struct {
	a, b: [2]int,
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

	n := len(input)
	points := make([][2]int, n)
	defer delete(points)
	segments := make([]Segment, n)
	defer delete(segments)

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
		segments[i] = Segment{a, b}
	}

	// 不是正确的通解，例如凹字形状的情况下，中间的下凹部分区域会错误的判定为合法面积区域
	for i in 0 ..< n - 1 {
		for j in i + 1 ..< n {
			area := rect_area(points[i], points[j])
			if area <= ans {
				continue
			}
			no_cross := true
			min_x := min(points[i].x, points[j].x)
			min_y := min(points[i].y, points[j].y)
			max_x := max(points[i].x, points[j].x)
			max_y := max(points[i].y, points[j].y)

			for seg in segments {
				if seg.a.x <= min_x && seg.b.x <= min_x {
					continue
				} else if seg.a.x >= max_x && seg.b.x >= max_x {
					continue
				} else if seg.a.y <= min_y && seg.b.y <= min_y {
					continue
				} else if seg.a.y >= max_y && seg.b.y >= max_y {
					continue
				}
				no_cross = false
				break
			}

			if no_cross {
				ans = area
			}
		}
	}

	return fmt.aprintf("%v", ans)
}

rect_area :: proc(a, b: [2]int) -> int {
	diff := a - b
	return (abs(diff.x) + 1) * (abs(diff.y) + 1)
}
