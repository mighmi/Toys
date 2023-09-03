package main

import "math"

// For a stock's prices per tick, return the max profit, had you bought and sold perfectly

func profit(prices []int64) int64 {
	var minimum, profit int64 = math.MaxInt64, 0 // arb big number, so 1st loop declares 1st time

	for p := 0; p < len(prices); p++ {
		price := prices[p]
		if price < minimum {
			minimum = prices[p]
		}

		var difference = price - minimum
		if difference > profit {
			profit = difference
		}

	}
	return profit
}

func main() {
	println(profit([]int64{5, 50, 500, 7, 17, 3, 750, 2, 4, 8, 16, 34, 64, 128, 1}))
}
