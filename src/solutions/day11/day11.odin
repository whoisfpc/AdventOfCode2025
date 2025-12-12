package day11

import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

State :: struct {
	s:        string,
	dac, fft: bool,
}


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

	cache: map[State]int
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

	ans = dp2(State{"svr", false, false}, &cache, paths)

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

dp2 :: proc(state: State, cache: ^map[State]int, paths: map[string][]string) -> int {
	has_cache := state in cache
	if has_cache {
		return cache[state]
	}
	if state.s == "out" {
		if state.dac && state.fft {
			return 1
		} else {
			return 0
		}
	}

	total := 0
	for next in paths[state.s] {
		ns := state
		ns.s = next
		ns.dac |= next == "dac"
		ns.fft |= next == "fft"
		total += dp2(ns, cache, paths)
	}
	cache[state] = total

	return total
}
