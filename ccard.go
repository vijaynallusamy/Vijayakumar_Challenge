
package main

import (
	"fmt"
	"unicode"
)

func main() {
	var number string = "5234-5678-9101-1121"
	var numberofdigits int
	var hyphenposition int
	fmt.Println("The number to be checked is:", number)

	/*groupofnumbers,err := regexp.MatchString("\b(\d)\d+\b",number)
		 if err != nil {
	            log.Fatal(err)
	        }
		fmt.Println(groupofnumbers, "Given card is having consecutive identical numbers")*/

	firstcharacter := number[0:1]
	if firstcharacter == "4" || firstcharacter == "5" || firstcharacter == "6" {
		for i, cs := range number {
			if i == 4 || i == 9 || i == 14 {
				if cs != '-' {
					fmt.Println(hyphenposition, "Given card is having unknown special character")
					break
				}
			}

			if unicode.IsNumber(cs) {
				fmt.Println(string(cs), i)
				numberofdigits++
				if numberofdigits > 16 {
					fmt.Println("Given card is having too many numbers")
					break
				}

			}
		}
	}

}
