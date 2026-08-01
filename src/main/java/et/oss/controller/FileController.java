package et.oss.controller;

import et.oss.Util.FileUtil;
import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.NoSuchFileException;
import java.util.List;

@Controller
@RequestMapping("/file")
@RequiredArgsConstructor
public class FileController {

    private final FileService fileService;
    private final FileUtil fileUtil;

    @PostMapping("/upload")
    public String uploadFile(@RequestParam List<MultipartFile> file, Authentication authentication) throws IOException {
        if (file == null || file.isEmpty()) {
            return "redirect:/";
        }
        fileService.uploadFile(file, authentication);
        return "redirect:/";
    }

//    @PostMapping("/delete/{fileName}")
//    public String deleteFile(@PathVariable String fileName) throws IOException {
//        fileService.deleteFile(fileName);
//        return "redirect:/";
//    }

    @GetMapping("/download/{fileName}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
        try {
            Resource resource = fileUtil.getFileAsResource(fileName);

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + fileName + "\"")
                    .body(resource);

        } catch (NoSuchFileException e) {
            return ResponseEntity.notFound().build();
        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }


}