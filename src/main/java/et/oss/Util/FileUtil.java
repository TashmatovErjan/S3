package et.oss.Util;

import et.oss.exceptions.FileStorageException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpStatus;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;


@Service
public class FileUtil {

    @Value("${app.upload.dir}")
    private String uploadDir;

    public String saveUploadFile(MultipartFile file, String subDir) throws IOException {
        String uuidFile = UUID.randomUUID().toString();
        String resultFileName = uuidFile + "_" + file.getOriginalFilename();

        Path pathDir = Paths.get(uploadDir).resolve(subDir);
        Files.createDirectories(pathDir);

        Path filePath = pathDir.resolve(resultFileName);
        Files.copy(file.getInputStream(), filePath);
        return resultFileName;
    }

    public Resource getFileAsResource(String filename) throws IOException {
        Path filePath = Paths.get(uploadDir)
                .resolve("files")
                .resolve(filename)
                .normalize();

        if (!Files.exists(filePath)) {
            throw new NoSuchFileException(filename);
        }
        return new InputStreamResource(Files.newInputStream(filePath));
    }

    public ResponseEntity<String> deleteFile (String fileName) {
        try {
            Path filePath = Paths.get(uploadDir).resolve("files").resolve(fileName).normalize();
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                return ResponseEntity.ok("File deleted successfully: " + fileName);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("File not found: " + fileName);
            }
        } catch (IOException e) {
            throw new FileStorageException("Failed to delete file ");
        }
    }

    public String formatSize(Long bytes) {
        if (bytes == null) return "0 КБ";
        if (bytes < 1024 * 1024) {
            return (bytes / 1024) + " КБ";
        } else if (bytes < 1024L * 1024 * 1024) {
            return (bytes / (1024 * 1024)) + " МБ";
        } else {
            return String.format("%.1f ГБ", bytes / (1024.0 * 1024 * 1024));
        }
    }


}