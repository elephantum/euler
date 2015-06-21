package primes_era

const PRIME_LIM int = 100000000

var is_prime []bool

func Init() {
	is_prime = make([]bool, PRIME_LIM)

	for i := 0; i < PRIME_LIM; i++ {
		is_prime[i] = true
	}

	for i := 2; i < PRIME_LIM; i++ {
		if is_prime[i] {
			for j := i+i; j < PRIME_LIM; j += i {
				is_prime[j] = false
			}
		}
	}
}

func IterPrimes() chan int {
	res := make(chan int)

	go func() {
		for i := 2; i < PRIME_LIM; i++ {
			if is_prime[i] {
				res <- i
			}
		}

		close(res)
	}()

	return res
}

func IsPrime(n int) bool {
	return is_prime[n]
}
