package day02

import "../utils"
import "core:fmt"
import "core:math"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	line := transmute(string)input[0]

	nums := 0
	for range in strings.split_iterator(&line, ",") {
		idx := strings.index_byte(range, '-')
		pa := range[:idx]
		pb := range[idx + 1:]
		na, _ := strconv.parse_int(pa)
		nb, _ := strconv.parse_int(pb)
		nums += nb - na + 1

		for i in na ..= nb {
			digits := math.count_digits_of_base(i, 10)
			if (digits % 2 == 0) {
				q := utils.pow10(digits / 2)
				if i / q == i % q {
					ans += i
				}
			}
		}
	}


	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	return fmt.aprintf("%v", ans)
}
