package wang.huaichao.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import wang.huaichao.web.model.User;
import wang.huaichao.web.service.UserService;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Created by huaichao on 10/27/14.
 */
public class MyUserDetailsService implements UserDetailsService {
    private static final Logger log = LoggerFactory.getLogger(MyUserDetailsService.class);
    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userService.getUser(username);

//        ArrayList<SimpleGrantedA  uthority> authorities =
//                new ArrayList<SimpleGrantedAuthority>();

        Collection<? extends GrantedAuthority> authorities =
                AuthorityUtils.createAuthorityList("ROLE_USER");

        return new org.springframework.security.core.userdetails.User(
                username,
                user.getPassword(),
                authorities
        );
    }
}
