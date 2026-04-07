package et.oss.service.impl;

import et.oss.Util.FileUtil;
import et.oss.dto.FileDto;
import et.oss.dto.UserDto;
import et.oss.model.User;
import et.oss.model.File;
import et.oss.repository.FIleRepository;
import et.oss.service.AuthService;
import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    @Override
    public Page<FileDto> getAllFilesByUser(Pageable pageable, Authentication authentication){
        UserDto userDto = authService.getUserByEmail(authentication.getName());
        User user = convertToModelUser(userDto);
        return fileRepository.findAllByAuthor_Id(user.getId(), pageable)
                .map(this::convertToDto);

    }

    private User convertToModelUser(UserDto dto) {
        return User.builder()
                .id(dto.getId())
                .email(dto.getEmail())
                .build();
    }

    private FileDto convertToDto(File file) {
        return FileDto.builder()
                .id(file.getId())
                .name(file.getName())
                .size(file.getSize())
                .createDate(file.getCreatDate())
                .fileType(file.getFileType())
                .authorId(file.getAuthor().getId())
                .build();
    }

}
