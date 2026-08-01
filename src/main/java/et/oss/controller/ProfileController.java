package et.oss.controller;

import et.oss.dto.UserDto;
import et.oss.service.AuthService;
import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final AuthService authService;
    private final FileService fileService;

    @GetMapping
    public String getProfile(Model model) {
        String currentUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        UserDto currentUser = authService.getUserByEmail(currentUserEmail);
        model.addAttribute("fileCount", fileService.getUserFilesCount(currentUser.getId()));
        model.addAttribute("user", currentUser);

        return "profile/profile";
    }

}
