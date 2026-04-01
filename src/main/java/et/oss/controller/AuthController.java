package et.oss.controller;

import et.oss.dto.UserDto;
import et.oss.exceptions.UserAlreadyExistsException;
import et.oss.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/register")
    public String getRegister(Model model) {
        model.addAttribute("userDto", new UserDto());
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerApplicant(@ModelAttribute("userDto") UserDto userDto, Model model) {
        authService.registerUser(userDto);
        return "redirect:/auth/login";
    }

    @GetMapping("/login")
    public String getLogin() {
        return "auth/login";
    }

}

