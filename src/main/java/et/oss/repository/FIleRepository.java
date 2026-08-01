package et.oss.repository;

import et.oss.model.File;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FIleRepository extends JpaRepository<File, Long> {
    Page<File> findAllByAuthor_Id(Long authorId, Pageable pageable);
//    Optional<File> findFilesBy(String originalName);
    Long countByAuthor_Id(Long authorId);
    @Query("SELECT COALESCE(SUM(f.size), 0) FROM File f WHERE f.author.id = :authorId")
    Long sumSizeByAuthorId(@Param("authorId") Long authorId);}
