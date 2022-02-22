package utilities;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashedPassword {
	
	// class for hashing a password
	
	private final String value;
	
	public HashedPassword(String password) throws UnsupportedEncodingException, NoSuchAlgorithmException {
		byte[] b = password.getBytes("ASCII");
	    MessageDigest md = MessageDigest.getInstance("SHA-256");
	    byte[] hashBytes = md.digest(b);
	    StringBuffer hexString = new StringBuffer();
	    for (int i = 0; i < hashBytes.length; i++) {
	        hexString.append(Integer.toHexString(0xFF & hashBytes[i]));
	    }
	    
	    this.value = hexString.toString();
	}	
	
	public String getHashedPassword() {
		return this.value;
	}
}