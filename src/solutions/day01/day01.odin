package day01

import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {

	ans: int

	dial := 50

	for row in input {
		turn := strconv.atoi(transmute(string)row[1:])
		if row[0] == 'L' {
			turn = -turn
		} else if row[0] == 'R' {
			// do nothing, turn is positive
		} else {
			panic(fmt.aprintf("unknow op %v", rune(row[0])))
		}
		dial += turn
		dial = dial % 100
		if dial < 0 {
			dial += 100
		}
		if (dial == 0) {
			ans += 1
		}
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {

	ans: int

	dial := 50

	for row in input {
		turn := strconv.atoi(transmute(string)row[1:])
		if row[0] == 'L' {
			turn = -turn
		} else if row[0] == 'R' {
			// do nothing, turn is positive
		} else {
			panic(fmt.aprintf("unknow op %v", rune(row[0])))
		}
		old_dial := dial
		dial += turn

		if (turn > 0) {
			ans += dial / 100
		} else {
			ans += -(dial / 100)
			if old_dial > 0 && dial <= 0 {
				ans += 1
			}
		}

		dial = dial % 100
		if dial < 0 {
			dial += 100
		}
	}

	return fmt.aprintf("%v", ans)
}
