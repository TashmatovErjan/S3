package et.oss.service.impl;

import et.oss.dto.UserDto;
import et.oss.exceptions.UserAlreadyExistsException;
import et.oss.model.User;
import et.oss.repository.UserRepository;
import et.oss.service.AuthService;
import et.oss.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;


    @Override
    public void registerUser(UserDto userDto) {

        if (userRepository.existsByEmail(userDto.getEmail())) {
            throw new UserAlreadyExistsException("Пользователь с такой почтой уже существует");
        }

        User user = User.builder()
                .email(userDto.getEmail())
                .password(passwordEncoder.encode(userDto.getPassword()))
                .roleId(roleService.getRoleId())
                .enabled(true)
                .build();

        userRepository.save(user);
    }


}
