package main

import (
	"testing"
)

func TestUniqueStrings(t *testing.T) {
	type args struct {
		s string
	}

	tests := []struct {
		name      string
		pastlines []string
		testline  string
		new       bool
	}{
		{"No Entries - Add one", []string{}, "test", true},
		{"Single Entry - Add dupe", []string{"test"}, "test", false},
		{"Multiple Entries - adjacent tail dupe", []string{"test", "test2"}, "test2", false},
		{"Multiple Entries - non-adjacent head dupe", []string{"test", "test2"}, "test", false},
		{"Multiple Entries - non-adjacent dupe in middle", []string{"test", "test2", "test3"}, "test2", false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			us := &UniqueStrings{
				entries: sliceToMap(tt.pastlines),
			}
			if got := us.add(tt.testline); got != tt.new {
				t.Errorf("UniqueStrings.add() = %v, expected %v", got, tt.new)
			}
		})
	}
}

func sliceToMap(elements []string) map[string]struct{} {
	elementMap := make(map[string]struct{})
	for _, s := range elements {
		elementMap[s] = struct{}{}
	}
	return elementMap
}
