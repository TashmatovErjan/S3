package et.oss.controller;

import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/file")
@RequiredArgsConstructor
public class FileController {

    private final FileService fileService;

    @PostMapping("/upload")
    public String uploadFile(@RequestParam List<MultipartFile> file, Authentication authentication) throws IOException {
        if (file == null || file.isEmpty()) {
            return "redirect:/";
        }
        fileService.uploadFile(file, authentication);
        return "redirect:/";
    }

    @PostMapping("/delete/{fileName}")
    public String deleteFile(@PathVariable String fileName) throws IOException {
        fileService.deleteFile(fileName);
        return "redirect:/";
    }

}