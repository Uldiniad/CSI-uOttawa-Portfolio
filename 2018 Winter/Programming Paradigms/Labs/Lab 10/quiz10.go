package main

import "fmt"

// Define a suitable structure
type Course struct {
	number_of_students int
	professor          string
	average            float64
}

func main() {
	// Create a dynamic map m
	courses := make(map[string]Course)
	// Add the courses CSI2120 and CSI2110 to the map
	courses["CSI2110"] = Course{186, "Lang", 79.5}
	courses["CSI2120"] = Course{211, "Moura", 81}

	for k, v := range courses {
		fmt.Printf("Course Code: %s\n", k)
		fmt.Printf("Number of students: %d\n", v.number_of_students)
		fmt.Printf("Professor: %s\n", v.professor)
		fmt.Printf("Average: %f\n\n", v.average)
	}
}
