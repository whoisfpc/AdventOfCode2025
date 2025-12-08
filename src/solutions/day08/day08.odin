package day08

import "core:fmt"
import "core:os"
import "core:slice"
import "core:sort"
import "core:strconv"
import "core:strings"

PART1_LOOPS :: 1000

Pair :: struct {
	a, b: int,
	dist: int,
}

part1 :: proc(input: [][]u8) -> string {
	ans: int

	n := len(input)
	points := make([][3]int, n)
	defer delete(points)
	pairs := make([dynamic]Pair)
	defer delete(pairs)
	ds := make([]int, n)
	defer delete(ds)
	for i in 0 ..< n {
		ds[i] = i
	}

	for line, i in input {
		ss := strings.split(transmute(string)line, ",")
		defer delete(ss)
		x, _ := strconv.parse_int(ss[0])
		y, _ := strconv.parse_int(ss[1])
		z, _ := strconv.parse_int(ss[2])
		points[i] = {x, y, z}
	}

	for i in 0 ..< n - 1 {
		for j in i + 1 ..< n {
			diff := points[j] - points[i]
			dist := diff.x * diff.x + diff.y * diff.y + diff.z * diff.z
			append(&pairs, Pair{i, j, dist})
		}
	}

	slice.sort_by(pairs[:], proc(a: Pair, b: Pair) -> bool {
		return a.dist < b.dist
	})

	for i in 0 ..< PART1_LOOPS {
		p := pairs[i]
		ds_merge(ds, p.a, p.b)
	}

	counts := make([]int, n)
	defer delete(counts)

	for i in 0 ..< n {
		ds_find(ds, i)
		counts[ds[i]] += 1
	}

	slice.sort(counts)

	ans = counts[n - 1] * counts[n - 2] * counts[n - 3]

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	n := len(input)
	points := make([][3]int, n)
	defer delete(points)
	pairs := make([dynamic]Pair)
	defer delete(pairs)
	ds := make([]int, n)
	defer delete(ds)
	for i in 0 ..< n {
		ds[i] = i
	}

	for line, i in input {
		ss := strings.split(transmute(string)line, ",")
		defer delete(ss)
		x, _ := strconv.parse_int(ss[0])
		y, _ := strconv.parse_int(ss[1])
		z, _ := strconv.parse_int(ss[2])
		points[i] = {x, y, z}
	}

	for i in 0 ..< n - 1 {
		for j in i + 1 ..< n {
			diff := points[j] - points[i]
			dist := diff.x * diff.x + diff.y * diff.y + diff.z * diff.z
			append(&pairs, Pair{i, j, dist})
		}
	}

	slice.sort_by(pairs[:], proc(a: Pair, b: Pair) -> bool {
		return a.dist < b.dist
	})

	connects := 0
	for p in pairs {
		if ds_merge(ds, p.a, p.b) {
			connects += 1
			if connects == n - 1 {
				ans = points[p.a].x * points[p.b].x
				break
			}
		}
	}

	return fmt.aprintf("%v", ans)
}

ds_find :: proc(ds: []int, a: int) -> int {
	if ds[a] == a {
		return a
	} else {
		ds[a] = ds_find(ds, ds[a])
		return ds[a]
	}
}

ds_merge :: proc(ds: []int, a, b: int) -> bool {
	fa := ds_find(ds, a)
	fb := ds_find(ds, b)
	if fa == fb {
		return false
	}
	ds[fb] = fa
	return true
}
