package et.oss.service;

import et.oss.dto.UserDto;

public interface AuthService {
    void registerUser(UserDto userDto);

    UserDto getUserByEmail(String email);
}
