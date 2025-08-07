package examples.testBCP.helpers;

import org.mindrot.jbcrypt.BCrypt;

public class Encriptador {
    public static void main(String[] args) {
        String textoCrudo = "Credit Card Number 1234-5678-9012-3456";
        String textoEncriptado = hashPassword(textoCrudo);
        System.out.println("Texto Crudo: " + textoCrudo);
        System.out.println("Texto Encriptado: " + textoEncriptado);
        System.out.println("Verificando contraseña: " + checkPassword(textoCrudo, textoEncriptado));
    }

    public static String hashPassword(String text ) {
        return BCrypt.hashpw(text, BCrypt.gensalt(12));
    }

    public static boolean checkPassword(String text, String hashed) {
        return BCrypt.checkpw(text, hashed);
    }
}
