package main

import (
	"bufio"
	"fmt"
	"os"
)

// UniqueStrings Maintains a list of unique strings
type UniqueStrings struct {
	entries map[string]struct{} // string->zero width no cost struct
}

// @return false if already tracking, true if new entry was added
func (us *UniqueStrings) add(s string) bool {

	if _, present := us.entries[s]; !present {
		us.entries[s] = struct{}{}
		return true
	}

	return false
}

// NewUniqueStrings makes a new UniqueStrings ready for use
func NewUniqueStrings() *UniqueStrings {
	var us = new(UniqueStrings)
	us.entries = map[string]struct{}{}
	return us
}

func main() {
	us := NewUniqueStrings()
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()

		if us.add(line) {
			fmt.Println(line)
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}
