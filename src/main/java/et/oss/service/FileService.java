package et.oss.service;

import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface FileService {
    List<String> uploadFile(List<MultipartFile> file, Authentication authentication) throws IOException;
}