package primes

var prime_numbers []int = []int{}

func IterPrimes() chan int {
	res := make(chan int)

	go func() {
		for i := 2; true; i++ {
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
