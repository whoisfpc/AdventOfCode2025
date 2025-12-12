package day11

import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	cache: map[string]int
	defer delete(cache)
	paths: map[string][]string
	defer {
		for _, v in paths {
			delete(v)
		}
		delete(paths)
	}

	for line in input {
		s := transmute(string)line[:3]
		nexts := strings.split(transmute(string)line[5:], " ")
		paths[s] = nexts
	}

	ans = dp1("you", &cache, paths)

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}

dp1 :: proc(s: string, cache: ^map[string]int, paths: map[string][]string) -> int {
	has_cache := s in cache
	if has_cache {
		return cache[s]
	}
	if s == "out" {
		return 1
	}

	total := 0
	for next in paths[s] {
		total += dp1(next, cache, paths)
	}
	cache[s] = total

	return total
}
