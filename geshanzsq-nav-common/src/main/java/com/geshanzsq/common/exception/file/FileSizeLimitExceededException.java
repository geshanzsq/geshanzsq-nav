package com.geshanzsq.common.exception.file;

/**
 * 文件名大小限制异常类
 * 
 * @author geshanzsq
 */
public class FileSizeLimitExceededException extends FileException
{
    private static final long serialVersionUID = 1L;

    public FileSizeLimitExceededException(long defaultMaxSize)
    {
        super("upload.exceed.maxSize", new Object[] { defaultMaxSize });
    }
}
