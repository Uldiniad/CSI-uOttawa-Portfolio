package main

import "fmt"

func main() {
	add := make(map[string]Item)
	remove := make(map[string]Item)
	available := make(map[string]Item)
	var shoppingList map[string]Item
	add["white flour"] = Item{250}
	add["whole wheat flour"] = Item{250}
	add["sesame"] = Item{50}
	remove["whole wheat flour"] = Item{500}
	available["whole wheat flour"] = Item{5000}
	available["salt"] = Item{500}
	available["sugar"] = Item{1000}
	bakers := []Baker{NewBread(), NewBreadVariation("Sesame", add, remove)}
	for k, i := range bakers {
		var needed map[string]Item
		i.printBreadInfo()
		i.printBakeinstructions()
		needed, available = i.shoppingList(available)
		fmt.Println()
		if k == 0 {
			shoppingList = needed
		} else {
			for j := range needed {
				if _, exists := shoppingList[j]; !exists {
					shoppingList[j] = needed[j]
				} else {
					shoppingList[j] = Item{shoppingList[j].weight + needed[j].weight}
				}
			}
		}
	}
	fmt.Println("Shopping List")
	fmt.Println(shoppingList)
}

type Bread struct {
	name        string
	ingredients map[string]Item
	weight      float32
	baking      Baking
}

type Item struct {
	weight int
}

type Baking struct {
	bakeTime, coolTime, temperature int
}

type Baker interface {
	shoppingList(map[string]Item) (map[string]Item, map[string]Item)
	printBakeinstructions()
	printBreadInfo()
}

func NewBread() *Bread {
	ingredients := make(map[string]Item)
	ingredients["whole wheat flour"] = Item{500}
	ingredients["yeast"] = Item{25}
	ingredients["salt"] = Item{25}
	ingredients["sugar"] = Item{50}
	ingredients["butter"] = Item{50}
	ingredients["water"] = Item{350}
	var totalWeight int
	for _, v := range ingredients {
		totalWeight += v.weight
	}
	return &Bread{"Whole Wheat", ingredients, float32(totalWeight),
		Baking{120, 60, 180}}
}

func NewBreadVariation(name string, add map[string]Item, remove map[string]Item) *Bread {
	base := NewBread()
	base.name = name
	for k := range remove {
		delete(base.ingredients, k)
	}
	for k, v := range add {
		base.ingredients[k] = v
	}
	return base
}

func (bread Bread) shoppingList(available map[string]Item) (map[string]Item, map[string]Item) {
	needed := make(map[string]Item)
	for k, v := range bread.ingredients {
		if available[k].weight-v.weight > 0 {
			available[k] = Item{available[k].weight - v.weight}
		} else {
			if _, exists := available[k]; exists {
				delete(available, k)
			}
			needed[k] = bread.ingredients[k]
		}
	}
	return needed, available
}

func (bread Bread) printBakeinstructions() {
	fmt.Println("Bake at", bread.baking.temperature, "Celsius for", bread.baking.bakeTime,
		"minutes and let cool for", bread.baking.coolTime, "minutes")
}

func (bread Bread) printBreadInfo() {
	fmt.Println(bread.name)
	fmt.Println(bread.ingredients)
	fmt.Println("Weight:", bread.weight, "g")
}
