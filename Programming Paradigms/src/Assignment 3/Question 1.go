package main

import (
	"errors"
	"strings"
	"strconv"
	"math"
	"bufio"
	"os"
	"fmt"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	fmt.Println("What version of AbsDiff do you want to run? (-1,0,1)")
	scanner.Scan()
	version, err := strconv.Atoi(scanner.Text())
	if err != nil || (version != -1 && version != 0 && version != 1) {
		panic(errors.New("entered version of AbsDiff does not exist"))
	} else {
		fmt.Println("Enter a slice of floating point numbers (anything else to end slice)")
		scanner.Scan()
		sliceA := stringToSlice(scanner.Text())
		sliceB := newSlice(sliceA, version, scanner)
		for {
			fmt.Println("Previous slice: ", sliceB)
			sliceA = sliceB
			newSlice(sliceA, version, scanner)
		}
	}
}

func newSlice(sliceA []float32, version int, scanner *bufio.Scanner) ([]float32) {
	fmt.Println("Enter another slice of floating point numbers (anything else to end slice)")
	scanner.Scan()
	sliceB := stringToSlice(scanner.Text())
	result, _ := AbsDiff(sliceA, sliceB, version)
	fmt.Println("Result: ", result)
	fmt.Println()
	fmt.Println("q to quit (anything else to continue)")
	scanner.Scan()
	if scanner.Text() == "q" {
		os.Exit(0)
	}
	return sliceB
}

func stringToSlice(string string) ([]float32) {
	temp := strings.Split(string, " ")
	var result []float32
	for _, element := range temp {
		value, err := strconv.ParseFloat(element, 32)
		if err != nil {
			break
		}
		result = append(result, float32(value))
	}
	return result
}

func AbsDiff(sliceA, sliceB []float32, version int) ([]float32, error) {
	var result []float32
	if version == 0 {
		if len(sliceA) != len(sliceB) {
			panic(errors.New("entered slices do not have the same length"))
		}
	}
	smallest := &sliceA
	biggest := &sliceB
	if len(sliceB) < len(sliceA) {
		smallest = &sliceB
		biggest = &sliceA
	}
	for i := range *smallest {
		result = append(result, float32(math.Abs(float64(sliceA[i])-float64(sliceB[i]))))
	}
	if version == -1 {
		result = append(result, make([]float32, len(*biggest)-len(*smallest))...)
	}
	return result, nil
}
