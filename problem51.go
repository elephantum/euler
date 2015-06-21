package main

import(
	"fmt"
  "./primes_era"
)

func SplitNumber(n int) []int {
	res := []int{}

	for ; n > 0; n = n / 10 {
		res = append(res, n % 10)
	}

	return res
}

func MakeNumber(nn []int) int {
	res := 0
	for i := len(nn) - 1; i >= 0; i-- {
		res = res*10 + nn[i]
	}

	return res
}

func Replace(nn []int, from int, to int) []int {
	res := make([]int, len(nn))
	var n_ int

	for i, n := range nn {
		if n == from {
			n_ = to
		} else {
			n_ = n
		}

		res[i] = n_
	}

	return res
}

func IsNFamily(n_family, n int) bool {
	nn := SplitNumber(n)

	if len(nn) == 1 {
		return false
	}

	for from := 0; from <= 10 - n_family; from++ {
		family_count := 1

		has_number := false
		for _, nni := range nn {
			if from == nni {
				has_number = true
				break
			}
		}

		if has_number {
			for to := from + 1; to < 10; to++ {
				if primes_era.IsPrime(MakeNumber(Replace(nn, from, to))) {
					family_count ++
				}
			}

			if family_count == n_family {
				return true
			}
		}
	}

	return false
}

func main() {
	primes_era.Init()

	it := 0

	for p := range(primes_era.IterPrimes()) {
		if it % 1000 == 0 {
			fmt.Printf("... %v\n", p)
		}

		if IsNFamily(8, p) {
			fmt.Println(p)
			break
		}

		it++
	}
}
