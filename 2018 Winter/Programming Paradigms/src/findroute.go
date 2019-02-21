package src

import (
	"math"
	"os"
	"bufio"
	"strings"
	"bytes"
	"strconv"
	"sync"
	"sort"
	"reflect"
	"fmt"
)

//Data structures
type Pool struct {
	name      string
	longitude float64
	latitude  float64
}

type Edge struct {
	parent, child Pool
}

//Functions
func main() {
	saveRoute(findRoute(os.Args[1], 10), os.Args[2])
}

/*
Concurrent design strategy:
Instead of reading and processing one line at a time and building an Edge object from the processed information, we can
process lines and build Edge objects from each concurrently.
 */
func processLine(split []string, group *sync.WaitGroup, channel chan Pool) {
	var buffer bytes.Buffer
	for i := 0; i < len(split)-2; i++ {
		buffer.WriteString(split[i] + " ")
	}
	name := buffer.String()
	name = name[:len(name)-1]
	longitude, _ := strconv.ParseFloat(split[len(split)-2], 64)
	latitude, _ := strconv.ParseFloat(split[len(split)-1], 64)
	pool := Pool{name: name, longitude: longitude, latitude: latitude}
	channel <- pool
	defer group.Done()
}

func findRoute(filename string, num int) []Edge {
	var route []Edge
	var tree []Edge
	var pools []Pool
	var added []Pool
	file, _ := os.Open(filename)
	scanner := bufio.NewScanner(file)
	var group sync.WaitGroup
	channel := make(chan Pool)
	for {
		for i := 0; i < num; i++ {
			scanner.Scan()
			if len(scanner.Text()) > 0 {
				group.Add(1)
				go processLine(strings.Split(scanner.Text(), " "), &group, channel)
				pools = append(pools, <-channel)
			} else {
				break
			}
		}
		group.Wait()
		if len(scanner.Text()) == 0 {
			break
		}
	}
	file.Close()
	sort.Slice(pools, func(i, j int) bool {
		return pools[i].longitude < pools[j].longitude
	})
	root := pools[0]
	pools = pools[1:]
	minPosition := -1
	min := math.MaxFloat64
	for position, element := range pools {
		distance := distanceBetween(root, element)
		if distance < min {
			min = distance
			minPosition = position
		}
	}
	tree = append(tree, Edge{parent: root, child: pools[minPosition]})
	added = append(added, root, pools[minPosition])
	pools = append(pools[:minPosition], pools[minPosition+1:]...)
	for _, pool := range pools {
		minPosition = -1
		min = math.MaxFloat64
		for position, element := range added {
			distance := distanceBetween(pool, element)
			if distance < min {
				min = distance
				minPosition = position
			}
		}
		tree = append(tree, Edge{parent: added[minPosition], child: pool})
		added = append(added, pool)
	}
	return preorder(root, tree, route)
}

func saveRoute(route []Edge, filename string) bool {
	file, _ := os.Create(filename)
	defer file.Close()
	writer := bufio.NewWriter(file)
	sum := 0.0
	fmt.Fprint(writer, route[0].parent.name+" "+strconv.FormatFloat(sum, 'f', -1, 64)+"\r\n")
	sum += distanceBetween(route[0].parent, route[0].child)
	fmt.Fprint(writer, route[0].child.name+" "+strconv.FormatFloat(sum, 'f', -1, 64)+"\r\n")
	for i := 1; i < len(route); i++ {
		sum += distanceBetween(route[i-1].child, route[i].child)
		fmt.Fprint(writer, route[i].child.name+" "+strconv.FormatFloat(sum, 'f', -1, 64)+"\r\n")
	}
	writer.Flush()
	return true
}

func preorder(pool Pool, tree []Edge, route []Edge) []Edge {
	var toVisit []Edge
	for _, edge := range tree {
		if reflect.DeepEqual(edge.parent, pool) {
			toVisit = append(toVisit, edge)
		}
	}
	for _, edge := range toVisit {
		route = append(route, edge)
		route = preorder(edge.child, tree, route)
	}
	return route
}

func distanceBetween(pool1, pool2 Pool) float64 {
	return distance(pool1.longitude, pool1.latitude, pool2.longitude, pool2.latitude)
}

func distance(longitude1, latitude1, longitude2, latitude2 float64) float64 {
	return 6371 * 2 * math.Asin(math.Sqrt(math.Pow(math.Sin((toRadians(latitude1)-toRadians(latitude2))/2), 2) +
		math.Cos(toRadians(latitude1))*math.Cos(toRadians(latitude2)) *
			math.Pow(math.Sin((toRadians(longitude1)-toRadians(longitude2))/2), 2)))
}

func toRadians(angle float64) float64 {
	return angle * math.Pi / 180
}
