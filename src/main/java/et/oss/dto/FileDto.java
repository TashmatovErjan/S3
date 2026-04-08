package et.oss.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FileDto {
    private Long id;
    private String fileName;
    private String originalName;
    private Long size;
    private LocalDateTime createDate;
    private String fileType;
    private Long authorId;
}
