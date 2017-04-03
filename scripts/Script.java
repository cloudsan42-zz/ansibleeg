import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Script {

	public static void main(String[] args) throws FileNotFoundException, IOException {

		String everything;
		try (BufferedReader br = new BufferedReader(new FileReader("testfile.txt"))) {
			StringBuilder sb = new StringBuilder();
			String line = br.readLine();

			while (line != null) {
				sb.append(line);
				sb.append(System.lineSeparator());
				line = br.readLine();
			}
			everything = sb.toString().trim();
		}
		System.out.println(" "+everything.split(":")[1]);
	}
}
