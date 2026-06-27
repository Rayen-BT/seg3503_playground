package fizzbuzz;

import java.util.ArrayList;
import java.util.List;

public class FizzBuzz {

    public String fizzbuzz(int n) {
        if (n % 15 == 0)
            return "FizzBuzz";
        if (n % 3 == 0)
            return "Fizz";
        if (n % 5 == 0)
            return "Buzz";
        return String.valueOf(n);
    }

    public List<String> fizzbuzzRange(int start, int end) {
        List<String> result = new ArrayList<>();
        for (int i = start; i <= end; i++) {
            result.add(fizzbuzz(i));
        }
        return result;
    }
}