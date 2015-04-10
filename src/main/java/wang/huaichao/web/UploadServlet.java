package wang.huaichao.web;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2015/4/9.
 */
public class UploadServlet extends HttpServlet {
    private static int UploadId = 0;
    private final int maxSize = 10 * 1024 * 1024;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse rsp)
            throws ServletException, IOException {
        String webroot = System.getProperty("web.root.dir");

        DiskFileItemFactory dfif = new DiskFileItemFactory(1024, new File(webroot + "/upload/tmp/"));
        ServletFileUpload sfu = new ServletFileUpload(dfif);
        sfu.setSizeMax(maxSize);

        sfu.setProgressListener(
                new UploadProgressListener(
                        req.getSession(true)
                )
        );

        try {
            List<FileItem> items = sfu.parseRequest(req);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    item.write(new File(
                            webroot + "/upload/tmp/" + item.getName()
                    ));
                }
            }
        } catch (Exception e) {
            rsp.getWriter().write(e.getMessage());
        }
    }

    public static final class UploadProgressListener
            implements ProgressListener {
        private HttpSession session;
        public static final String BYTES__READ = "bytes__read";
        public static final String BYTES_TOTAL = "bytes_total";

        public UploadProgressListener(HttpSession session) {
            session.setAttribute(BYTES__READ, 0);
            session.setAttribute(BYTES_TOTAL, 0);
            this.session = session;
        }

        @Override
        public void update(long read, long contentLength, int items) {
            session.setAttribute(BYTES__READ, read);
            session.setAttribute(BYTES_TOTAL, contentLength);
        }
    }
}
