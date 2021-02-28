package com.geshanzsq.system.domain;

import com.geshanzsq.common.annotation.Excel;
import com.geshanzsq.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 网站配置对象 sys_web_config
 * 
 * @author geshanzsq
 * @date 2021-02-28
 */
public class SysWebConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long webConfigId;

    /** 关于本站描述 */
    @Excel(name = "关于本站描述")
    private String aboutWebDescription;

    /** 关于本站邮箱 */
    @Excel(name = "关于本站邮箱")
    private String aboutWebEmail;

    /** 关于本站内容 */
    @Excel(name = "关于本站内容")
    private String aboutWebContent;

    public void setWebConfigId(Long webConfigId) 
    {
        this.webConfigId = webConfigId;
    }

    public Long getWebConfigId() 
    {
        return webConfigId;
    }
    public void setAboutWebDescription(String aboutWebDescription) 
    {
        this.aboutWebDescription = aboutWebDescription;
    }

    public String getAboutWebDescription() 
    {
        return aboutWebDescription;
    }
    public void setAboutWebEmail(String aboutWebEmail) 
    {
        this.aboutWebEmail = aboutWebEmail;
    }

    public String getAboutWebEmail() 
    {
        return aboutWebEmail;
    }
    public void setAboutWebContent(String aboutWebContent) 
    {
        this.aboutWebContent = aboutWebContent;
    }

    public String getAboutWebContent() 
    {
        return aboutWebContent;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("webConfigId", getWebConfigId())
            .append("aboutWebDescription", getAboutWebDescription())
            .append("aboutWebEmail", getAboutWebEmail())
            .append("aboutWebContent", getAboutWebContent())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
