package et.oss.exceptions;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ErrorResponseBody {
    private String title;
    private Map<String, List<String>> response;

    public static ErrorResponseBody of(String title, String error) {
        return new ErrorResponseBody(title, Map.of("errors", List.of(error)));
    }

    public static ErrorResponseBody of(String title, Map<String, List<String>> errors) {
        return new ErrorResponseBody(title, errors);
    }
}