package et.oss.service;

import et.oss.dto.RegisterDto;
import et.oss.dto.UserDto;
import et.oss.model.User;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;

public interface AuthService {

    void registerUser(RegisterDto registerDto);

    UserDto getUserByEmail(String email);

    @Transactional
    void updateResetPasswordToken(String token, String email);

    User getByResetPasswordToken(String token);

    void updatePassword(User user, String newPassword);

    void makeResetPasswdLink(HttpServletRequest request)
            throws UsernameNotFoundException, UnsupportedEncodingException, MessagingException;

    User getUserById(Long userId);
}
