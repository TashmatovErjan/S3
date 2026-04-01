package et.oss.service;

import et.oss.exceptions.ErrorResponseBody;
import org.springframework.validation.BindingResult;

public interface ErrorService {
    ErrorResponseBody makeResponse(String title, String message);

    ErrorResponseBody makeResponse(BindingResult bindingResult);
}
