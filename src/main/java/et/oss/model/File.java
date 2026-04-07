package et.oss.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "file")
public class File {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private Long size;

    @Column(name = "creation_date")
    private LocalDateTime creatDate;

    @Column(name = "file_type")
    private String fileType;

    @ManyToOne
    @JoinColumn(name = "author_id", referencedColumnName = "id")
    private User author;


}
