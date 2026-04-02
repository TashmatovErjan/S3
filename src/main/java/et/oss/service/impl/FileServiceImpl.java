package et.oss.service.impl;

import et.oss.Util.FileUtil;
import et.oss.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FileServiceImpl implements FileService {

    private final FileUtil fileUtil;

    @Override
    public List<String> uploadFile(List<MultipartFile> file) throws IOException {

        List<String> list = new ArrayList<>();

        for (MultipartFile multipartFile : file) {
            if (multipartFile.isEmpty()) {
                continue;
            }
            String savedFileName = fileUtil.saveUploadFile(multipartFile, "files");
            list.add(savedFileName);
        }

        return list;
    }
}
