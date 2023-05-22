package com.geshanzsq.common.core.util.string;

import com.geshanzsq.common.core.constant.CommonConstant;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.CollectionUtils;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Random;

/**
 * 字符串工具类
 *
 * @author geshanzsq
 * @date 2022/3/19
 */
public class StrUtils extends StringUtils {

    /**
     * 左括号
     */
    private final static String LEFT_BRACKET = "{";

    /**
     * 右括号
     */
    private final static String RIGHT_BRACKET = "}";

    /**
     * 下划线
     */
    private final static char UNDERLINE = '_';

    /**
     * 转换文本, {} 表示占位符，例：
     * format("欢迎访问{blogName}博客，网站地址：{siteUrl}", "格姗导航", "http://gesdh.cn")
     * format("欢迎访问{}博客，网站地址：{}", "格姗导航", "http://gesdh.cn")
     *
     * @param str    需要转换的字符串
     * @param params 参数
     */
    public static String format(String str, Object... params) {
        if (isBlank(str) || params == null || params.length == 0) {
            return str;
        }
        StringBuilder result = new StringBuilder();
        // 数组下标
        int index = 0;
        while (str.contains(LEFT_BRACKET) && str.contains(RIGHT_BRACKET)) {
            int start = str.indexOf(LEFT_BRACKET);
            int end = str.indexOf(RIGHT_BRACKET);
            // 如果 index 大于 params 数组，说明后续无需替换
            if (index > (params.length - 1)) {
                result.append(str);
                break;
            }
            // 如果右 } 大于左 }，直接取出 {，跳过当前，示例：欢迎访问{blogName}博客，}{网站地址：{siteUrl}
            if (end < start || index > (params.length - 1)) {
                result.append(str.substring(0, start + 1));
                str = str.substring(start + 1);
                continue;
            }
            result.append(str.substring(0, start));
            result.append(params[index]);
            str = str.substring(end + 1);
            index++;
        }
        result.append(str);
        return result.toString();
    }

    /**
     * 是否为http(s)://开头
     *
     * @param link 链接
     * @return 结果
     */
    public static boolean isHttp(String link) {
        return StringUtils.startsWithAny(link, CommonConstant.HTTP, CommonConstant.HTTPS);
    }

    /**
     * 判断是否为空，包含字符串
     *
     * @param value 值
     * @return 是否为空
     */
    public static boolean isNullBlank(Object value) {
        return value == null
                || (value instanceof String && isBlank(String.valueOf(value)))
                || (value instanceof Collection && CollectionUtils.isEmpty((Collection) value));
    }

    /**
     * 判断是否不为空，包含字符串
     *
     * @param value 值
     * @return 是否不为空
     */
    public static boolean isNotNullBlank(Object value) {
        return !isNullBlank(value);
    }

    /**
     * 批量替换前缀
     *
     * @param value     需要替换的值
     * @param matchList 替换内容列表
     * @return
     */
    public static String replacePre(String value, String[] matchList) {
        String result = value;
        for (String match : matchList) {
            if (value.startsWith(match)) {
                result = value.replaceFirst(match, "");
            }
        }
        return result;
    }

    /**
     * 下划线转驼峰，如：nick_name > nickName
     *
     * @param value 需要转换的值
     * @return
     */
    public static String toCamelCase(String value) {
        return toCamelCase(value, false);
    }

    /**
     * 下划线转驼峰
     *
     * @param value            需要转换的值
     * @param isFirstUpperCase 首字母是否需要大写
     * @return
     */
    public static String toCamelCase(String value, boolean isFirstUpperCase) {
        if (isBlank(value)) {
            return value;
        }
        StringBuilder result = new StringBuilder();
        // 是否转为大写
        boolean upperCase = false;
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            if (UNDERLINE == c) {
                upperCase = true;
            } else if (upperCase) {
                result.append(Character.toUpperCase(c));
                upperCase = false;
            } else {
                result.append(c);
            }
        }
        // 首字母需要大写
        if (isFirstUpperCase) {
            return toFirstUpperCase(result.toString());
        }
        return result.toString();
    }

    /**
     * 数组是否包含指定值
     *
     * @param array 数组
     * @param value 指定值
     */
    public static boolean isArrayContains(String[] array, String value) {
        return Arrays.asList(array).contains(value);
    }

    /**
     * 指定值是否已某个值后缀
     *
     * @param value 指定值
     * @param array 数组
     * @return
     */
    public static boolean endsWithIgnoreCase(String value, String[] array) {
        for (String arr : array) {
            boolean isEnd = endsWith(value, arr);
            if (isEnd) {
                return true;
            }
        }
        return false;
    }

    /**
     * 首字母转换为大写
     *
     * @param value 值
     * @return
     */
    public static String toFirstUpperCase(String value) {
        if (isBlank(value)) {
            return value;
        }
        return value.substring(0, 1).toUpperCase() + value.substring(1);
    }

    /**
     * 获取随机数
     *
     * @param str    生成规则的字符串
     * @param length 生成长度
     */
    public static String getRandom(String str, int length) {
        Random random = new Random();
        StringBuffer valSb = new StringBuffer();
        int charLength = str.length();
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(charLength);
            valSb.append(str.charAt(index));
        }
        return valSb.toString();
    }

    /**
     * 查找指定字符串是否匹配指定字符串列表中的任意一个字符串
     *
     * @param str     指定字符串
     * @param strList 需要检查的字符串数组
     * @return 是否匹配
     */
    public static boolean matches(String str, List<String> strList) {
        if (CollectionUtils.isEmpty(strList)) {
            return false;
        }
        for (String pattern : strList) {
            if (isMatch(pattern, str)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断url是否与规则配置:
     * ? 表示单个字符;
     * * 表示一层路径内的任意字符串，不可跨层级;
     * ** 表示任意层路径;
     *
     * @param pattern 匹配规则
     * @param url     需要匹配的url
     * @return
     */
    public static boolean isMatch(String pattern, String url) {
        AntPathMatcher matcher = new AntPathMatcher();
        return matcher.match(pattern, url);
    }

}
