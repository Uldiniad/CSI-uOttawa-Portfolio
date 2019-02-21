#include <iostream>

using std::cin;
using std::cout;
using std::endl;
using std::string;

int main() {
    string first, second;
    cin >> first;
    cin >> second;
    if (first == second) {
        cout << "the strings are equal" << endl;
    } else {
        cout << "the strings are not equal" << endl;
    }
    if (first.size() == second.size()) {
        cout << "both strings are of equal length" << endl;
    } else {
        cout << "The larger string is " << ((first > second) ? first : second);
    }
    return 0;
}