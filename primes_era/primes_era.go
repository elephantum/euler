package primes_era

var PRIME_LIM int

var is_prime []bool

func Init(lim int) {
	PRIME_LIM = lim

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

func Factorize(n int) chan int {
	res := make(chan int)

	go func() {
		pp := IterPrimes()
		for p := <- pp; p <= n; p = <-pp {
			for ; n % p == 0; n = n / p {
				res <- p
			}
		}

		close(res)
	}()

	return res
}

func IsPrime(n int) bool {
	return is_prime[n]
}
