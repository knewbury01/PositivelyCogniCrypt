package ConstraintErrorExample.ConstraintErrorExample;
    
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.lang.Character;
import java.io.FileReader;

public class FileRead {

	public static void main(String[] args) throws NoSuchAlgorithmException, IOException {
		
		entry();
	}

    public static void entry() throws NoSuchAlgorithmException, IOException{

                String msg = getSHA256();
                System.out.println(msg);

    }
    
	private static String getSHA256() throws IOException, NoSuchAlgorithmException
    {
	String msgInstance = getInstanceStringFromFile();
	msgInstance = msgInstance.replace("\n", "");
	System.out.print(msgInstance);
        MessageDigest md = MessageDigest.getInstance(msgInstance);

	byte[] ba = new byte['c'];
        md.update(ba);
        byte[] result = md.digest();
        String sb = new String(result);
	return sb;
    }

    private static String getInstanceStringFromFile() throws IOException{
	FileReader file = new FileReader("./resources/msgInst.txt");
	String st = "";
	 int i; 
	 while ((i=file.read()) != -1){
	     char c = (char)i;
	     String s= Character.toString(c);
	     st=st+s;
	     }

	     return st;

    }
}
