package main

import (
	"math/rand"
	"fmt"
	"math"
	"sync"
)

var group sync.WaitGroup

func main() {
	rand.Seed(100) // use this seed value
	out := make(chan float32, 1000)
	defer close(out)
	var sum float32
	for i := 0; i < 1000; i++ {
		a := RandomArray(2 * (50 + rand.Intn(50)))
		group.Add(1)
		go Process(a, out)
	}
	group.Wait()
	for len(out) > 0 {
		sum += <-out
	}
	fmt.Println(sum)
}

func RandomArray(len int) []float32 {
	array := make([]float32, len)
	for i := range array {
		array[i] = rand.Float32()
	}
	return array
}

func Process(array []float32, channel chan float32) {
	defer group.Done()
	first := array[:(len(array) / 2)]
	second := array[(len(array) / 2):]
	processed, _ := AbsDiff(first, second)
	var sum float32
	for _, element := range processed {
		sum += element
	}
	channel <- sum
}

func AbsDiff(sliceA, sliceB []float32) ([]float32, error) {
	var result []float32
	smallest := &sliceA
	if len(sliceB) < len(sliceA) {
		smallest = &sliceB
	}
	for i := range *smallest {
		result = append(result, float32(math.Abs(float64(sliceA[i])-float64(sliceB[i]))))
	}
	return result, nil
}
