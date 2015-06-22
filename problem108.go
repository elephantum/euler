package main

import "fmt"

// https://projecteuler.net/problem=108

/*
1/x + 1/y = 1/n

1/y = 1/n - 1/x

y = 1/(1/n - 1/x) = 1/(x/n*x - n/n*x) = 1/((x-n)/(n*x)) = n*x / (x-n)
*/

func NSolutions(n int) int {
	res := 0
	for x := n+1; x <= 2*n; x++ {
		if (n*x) % (x-n) == 0 {
			res ++
		}
	}

	return res
}

func main() {
	for i := 1; i < 1000000; i++ {
		if i % 1000 == 0 {
			fmt.Println("...", i)
		}

		if NSolutions(i) > 1000 {
			fmt.Println(i)
		}
	}
}
