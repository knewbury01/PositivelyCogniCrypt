package ConstraintErrorExample.ConstraintErrorExample;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Base64;

public class BaseEncodeGood {

	public static void main(String[] args) throws NoSuchAlgorithmException, IOException {
		
		entry();
	}

    public static void entry() throws NoSuchAlgorithmException, IOException{

                String msg = getSHA256();
                System.out.println(msg);

    }
    
	private static String getSHA256() throws IOException, NoSuchAlgorithmException
    {

	byte[] bytes = "SHA-256".getBytes();
	String encodedString = Base64.getEncoder().encodeToString(bytes);
	byte[] decodedBytes = Base64.getDecoder().decode(encodedString);
	String msgInstance = new String(decodedBytes);

	System.out.print(msgInstance);
        MessageDigest md = MessageDigest.getInstance(msgInstance);

	byte[] ba = new byte['c'];
	md.update(ba);
	byte[] result = md.digest();
	String sb = new String(result);
	return sb;
    }

}
