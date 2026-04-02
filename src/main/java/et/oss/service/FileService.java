package et.oss.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface FileService {
    List<String> uploadFile(List<MultipartFile> file) throws IOException;
}