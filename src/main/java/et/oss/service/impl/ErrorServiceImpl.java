package et.oss.service.impl;


import et.oss.exceptions.ErrorResponseBody;
import et.oss.service.ErrorService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ErrorServiceImpl implements ErrorService {

    @Override
    public ErrorResponseBody makeResponse(String title, String message) {
        return ErrorResponseBody.builder()
                .title(title)
                .response(Map.of("errors", List.of(message)))
                .build();
    }

    @Override
    public ErrorResponseBody makeResponse(BindingResult bindingResult) {
        Map<String, List<String>> reasons = bindingResult.getFieldErrors().stream()
                .filter(e -> e.getDefaultMessage() != null)
                .collect(Collectors.groupingBy(
                        FieldError::getField,
                        Collectors.mapping(FieldError::getDefaultMessage, Collectors.toList())
                ));
        return ErrorResponseBody.builder()
                .title("Validation Error")
                .response(reasons)
                .build();
    }
}
