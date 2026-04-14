package et.oss.service.impl;

import et.oss.common.Utility;
import et.oss.dto.RegisterDto;
import et.oss.dto.UserDto;
import et.oss.exceptions.ExpiredLinkException;
import et.oss.exceptions.UserAlreadyExistsException;
import et.oss.exceptions.UserNotFoundException;
import et.oss.model.User;
import et.oss.repository.UserRepository;
import et.oss.service.AuthService;
import et.oss.service.RoleService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;
    private final EmailService emailService;

    @Override
    public void registerUser(RegisterDto registerDto) {

        if (userRepository.existsByEmail(registerDto.getEmail())) {
            throw new UserAlreadyExistsException("A user with this email already exists");
        }

        User user = User.builder()
                .email(registerDto.getEmail())
                .password(passwordEncoder.encode(registerDto.getPassword()))
                .roleId(roleService.getRoleId())
                .enabled(true)
                .build();

        userRepository.save(user);
    }

    @Override
    public UserDto getUserByEmail(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotFoundException("Пользователь не найден"));
        return convertToDto(user);
    }

    @Transactional
    @Override
    public void updateResetPasswordToken(String token, String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь с такой почтой не найден: " + email));
        user.setResetPasswordLink(token);
        user.setResetTokenExpiresAt(LocalDateTime.now().plusMinutes(30));
        userRepository.saveAndFlush(user);
    }

    @Override
    public User getByResetPasswordToken(String token) {
        User user = userRepository.findByResetPasswordLink(token)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        if (user.getResetTokenExpiresAt().isBefore(LocalDateTime.now())) {
            throw new ExpiredLinkException("The link has expired");
        }
        return user;
    }

    @Transactional
    @Override
    public void updatePassword(User user, String newPassword) {
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        user.setResetPasswordLink(null);
        user.setResetTokenExpiresAt(null);
        userRepository.saveAndFlush(user);
    }

    @Override
    public void makeResetPasswdLink(HttpServletRequest request)
            throws UsernameNotFoundException, UnsupportedEncodingException, MessagingException {
        String email = request.getParameter("email");
        String token = UUID.randomUUID().toString();
        updateResetPasswordToken(token, email);
        String resetPasswordLink = Utility.getSiteURL(request) + "/auth/resetPassword?token=" + token;
        emailService.sendEmail(email, resetPasswordLink);
    }

    private UserDto convertToDto(User user) {
        return UserDto.builder()
                .id(user.getId())
                .email(user.getEmail())
                .roleId(user.getRoleId())
                .build();
    }

}
