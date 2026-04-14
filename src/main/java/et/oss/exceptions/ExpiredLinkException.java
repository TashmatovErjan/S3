package et.oss.exceptions;

public class ExpiredLinkException extends RuntimeException {
    public ExpiredLinkException(String message) {
        super(message);
    }
}