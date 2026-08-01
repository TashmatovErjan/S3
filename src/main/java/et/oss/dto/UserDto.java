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

    @NotBlank(message = "Mail cannot be empty")
    @Email(message = "Incorrect mail format")
    private String email;

    private Long roleId;

    private Long storageQuota;

}
