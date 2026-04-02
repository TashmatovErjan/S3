package et.oss.controller;

import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
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
    public String editAvatar(@RequestParam(required = false) List<MultipartFile> file) throws IOException {
        fileService.uploadFile( file);
        return "redirect:/";
    }

}