package et.oss.service.impl;

import et.oss.exceptions.AccountTypeNotFoundException;
import et.oss.repository.RoleRepository;
import et.oss.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;

    @Override
    public Long getRoleId() {
        Long id = roleRepository.findByName("USER")
                .orElseThrow(() -> {
                    return new AccountTypeNotFoundException("Account type USER not found");
                })
                .getId();
        return id;
    }
}
