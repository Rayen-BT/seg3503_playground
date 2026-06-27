package fizzbuzz;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.util.List;

public class FizzBuzzTest {

    private FizzBuzz fb;

    @BeforeEach
    public void setUp() {
        fb = new FizzBuzz();
    }

    @Test
    public void testFizzbuzzReturnsNumber() {
        assertEquals("1", fb.fizzbuzz(1));
        assertEquals("2", fb.fizzbuzz(2));
        assertEquals("4", fb.fizzbuzz(4));
        assertEquals("7", fb.fizzbuzz(7));
    }
}