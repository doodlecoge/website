package wang.huaichao.web.model;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/4/21.
 */
@Entity
@Table(name = "widgets")
@org.hibernate.annotations.Entity(dynamicUpdate = true)
public class Widget {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private String html;

    @Column
    private String js;

    @Column
    private String css;

    @OneToOne
    @JoinColumn(name = "username")
    private User user;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHtml() {
        return html;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public String getJs() {
        return js;
    }

    public void setJs(String js) {
        this.js = js;
    }

    public String getCss() {
        return css;
    }

    public void setCss(String css) {
        this.css = css;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
