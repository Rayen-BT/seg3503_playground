package fizzbuzz;

public class FizzBuzz {

    public String fizzbuzz(int n) {
        if (n % 3 == 0)
            return "Fizz";
        return String.valueOf(n);
    }
}