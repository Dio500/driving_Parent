package com.gx.utils;

import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

import java.util.HashSet;
import java.util.Set;

public class CheckFileSize {
    /**
     * 判断文件大小
     *
     * @param len
     *            文件长度
     * @param size
     *            限制大小
     * @param unit
     *            限制单位（B,K,M,G）
     * @return
     */
    public static boolean checkFileSize(Long len, int size, String unit) {
        //=long len = file.length();
        double fileSize = 0;
        if ("B".equals(unit.toUpperCase())) {
            fileSize = (double) len;
        }
        else if ("K".equals(unit.toUpperCase())) {
            fileSize = (double) len / 1024;
        }
        else if ("M".equals(unit.toUpperCase())) {
            fileSize = (double) len / 1048576;
        }
        else if ("G".equals(unit.toUpperCase())) {
            fileSize = (double) len / 1073741824;
        }
        if (fileSize > size) {
            return false;
        }
        return true;
    }

    //获取源对象中为null的属性名
    public static String[] getNullPropertyNames(Object source) {
        //BeanWrapperImpl包装了一个bean对象，缓存了bean的内省结果，并可以访问bean的属性、设置bean的属性值。BeanWrapperImpl类提供了许多默认属性编辑器，支持多种不同类型的类型转换
        final BeanWrapper src = new BeanWrapperImpl(source);
        //PropertyDescriptor：属性描述符，能够描述javaBean中的属性，通过属性描述符能知道这个属性的类型，获取到操纵属性的方法（getter/setter）
        java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();
        Set<String> emptyNames = new HashSet<String>();

        for (java.beans.PropertyDescriptor pd : pds) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) {
                emptyNames.add(pd.getName());
            }
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }
}
