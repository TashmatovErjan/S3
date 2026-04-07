package et.oss.service.impl;

import et.oss.Util.FileUtil;
import et.oss.dto.UserDto;
import et.oss.model.User;
import et.oss.model.File;
import et.oss.repository.FIleRepository;
import et.oss.service.AuthService;
import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FileServiceImpl implements FileService {

    private final FileUtil fileUtil;
    private final FIleRepository fileRepository;
    private final AuthService authService;

    @Override
    public List<String> uploadFile(List<MultipartFile> files, Authentication authentication) throws IOException {



        UserDto userDto = authService.getUserByEmail(authentication.getName());
        User user = convertToModelUser(userDto);
        List<String> result = new ArrayList<>();
//        User user = (User) authentication.getPrincipal();

        for (MultipartFile multipartFile : files) {
            if (multipartFile.isEmpty()) {
                continue;
            }
            String savedFileName = fileUtil.saveUploadFile(multipartFile, "files");

            File file = File.builder()
                    .author(user)
                    .name(multipartFile.getOriginalFilename())
                    .size(multipartFile.getSize())
                    .creatDate(LocalDateTime.now())
                    .fileType(multipartFile.getContentType())
                    .build();

            fileRepository.save(file);

            result.add(savedFileName);
        }

        return result;
    }

    private User convertToModelUser(UserDto dto) {
        return User.builder()
                .id(dto.getId())
                .email(dto.getEmail())
                .build();
    }
}
