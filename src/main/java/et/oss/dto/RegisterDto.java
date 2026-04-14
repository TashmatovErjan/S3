package et.oss.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDto {

    @NotBlank(message = "Mail cannot be empty")
    @Email(message = "Incorrect mail format")
    private String email;

    @NotBlank(message = "The password cannot be empty")
    @Pattern(regexp = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).+$",
            message = "Incorrect password pattern")
    @Size(min = 8, message = "Minimum 8 characters")
    private String password;

    private Long roleId;

}
