import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class UpdatePassword {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String password = "password123";
        String encodedPassword = encoder.encode(password);
        System.out.println("Encoded password for 'password123':");
        System.out.println(encodedPassword);
        
        // Test if it matches
        boolean matches = encoder.matches(password, encodedPassword);
        System.out.println("\nPassword matches: " + matches);
    }
}
