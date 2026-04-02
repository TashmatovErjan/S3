package et.oss.Util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
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

        Path pathDir = Paths.get(uploadDir +  subDir);
        Files.createDirectories(pathDir);

        Path filePath = Paths.get( pathDir + "/" + resultFileName);

        Files.copy(file.getInputStream(), filePath);
        return resultFileName;
    }


    public ResponseEntity<?> getOutputFIle (String filename, MediaType mediaType) throws IOException {
        try{
            byte[] file = Files.readAllBytes(Paths.get(uploadDir + filename));
            Resource resource = new ByteArrayResource(file);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                    .contentLength(resource.contentLength())
                    .contentType(mediaType)
                    .body(resource);
        } catch (NoSuchFileException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("File Not Found");
        } catch (IOException e){
            return  ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Internal Server Error");
        }
    }
}