package et.oss.repository;

import et.oss.model.File;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FIleRepository extends JpaRepository<File, Long> {
    Page<File> findAllByAuthor_Id(Long authorId, Pageable pageable);
}