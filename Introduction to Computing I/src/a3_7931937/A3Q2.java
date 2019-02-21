// Family name, Given name:
// Student number:
// Course: IT1 1120
// Assignment Number

import java.util.Scanner;

public class A3Q2 {
    public static void main(String[] args) {

        // part (a) of the main

        Scanner keyboard = new Scanner(System.in);

        System.out.println("***************************");
        System.out.println("        Part (a)");
        System.out.println("***************************");

        do {
            System.out.println("Enter a word and then press enter:");
            String str = keyboard.next();
            char[] word = str.toCharArray();

            isSquareFree(word);
            System.out.println("Do you want to test another word? Press y for yes, or another key for no");

        } while (keyboard.next().charAt(0) == 'y');

        // part (b) of the main

        System.out.println();
        System.out.println("***************************");
        System.out.println("        Part (b)");
        System.out.println("***************************");

        System.out.println("How long a square free word on letters a, b and c do you want?");
        System.out.println("Enter an integer greater than zero");
        int word_length = keyboard.nextInt();

        char[] square_free_word = makeSquareFree(word_length);

        System.out.println("Here is a square-free word of length " + word_length);
        for (int i = 0; i < word_length; i++) {
            System.out.print(square_free_word[i]);
        }
        System.out.println();


  /* by uncommenting the method call below, you can call isSquareFree with your created word
   to verify that indeed it is square free */

        isSquareFree(square_free_word);

  /* uncomment the method call below if you want to test if you solution
   for part b is correct for n=1000. To use it, type in 1000 for the length when prompted by the program,
   the method below will tell you if the word you created is indeed a correct word of length 1000 as per Thue procedure. */

        test(square_free_word);
    }

    public static void isSquareFree(char[] word) {
        boolean squarefree = true; //the word is square-free until contrary proof
        boolean afterFirstLetter; //declare variable to check if the letters after the repeated letter are the same
        int i, j, k; // declare counters
        j = 0; // initialize j (compiler complains otherwise)
        for (i = 0; (i < word.length - 1) && squarefree; i++) { // loop to compare all the letters up to the letter before last
            for (j = i + 1; (j < word.length) && squarefree; j++) { // loop with who the first loop compares letters up to the last
                if (word[i] == word[j]) { // if two letters are equal
                    afterFirstLetter = true; // the next letters in the repeated subword are equal until contrary proof
                    for (k = 1; (k < (j - i)) && afterFirstLetter; k++) { // counter going up to the last letter before the first repeated letter
                        if (k == (word.length - j)) { // this condition verifies if the counter for the next letter is the same as the length of the word - the counter for the repeated letter. If true the next letter is not repeated since it is before the last letter which is the repeated one.
                            afterFirstLetter = false; // explained above

                        } else if (((k)) < word.length - j) { // if the counter is smaller than the length of the word - the counter for the repeated letter,
                            if (!(word[i + k] == word[j + k])) {// verify if the next letter of the first repeated subword is not the same as the next letter of the second repeated subword
                                afterFirstLetter = false;// if the letters are not the same, boolean afterFirstLetter is false and te word is squarefree
                            }
                        }
                    }
                    squarefree = !afterFirstLetter;
                }
            }
        }
        int y = i;// y keeps track of the position of the first letter of the repeated subword
        i--;// to print the first letter of the repeated subword, the counter must be diminished by 1
        System.out.print("The word ");
        for (int x = 0; x < word.length; x++) {// loop to print the entered word
            System.out.print(word[x]);
        }
        System.out.print(" is ");
        if (squarefree) {
            System.out.println("square free.");
        } else {
            System.out.println("not square free, since it has subword, ");
            for (; i < j - 1; i++) {// loop to print the subword. prints from the first repeated letter to the position before the second time the letter is repeated
                System.out.print(word[i]);
            }
            System.out.println(((" at least twice starting at the position " + (y) + " of the word.")));
        }
    }

