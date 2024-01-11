package main

import "fmt"

type RecursiveFunc func(RecursiveFunc) RecursiveFunc

func Y(f func(RecursiveFunc) RecursiveFunc) RecursiveFunc {
	return func(x RecursiveFunc) RecursiveFunc {
		return f(func(y RecursiveFunc) RecursiveFunc {
			return x(x)(y)
		})
	}
}

func main() {
	// Define a recursive function using the Y combinator
	factorialFunc := Y(func(f RecursiveFunc) RecursiveFunc {
		return func(n RecursiveFunc) RecursiveFunc {
			if n <= 0 {
				return 1
			}
			return n * f(f)(n-1)
		}
	})

	// factorial
	result := factorialFunc(5)
	fmt.Println("Factorial of 5:", result)
}
