package com.gx.utils;

import java.util.ArrayList;
import java.util.List;

//下拉框封装方法
public class SelectXLK<T> {
    public ArrayList<SelectVo> selectXLK(List lists, String Text, int type){
        List<SelectVo> arrayList = new ArrayList<SelectVo>();

        String text = type==1 ? "-- "+ Text +" --" : Text;
        SelectVo vo = new SelectVo(0,text);

        if(Text !=""){
            arrayList.add(vo);
        }
        arrayList.addAll(lists);
        return (ArrayList<SelectVo>) arrayList;
    }
}
