package utilities;

import java.util.Random;

public class RandomString8 {
	
	// class for generating a 8-chars random string
	
	private final String value;
	
	public RandomString8(int n) {
	    int leftLimit = 48; // numeral '0'
	    int rightLimit = 122; // letter 'z'
	    int targetStringLength = n;
	    Random random = new Random();

	    String generatedString = random.ints(leftLimit, rightLimit + 1)
	      .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
	      .limit(targetStringLength)
	      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
	      .toString();
	    
	    this.value = generatedString;
	}
	
	public String getRandomString() {
		return this.value;
	}
}