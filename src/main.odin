package main

import "core:fmt"
import "core:os"
import "core:strings"
import "solutions/day01"

Solver :: #type proc(input: [][]u8) -> string

main :: proc() {

	solvers := make(map[string][2]Solver)
	defer {
		delete(solvers)
	}
	solvers["01"] = {day01.part1, day01.part2}

	day := os.args[1]
	part := os.args[2]
	filename := fmt.aprintf("inputs/day%v.txt", day)
	defer delete(filename)

	data, ok := os.read_entire_file_from_filename(filename)
	if !ok {
		fmt.printfln("load file %v fail!", filename)
		return
	}
	defer delete(data)

	puzzle_data := data_to_u8_slice(data)
	defer delete(puzzle_data)

	solver_proc: Solver = nil
	if part == "a" {
		solver_proc = solvers[day][0]
	} else {
		solver_proc = solvers[day][1]
	}
	if solver_proc != nil {
		ans := solver_proc(puzzle_data)
		fmt.printfln("day%v part %v, ans is %v", day, part, ans)
	} else {
		fmt.printfln("can not found solover for day%v part %v", day, part)
	}
}

data_to_u8_slice :: proc(data: []byte) -> [][]u8 {
	dyn := make([dynamic][]u8)
	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		append(&dyn, transmute([]u8)line)
	}

	return dyn[:]
}
