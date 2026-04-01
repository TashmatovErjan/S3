package et.oss.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    private Long id;

    @NotBlank(message = "почта не может быть пустой ")
    @Email(message = "неправильный формат почты ")
    private String email;

    @NotBlank(message = "пароль не может быть пустым")
    @Pattern(regexp = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).+$",
            message = "неправильный паттерн пароля")
    @Size(min = 8, message = "минимум 8 знаков ")
    private String password;

    private Long roleId;

}
