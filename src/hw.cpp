#include <iostream>
#include <sstream>
#include <string>
#include <unistd.h> // for isatty() and fileno()

using namespace std;

const string WORLD = "\U0001F30E"; // 🌎 Earth Globe Americas

int main() {
    // Check if stdin is a terminal (not piped)
    if (isatty(fileno(stdin))) {
        // No piped input
        cout << "Hello, " << WORLD << '!' << endl;
    } else {
        // There is piped input
        ostringstream oss;
        oss << cin.rdbuf();
        string input = oss.str();
        // Remove trailing newline (optional, improves output for typical use)
        if (!input.empty() && input.back() == '\n') input.pop_back();

        cout << "Hello, " << input << '!' << endl;
    }
    return 0;
}