    // a method the produces a square free word of length n based on Thue's construction
    public static char[] makeSquareFree(int n) {

        char[] sfword = new char[n];
        boolean noMoreZero=false;
        sfword[0] = 'a';
            for (int x = 1; x<sfword.length;x++)
            {
                sfword[x]='0';
            }
        while(!(noMoreZero)) {
            int sumOfOffsets=0;
            int offset;
            for (int i = 0; i < sfword.length; i++) {
                if (i+sumOfOffsets<sfword.length){
                if (sfword[i+sumOfOffsets] == 'a') {
                    offset = 4;
                    for (int j = sfword.length - offset -1; (j > i) && ((j + offset) > (i + sumOfOffsets)); j--) {
                        sfword[j + offset] = sfword[j];
                    }
                    if ((i+1+sumOfOffsets)<sfword.length)
                        sfword[i + 1+sumOfOffsets] = 'b';
                    if ((i+2+sumOfOffsets)<sfword.length)
                        sfword[i + 2+sumOfOffsets] = 'c';
                    if ((i+3+sumOfOffsets)<sfword.length)
                        sfword[i + 3+sumOfOffsets] = 'a';
                    if ((i+4+sumOfOffsets)<sfword.length)
                        sfword[i + 4+sumOfOffsets] = 'b';
                    sumOfOffsets+=offset;
                } else if (sfword[i+sumOfOffsets] == 'b') {
                    offset = 5;
                    for (int j = sfword.length - offset -1; (j > i) && ((j + offset) > (i + sumOfOffsets)); j--) {
                        sfword[j + offset] = sfword[j];
                    }
                    if ((i+sumOfOffsets)<sfword.length)
                    sfword[i+sumOfOffsets] = 'a';
                    if ((i+1+sumOfOffsets)<sfword.length)
                    sfword[i + 1+sumOfOffsets] = 'c';
                    if ((i+2+sumOfOffsets)<sfword.length)
                    sfword[i + 2+sumOfOffsets] = 'a';
                    if ((i+3+sumOfOffsets)<sfword.length)
                    sfword[i + 3+sumOfOffsets] = 'b';
                    if ((i+4+sumOfOffsets)<sfword.length)
                    sfword[i + 4+sumOfOffsets] = 'c';
                    if ((i+5+sumOfOffsets)<sfword.length)
                    sfword[i + 5+sumOfOffsets] = 'b';
                    sumOfOffsets+=offset;
                } else if (sfword[i+sumOfOffsets] == 'c') {
                    offset = 6;
                    for (int j = sfword.length - offset -1; (j > i) && ((j + offset) > (i + sumOfOffsets)); j--) {
                        sfword[j + offset] = sfword[j];
                    }
                    if ((i+sumOfOffsets)<sfword.length)
                    sfword[i+sumOfOffsets] = 'a';
                    if ((i + 1+sumOfOffsets) < sfword.length)
                        sfword[i + 1+sumOfOffsets] = 'c';
                    if ((i + 2+sumOfOffsets) < sfword.length)
                        sfword[i + 2+sumOfOffsets] = 'b';
                    if ((i + 3+sumOfOffsets) < sfword.length)
                        sfword[i + 3+sumOfOffsets] = 'c';
                    if ((i + 4+sumOfOffsets) < sfword.length)
                        sfword[i + 4+sumOfOffsets] = 'a';
                    if ((i + 5+sumOfOffsets) < sfword.length)
                        sfword[i + 5+sumOfOffsets] = 'c';
                    if ((i + 6+sumOfOffsets) < sfword.length)
                        sfword[i + 6+sumOfOffsets] = 'b';
                    sumOfOffsets += offset;
                }
                }
            }
            noMoreZero = true;
            for (int y = 0; (y < sfword.length) && noMoreZero; y++) {
                if (sfword[y] == '0') {
                    noMoreZero = false;
                }
            }
        }
        return sfword;
    }


    // a method that tests if a given word of length 1000, is a square-free produced as per Thue's construction
    public static void test(char[] your_sfword) {

        if (your_sfword.length != 1000) {
            System.out.println("This method only tests if part (b) correctly generates a word of length 1000." +
                    "\n Enter 1000 the next time if you want to use this method");
            return;
        }

        String s1 = new String(your_sfword);
        String s2 = "abcabacabcbacbcacbabcabacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabcbabcabacabcbacbcacbabcabacabcbabcabacbcacbabcabacabcbacbcacbacabcbabcabacbcacbacabcbacbcacbabcabacbcacbacabc";
        if (s1.equals(s2)) {
            System.out.println("Your Thue-procedure-based square-free word of length 1000 is correct.");
        } else {
            System.out.println("Your Thue-procedure-based square-free word of length 1000 is not correct.");
        }

    }

}