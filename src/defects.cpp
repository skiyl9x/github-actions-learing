// Demo file with intentional defects that cppcheck detects.
// Do NOT use this code in production.
#include <cstdio>
#include <cstring>

// 1. Array index out of bounds: the loop reads values[5]
int sumValues() {
    int values[5] = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int i = 0; i <= 4; ++i) {
        sum += values[i];
    }
    return sum;
}

// 2. Null pointer dereference
int readValue() {
    int* ptr = nullptr;
    return *ptr;
}

// 3. Uninitialized variable
int counter() {
    int count;
    return count + 1;
}

// 4. Memory leak: buffer is never deleted
void copyName() {
    char* buffer = new char[100];
    std::strcpy(buffer, "demo");
    std::printf("%s\n", buffer);
}

// 5. Mismatched allocation: new[] released with delete
void releaseArray() {
    int* numbers = new int[10];
    numbers[0] = 1;
    delete numbers;
}

// 6. Resource leak: file is never closed
void printFirstChar(const char* path) {
    FILE* file = std::fopen(path, "r");
    if (!file) {
        return;
    }
    std::printf("%c\n", std::fgetc(file));
}

// 7. Buffer overrun: 9 bytes copied into a 4-byte array
void shortBuffer() {
    char name[4];
    std::strcpy(name, "too long");
    std::printf("%s\n", name);
}

int main() {
    std::printf("%d\n", sumValues());
    std::printf("%d\n", readValue());
    std::printf("%d\n", counter());
    copyName();
    releaseArray();
    printFirstChar("/etc/hostname");
    shortBuffer();
    return 0;
}
