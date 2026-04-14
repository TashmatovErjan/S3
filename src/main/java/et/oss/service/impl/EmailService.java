package et.oss.service.impl;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;

@RequiredArgsConstructor
@Service
public class EmailService {
    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String EMAIL_FROM;

    public void sendEmail(String toEmail, String link) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(EMAIL_FROM, "S3 Support");
        helper.setTo(toEmail);
        helper.setSubject("Password Reset Request");
        String content =
                "<p>You requested a password reset.</p>" +
                        "<p>Click the link below to set a new password:</p>" +
                        "<p><a href=\"" + link + "\">Reset your password</a></p>" +
                        "<br>" +
                        "<p>If you did not request this, ignore this email.</p>" +
                        "<p>This link is valid for a limited time.</p>" +
                        "<br>" +
                        "<p>S3 Support Team</p>";

        helper.setText(content, true);
        mailSender.send(message);
    }
}