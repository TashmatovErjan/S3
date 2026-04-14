package et.oss.controller;

import et.oss.dto.RegisterDto;
import et.oss.dto.ResetPasswordDto;
import et.oss.exceptions.ExpiredLinkException;
import et.oss.exceptions.UserAlreadyExistsException;
import et.oss.model.User;
import et.oss.service.AuthService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/register")
    public String getRegister(Model model) {
        model.addAttribute("registerDto", new RegisterDto());
        return "auth/auth";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("registerDto") RegisterDto registerDto,
                               BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "auth/auth";
        }
        try{
            authService.registerUser(registerDto);
        } catch (UserAlreadyExistsException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "auth/auth";
    }

    @GetMapping("/login")
    public String getLogin(Model model) {
        model.addAttribute("registerDto", new RegisterDto());
        return "auth/auth";
    }

    @GetMapping("/forgotPassword")
    public String showForgotPasswordForm() {
        return "auth/forgotPasswordForm";
    }

    @PostMapping("/forgotPassword")
    public String processForgotPassword(HttpServletRequest request, Model model) {
        try {
            authService.makeResetPasswdLink(request);
            model.addAttribute("message", "The link has been sent to your email.");
        } catch (UsernameNotFoundException | UnsupportedEncodingException | MessagingException ex) {
            model.addAttribute("error", ex.getMessage());
        }
        return "auth/forgotPasswordForm";
    }

    @GetMapping("/resetPassword")
    public String showResetPasswordForm(@RequestParam String token, Model model) {
        try {
            authService.getByResetPasswordToken(token);
            model.addAttribute("token", token);
            model.addAttribute("resetPasswordDto", new ResetPasswordDto());
        }  catch (UsernameNotFoundException | ExpiredLinkException ex) {
            model.addAttribute("error", ex.getMessage());
        }
        return "auth/resetPasswordForm";
    }

    @PostMapping("/resetPassword")
    public String processResetPassword(@Valid ResetPasswordDto resetPasswordDto,
                                       BindingResult bindingResult,
                                       HttpServletRequest request,
                                       Model model) {
        String token = request.getParameter("token");
        if (bindingResult.hasErrors()) {
            model.addAttribute("token", token);
            return "auth/resetPasswordForm";
        }
        String password =  resetPasswordDto.getPassword();
        try {
            User user = authService.getByResetPasswordToken(token);
            authService.updatePassword(user, password);
            model.addAttribute("message", "Password changed successfully");
        } catch (UsernameNotFoundException | ExpiredLinkException ex) {
            model.addAttribute("error", ex.getMessage());
        }
        return "auth/message";
    }
}

