package utils

make_2d :: proc(height, width: int, $E: typeid) -> [][]E {
	s2 := make([][]E, height)
	for &line in s2 {
		line = make([]E, width)
	}
	return s2
}

destroy_2d :: proc(s2: $T/[][]$E) {
	for line in s2 {
		delete(line)
	}
	delete(s2)
}

pow10 :: proc(num: int) -> int {
	ret := 1
	for i in 0 ..< num {
		ret *= 10
	}
	return ret
}
