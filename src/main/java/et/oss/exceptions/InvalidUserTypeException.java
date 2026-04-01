package et.oss.exceptions;

public class InvalidUserTypeException extends RuntimeException {
    public InvalidUserTypeException(String message) {
        super(message);
    }
}
