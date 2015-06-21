package main

import(
	"fmt"
	"strconv"
	"./primes"
)

type Digit interface {
	Apply(substitution int) int
	AsString() string
}

type NumDigit struct {
	n int
}

func (d NumDigit) Apply(p int) int {
	return d.n
}

func (d NumDigit) AsString() string {
	return strconv.Itoa(d.n)
}

type Placeholder struct {}

func (_ Placeholder) Apply(p int) int {
	return p
}

func (_ Placeholder) AsString() string {
	return "x"
}

type Number struct {
	digits []Digit
}

func (n Number) Apply(p int) int {
	res := 0
	for _,v := range n.digits {
		res = res * 10 + v.Apply(p)
	}
	return res
}

func (n Number) AsString() string {
	res := ""
	for _,v := range n.digits {
		res = res + v.AsString()
	}
	return res
}

func IsPrime(x int) bool {
	for d := 2; d < x; d++ {
		if x % d == 0 {
			return false
		}
	}
	return true
}

func CountPrimes(x Number) int {
	res := 0
	for t := 0; t < 10; t++ {
		if IsPrime(x.Apply(t)) {res++}
	}
	return res
}

func IterNumbersRec(res chan Number, n []Digit, digits int, placeholders int) {
	if digits == 0 && placeholders == 0 {
		res <- Number{n}
	}

	if digits > 0 {
		for i := 1; i < 10; i++ {
			IterNumbersRec(res, append(n, NumDigit{i}), digits-1, placeholders)
		}
	}

	if placeholders > 0 {
		IterNumbersRec(res, append(n, Placeholder{}), digits, placeholders-1)
	}
}

func IterNumbers(digits int, placeholders int) chan Number {
	res := make(chan Number)

	go func (){
		IterNumbersRec(res, []Digit{}, digits, placeholders)
		close(res)
	}()

	return res
}

func main() {
	primes_it := primes.IterPrimes()
	for i := 0; i < 100; i++ {
		fmt.Println(<-primes_it)
	}

	// c := 0
	// for n := range IterNumbers(4, 2) {
	// 	if c % 1000 == 0 {
	// 		fmt.Println(n.AsString())
	// 	}
	// 	c++
	// 	if CountPrimes(n) == 8 {
	// 		fmt.Println(n.AsString())
	// 	}
	// }

	// for a := 0; a < 10; a++ {
	// 	for b := 0; b < 10; b++ {
	// 		for c := 0; c < 10; c++ {
	// 			da := NumDigit{n:a}
	// 			db := NumDigit{n:b}
	// 			dc := NumDigit{n:c}
	//
	// 			x := Number{[]Digit{
	// 					da,
	// 					db,
	// 					Placeholder{},
	// 					Placeholder{},
	// 					dc,
	// 				}}
	//
	// 			if CountPrimes(x) >= 7 {
	// 				fmt.Printf("%v\n", x.AsString())
	// 			}
	// 		}
	// 	}
	// }
}
