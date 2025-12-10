package day10

import "core:container/queue"
import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	for line in input {
		ans += solve1(transmute(string)line)
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}

solve1 :: proc(line: string) -> int {

	light_end := strings.index_byte(line, ']')
	joltage_start := strings.index_byte(line, '{')
	light := line[:light_end + 1]
	// button_s := line[light_end + 2:joltage_start - 1]
	// fmt.println(line[:light_end + 1])
	// fmt.println(line[light_end + 2:joltage_start - 1])
	// fmt.println(line[joltage_start:])

	target := 0
	for i in 1 ..< len(light) - 1 {
		if line[i] == '#' {
			target |= 1 << uint(i - 1)
		}
	}

	buttons := strings.split(line[light_end + 2:joltage_start - 1], " ")
	masks := make([]int, len(buttons))
	defer delete(masks)
	defer delete(buttons)
	for b, i in buttons {
		toggles := strings.split(b[1:len(b) - 1], ",")
		defer delete(toggles)
		mask := 0
		for t in toggles {
			idx := strconv.parse_uint(t) or_else panic("bad uint")
			mask |= 1 << idx
		}
		masks[i] = mask
	}

	q: queue.Queue(int)
	queue.init(&q)
	defer queue.destroy(&q)
	v: map[int]int
	defer delete(v)
	v[0] = 0

	queue.enqueue(&q, 0)
	res := 0
	bfs: for queue.len(q) > 0 {
		s := queue.dequeue(&q)
		d := v[s] or_else panic("bfs error")
		d += 1
		for m in masks {
			next_state := s ~ m
			if next_state == target {
				res = d
				break bfs
			}
			has_visit := next_state in v
			if !has_visit {
				v[next_state] = d
				queue.enqueue(&q, next_state)
			}
		}
	}

	return res
}
