package et.oss.service;

import et.oss.dto.FileDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface FileService {
    List<String> uploadFile(List<MultipartFile> file, Authentication authentication) throws IOException;

    Page<FileDto> getAllFilesByUser(Pageable pageable, Authentication authentication);
}