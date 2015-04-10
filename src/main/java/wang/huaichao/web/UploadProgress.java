package wang.huaichao.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static java.lang.String.format;

/**
 * Created by Administrator on 2015/4/10.
 */
public class UploadProgress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Object read = session.getAttribute(
                UploadServlet.UploadProgressListener.BYTES__READ);
        Object total = session.getAttribute(
                UploadServlet.UploadProgressListener.BYTES_TOTAL);
        resp.getWriter().write(
                format("{\"total\":%s,\"uploaded\":%s}", total, read)
        );
        resp.getWriter().close();
    }
}
