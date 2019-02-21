#include <iostream>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::vector;

int main() {
    vector<string> sep;
    string string, concat;
    while (string != "stop") {
        cin >> string;
        if (string != "stop") {
            concat += string;
            sep.push_back(string);
        }
    }
    cout << concat << endl;
    for (auto output:sep) {
        cout << output + " ";
    }
    return 0;
}