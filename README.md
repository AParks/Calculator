import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;


public class Calc {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args){
		

		
		try {
			BufferedReader rd = new BufferedReader(new InputStreamReader(System.in));
			String line = rd.readLine();
			while (!line.equals("")) {
				String[] toks = line.split(" ");
				double output = Double.parseDouble(toks[0]);
				for (int i = 1; i < toks.length; i+=2) {
					double op1 = output;
					double op2 = Double.parseDouble(toks[i + 1]);					
					String operator = toks[i];
					output = calculate(op1, operator, op2);
				}
				System.out.println(output);
				line = rd.readLine();
			}
			rd.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}


	}
	
	private static double calculate (double op1, String operator, double op2){
		switch (operator) {
			case "*":
				return op1 * op2;		
			case "/":
				return op1 / op2;				
			case "+":
				return op1 + op2;
			case "-": 
				return op1 - op2;
			case "^":
				return Math.pow(op1,op2);		
		}
		return 0;
	}
	
	


}
