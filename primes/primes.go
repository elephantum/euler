package primes

var prime_numbers []int = []int{2}

func IterPrimes() chan int {
	res := make(chan int)

	go func() {
		for _, p := range prime_numbers {
			res <- p
		}

		for i := prime_numbers[len(prime_numbers) - 1] + 1; true; i++ {
			is_prime := true
			for _,j := range(prime_numbers) {
				if i == j {
					break
				}
				if i % j == 0 {
					is_prime = false
					break
				}
			}

			if is_prime {
				prime_numbers = append(prime_numbers, i)
				res <- i
			}
		}
	}()

	return res
}

func IsPrime(n int) bool {
	primes := IterPrimes()
	for p := <- primes; p < n; p = <- primes {
		if n % p == 0 {
			return false
		}
	}

	return true
}
