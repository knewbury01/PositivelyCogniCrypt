package ConstraintErrorExample.ConstraintErrorExample;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.Console;

public class ConsoleIn {

	public static void main(String[] args) throws NoSuchAlgorithmException, IOException {
		
		entry();
	}

    public static void entry() throws NoSuchAlgorithmException, IOException{

                String msg = getSHA256();
                System.out.println(msg);

    }
    
	private static String getSHA256() throws IOException, NoSuchAlgorithmException
    {
	String msgInstance = getInstanceStringFromStdIn();
	System.out.print(msgInstance);
        MessageDigest md = MessageDigest.getInstance(msgInstance);

	byte[] ba = new byte['c'];
        md.update(ba);
        byte[] result = md.digest();
        String sb = new String(result);
        return sb;
    }

    private static String getInstanceStringFromStdIn() throws IOException{
	Console console = System.console();
	String st = console.readLine();
	return st;
    } 
	
}
