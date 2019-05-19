package main

import (
	"testing"
)

func TestUniqueStrings(t *testing.T) {
	type args struct {
		s string
	}

	type lineset map[string]struct{}

	tests := []struct {
		name    string
		entries lineset
		arg     string
		added   bool
	}{
		{"No Entries - Add one", lineset{}, "test", true},
		{"Single Entry - Add dupe", lineset{"test": {}}, "test", false},
		{"Multiple Entries - adjacent tail dupe", lineset{"test": {}, "test2": {}}, "test2", false},
		{"Multiple Entries - non-adjacent head dupe", lineset{"test": {}, "test2": {}}, "test", false},
		{"Multiple Entries - non-adjacent dupe in middle", lineset{"test": {}, "test2": {}, "test3": {}}, "test2", false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			dt := &UniqueStrings{
				entries: tt.entries,
			}
			if got := dt.add(tt.arg); got != tt.added {
				t.Errorf("DupeTracker.track() = %v, expected %v", got, tt.added)
			}
		})
	}
}
