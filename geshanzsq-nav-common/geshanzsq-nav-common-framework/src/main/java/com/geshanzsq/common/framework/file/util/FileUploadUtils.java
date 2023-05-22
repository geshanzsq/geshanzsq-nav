package com.geshanzsq.common.framework.file.util;


import cn.hutool.core.lang.UUID;
import com.geshanzsq.common.core.util.string.StrUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.http.entity.ContentType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.util.Date;

/**
 * 文件上传工具类
 *
 * @author geshanzsq
 * @date 2022/11/26
 */
public class FileUploadUtils {

    private static final Logger log = LoggerFactory.getLogger(FileUploadUtils.class);

    /**
     * 后缀名是否允许上传
     *
     * @param extension       文件后缀名
     * @param allowExtensions 允许上传文件类型
     */
    public static boolean isAllowedExtension(String extension, String[] allowExtensions) {
        for (String allowedExtension : allowExtensions) {
            if (allowedExtension.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 获取上传的文件路径
     * @param extension 文件后缀名
     * @return
     */
    public static String getUploadFilePath(String extension) {
        String filePath = StrUtils.format("/{date}/{uuid}.{extension}",
                DateFormatUtils.format(new Date(), "yyyy/MM/dd"), UUID.fastUUID(), extension);
        return filePath;
    }

    /**
     * 获取真实的上传文件
     * @param baseDirectory 基本路径
     * @param filePathName 文件路径和名称
     */
    public static File getAbsoluteFile(String baseDirectory, String filePathName) throws IOException {
        File file = new File(baseDirectory + "/" + filePathName);
        // 目录不存在，新建目录
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        // 文件不存在，新建文件
        if (!file.exists()) {
            file.createNewFile();
        }
        return file;
    }

    /**
     * url转变为 MultipartFile对象
     *
     * @param url
     * @return
     * @throws Exception
     */
    public static MultipartFile urlToMultipartFile(String url) throws Exception {
        FileItem item = null;
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setReadTimeout(5000);
        conn.setConnectTimeout(5000);
        conn.addRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0;WindowsNT 5.0)");
        //设置应用程序要从网络连接读取数据
        conn.setDoInput(true);
        conn.setRequestMethod("GET");
        if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
            InputStream is = conn.getInputStream();

            FileItemFactory factory = new DiskFileItemFactory(16, null);
            String textFieldName = "pictureFile";
            String fileName = getFileNameByUrl(url);
            item = factory.createItem(textFieldName, ContentType.APPLICATION_OCTET_STREAM.toString(), false, fileName);
            OutputStream os = item.getOutputStream();

            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = is.read(buffer, 0, 8192)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.close();
            is.close();
        }
        return new CommonsMultipartFile(item);
    }

    /**
     * 获取文件后缀名
     */
    public static String getExtension(MultipartFile file) {
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        if (StrUtils.isBlank(extension)) {
            extension = MimeTypeUtils.getExtension(file.getContentType());
        }
        return extension;
    }

    public static String getFileMd5(MultipartFile file) {
        try {
            //获取文件的byte信息
            byte[] uploadBytes = file.getBytes();
            // 拿到一个MD5转换器
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] digest = md5.digest(uploadBytes);
            //转换为16进制
            return new BigInteger(1, digest).toString(16);
        } catch (Exception e) {
            log.error("获取上传文件 md5 失败：{}", e.getMessage());
        }
        return null;
    }

    /**
     * 获取文件名称
     */
    private static String getFileNameByUrl(String url) {
        if (url.lastIndexOf("/") < 0) {
            return url;
        }
        String fileName = url.substring(url.lastIndexOf("/") + 1);
        if (fileName.lastIndexOf("?") < 0) {
            return fileName;
        }
        fileName = fileName.substring(0, fileName.lastIndexOf("?"));
        return fileName;
    }


}
