# seg3503_playground

This repo is for SEG3503 lab work. It has two small projects — one in Java with JUnit, and one in Elixir with ExUnit. Both implement a simple division function and test it.

---

## Running the Java project (newmath_java)

Make sure you have Java installed. You can check by running `java -version` in a terminal — anything JDK 11 or newer works.

Open the `newmath_java` folder in VSCode, then open the integrated terminal (`` Ctrl+` ``) and run:

```bash
bash bin/test
```

That script handles everything — it cleans old build files, compiles the source and test files, and runs the JUnit tests. You should see output that ends with something like:

```
[  2 tests found        ]
[  2 tests successful   ]
[  0 tests failed       ]
```

The two tests check that dividing normally works, and that dividing by zero throws an exception like it should.

---

## Running the Elixir project (newmath_ex)

Make sure you have Elixir installed. You can check with `elixir --version`. If you don't have it, grab it from https://elixir-lang.org/install.html.

Open the `newmath_ex` folder in VSCode, open the terminal, and run:

```bash
mix test
```

You should see:

```
1 doctest, 2 tests, 0 failures
```

The tests cover dividing two numbers and what happens when you try to divide by zero — in Elixir the function returns `{:error, "Cannot divide by zero"}` instead of throwing.

---

## Project structure

```
seg3503_playground/
├── README.md
├── newmath_java/
│   ├── src/
│   │   ├── Newmath.java       
│   │   └── Main.java          
│   ├── test/
│   │   └── NewmathTest.java   
│   ├── lib/
│   │   └── junit-platform-console-standalone-1.7.1.jar
│   └── bin/
│       ├── compile
│       ├── test
│       └── clean
└── newmath_ex/
    ├── lib/
    │   └── newmath_ex.ex      
    ├── test/
    │   └── newmath_ex_test.exs
    └── mix.exs
```

