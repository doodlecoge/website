package wang.huaichao.web.model;

import org.springframework.security.web.PortResolverImpl;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Administrator on 2015/1/5.
 */
@Entity
@Table(name = "users")
public class User {
    @Id
    private String username;

    @Column
    private String password;

    @Column
    private String fullname;

    @Column
    private String photo;

    @Column
    @Enumerated(value = EnumType.STRING)
    private UserRole role;

    @Column(name = "created_at")
    private Date createdAt;

    @OneToMany(cascade = {CascadeType.ALL}, fetch = FetchType.LAZY)
    @JoinColumn(name = "username")
    private Set<Image> images = new HashSet<Image>();

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Set<Image> getImages() {
        return images;
    }

    public void setImages(Set<Image> images) {
        this.images = images;
    }

    public static enum UserRole {
        USER, ADMIN
    }
}
