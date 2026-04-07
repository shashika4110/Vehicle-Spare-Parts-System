import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class GenerateHash {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String password = "password123";
        String hash = encoder.encode(password);
        
        System.out.println("Plain password: " + password);
        System.out.println("BCrypt hash: " + hash);
        System.out.println("\nSQL Update command:");
        System.out.println("UPDATE users SET password = '" + hash + "';");
        
        // Verify it works
        boolean matches = encoder.matches(password, hash);
        System.out.println("\nVerification: " + matches);
    }
}
