package sagde.comun;

import java.util.StringTokenizer;

public class Util {

    // Util.getSimpleName(fichero.getName())
    public static String getSimpleName(String cadena) {
        StringTokenizer str = new StringTokenizer(cadena, "\\");
        String name = str.nextToken();
        while (str.hasMoreTokens()) {
            name = str.nextToken();
        }
        return name;
    }

    public static String slash() {
        String so = System.getProperty("os.name");
        if (so.contains("Windows")) {
            return "\\";
        } else {
            return "/";
        }
    }

}
