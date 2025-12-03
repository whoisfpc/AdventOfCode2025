package day03

import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"
import "vendor:directx/dxgi"


part1 :: proc(input: [][]u8) -> string {
	ans: int

	for line in input {
		nums := make_slice([]int, len(line))
		defer delete(nums)
		for c, i in line {
			nums[i] = int(c - '0')
		}
		ans += find_joltage(nums, 2)
	}

	return fmt.aprintf("%v", ans)
}

part2 :: proc(input: [][]u8) -> string {
	ans: int

	for line in input {
		nums := make_slice([]int, len(line))
		defer delete(nums)
		for c, i in line {
			nums[i] = int(c - '0')
		}
		ans += find_joltage(nums, 12)
	}

	return fmt.aprintf("%v", ans)
}

find_joltage :: proc(nums: []int, digits: int) -> int {
	res := 0

	nums := nums
	remain := digits
	for i in 0 ..< digits {
		max, idx := find_max(nums[:len(nums) - remain + 1])
		res = res * 10 + max
		nums = nums[idx + 1:]
		remain -= 1
	}

	return res
}

find_max :: proc(nums: []int) -> (max, idx: int) {
	max = 0
	idx = -1

	for n, i in nums {
		if n > max {
			max = n
			idx = i
		}
	}

	return max, idx
}
