# SEG3503 - Lab 04: Test-Driven Development

## Project

**fizzbuzz_java** - FizzBuzz implemented in Java using TDD.

## How to run the tests

```bash
cd fizzbuzz_java
mvn test
```

## Commit Groups

| Group | Failed Test Commit | Passed Test Commit | Description |
|-------|-------------------|--------------------|-------------|
| Group 1: Regular numbers return themselves as a string | red: b569b833f3053a1637fca36c9adc4042581e1958 | green: 5b53067147568f0d3de14532885a521a68c33aba | The test checks that fizzbuzz(1) returns "1", fizzbuzz(2) returns "2" and so on. It failed because fizzbuzz(int) did not exist yet. It was implemented by returning String.valueOf(n) which converts the integer to its string form. |
| Group 2: Multiples of 3 return Fizz | red: 525272da56b18769210a2051cc985b7994135c4f | green: 87b06ab6f8fe6c47dacef0b42683044db13055e8 | The test checks that fizzbuzz(3), fizzbuzz(6), fizzbuzz(9) and fizzbuzz(99) all return "Fizz". It failed because the method just returned the number as a string. It was implemented by adding a check for n % 3 == 0 before the default return. |
| Group 3: Multiples of 5 return Buzz | red: c418bdc433815d3097435311b4e5463212773d8c | green: 73730bdf565910d525f440ea1a992f499bb521cd | The test checks that fizzbuzz(5), fizzbuzz(10), fizzbuzz(20) and fizzbuzz(100) all return "Buzz". It failed because only the Fizz check existed. It was implemented by adding a check for n % 5 == 0 after the Fizz check. |
| Group 4: Multiples of 15 return FizzBuzz | red: 65d71ab7bfcf8d159f0035105440435d4a00863a | green: a41d006a120f6382c53483095a56d0efea550dcf | The test checks that fizzbuzz(15), fizzbuzz(30), fizzbuzz(45) and fizzbuzz(90) all return "FizzBuzz". It failed because fizzbuzz(15) was caught by the divisibility by 3 check first and returned "Fizz". It was fixed by adding a check for n % 15 == 0 at the very top before the other checks. |
| Group 5: Range method returns the full sequence | red: 5cbb1acdc8e83b3d1572291d9da787da64b6714c | green: 617901de1413717bf83c57162af23fb005830423 | The test checks that fizzbuzzRange(1, 5) returns the list ["1", "2", "Fizz", "4", "Buzz"] and that fizzbuzzRange(14, 16) returns ["14", "FizzBuzz", "16"]. It failed because fizzbuzzRange(int, int) did not exist yet. It was implemented using a loop from start to end that calls fizzbuzz(int) for each number and adds the result to a list. |