package main

import (
	"fmt"
//	"./primes_era"
	"math/big"
)

var primes []int64
var min_num *big.Int
var min_factors []int

const n_solutions = 4000000

/*
1/(n+a) + 1/(n+b) = 1/n

(n+a+n+b) / ((n+a) * (n+b)) = 1/n

n * (2n+a+b) = n^2 + n(a+b) + ab

2n^2 + n(a+b) = n^2 + n(a+b) + ab

n^2 = ab
*/

/*
2,2,3,3 - множители
2;2 - число повторений множителя
((2+1)*(2+1) + 1)/2 - число различных комбинаций

1; 2,2,3,3
2; 2,3,3
2,2; 3,3
3; 2,2,3
2,3; 2,3
2,2,3; 3
3,3; 2,2
2,3,3; 2
2,2,3,3; 1

2*3*5*7*11*13*17*19*23*29*31*37*41*43*47
(3*3*3*3*3*3*3*3*3*3*3*3*3*3 + 1)/2 = 2,391,485

2*2*3*5*7*11*13*17*19*23*29*31*37*41*43
(5*3*3*3*3*3*3*3*3*3*3*3*3 + 1)/2 = 1,328,603

2*2*3*3*5*7*11*13*17*19*23*29*31*37*41
(5*5*5*3*3*3*3*3*3*3*3*3 + 1)/2 = 1,230,188
*/

func NumFromFactors(factors []int) *big.Int {
	res := big.NewInt(1)
	for i,c := range factors {
		for j := 0; j < c; j++ {
			res = res.Mul(res, big.NewInt(primes[i]))
		}
	}

	return res
}

func CountVariations(factors []int) int {
	res := 1
	for _,c := range factors {
		res = res * (c*2 + 1)
	}

	return (res + 1)/ 2
}

func CompleteFactors(factors []int) []int {
	for ; CountVariations(factors) < n_solutions; factors = append(factors, 1) {
	}
	return factors
}

func Solve110(factors []int) {
	res := make([]int, len(factors))
	copy(res, factors)

//	fmt.Println(CompleteFactors(res))
	CheckAnswer(CompleteFactors(factors))

	if res[0] < 10 && NumFromFactors(res).Cmp(min_num) == -1 {
		if len(res) < 14 && res[len(res)-1] > 1{
			Solve110(append(res, 2))
		}

		for i,n := range res {
			res[i] = n+1
			Solve110(res)
		}
	}
}

func CheckAnswer(factors []int) {
	n := NumFromFactors(factors)
	if n.Cmp(min_num) == -1 && CountVariations(factors) > n_solutions{
		min_num = n
		min_factors = make([]int, len(factors))
		copy(min_factors, factors)

		fmt.Println(n, min_factors)
	}
}

func main() {
	primes = []int64{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47}

	min_factors = CompleteFactors([]int{2})
	min_num = NumFromFactors(min_factors)

	// primes_era.Init(1000000)
	//
	// pp := primes_era.IterPrimes()
	// for i := 0; i < 15; i++ {
	// 	fmt.Println(<-pp)
	// }

	// res := big.NewInt(1)
	//
	// for _,n := range nn {
	// 	res.Mul(res, big.NewInt(n))
	// }

	// ones := []int{1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	//
	// fmt.Println(CountVariations(ones))
	// fmt.Println(NumFromFactors(ones))

	// fmt.Println(CountVariations(CompleteFactors([]int{1})))
	Solve110([]int{1})
}
