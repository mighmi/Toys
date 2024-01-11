package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// define new words so:
// : DOUBLE 2 * ;
// 5 DOUBLE .

type ForthInterpreter struct {
	stack []int
	words map[string]func()
}

func NewInterpreter() *ForthInterpreter {
	return &ForthInterpreter{
		stack: make([]int, 0),
		words: make(map[string]func()),
	}
}

func (fi *ForthInterpreter) Push(value int) {
	fi.stack = append(fi.stack, value)
}

func (fi *ForthInterpreter) Pop() int {
	if len(fi.stack) == 0 {
		panic("Stack underflow")
	}
	value := fi.stack[len(fi.stack)-1]
	fi.stack = fi.stack[:len(fi.stack)-1]
	return value
}

func (fi *ForthInterpreter) DefineWord(name string, fn func()) {
	fi.words[name] = fn
}

func (fi *ForthInterpreter) ExecuteWord(word string) {
	if fn, ok := fi.words[word]; ok {
		fn()
	} else {
		// Assume it's a number and push onto the stack
		value, err := strconv.Atoi(word)
		if err != nil {
			panic("Unknown word: " + word)
		}
		fi.Push(value)
	}
}

func main() {
	interpreter := NewInterpreter()

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		words := strings.Fields(line)

		for _, word := range words {
			interpreter.ExecuteWord(word)
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error reading standard input:", err)
		os.Exit(1)
	}
}
