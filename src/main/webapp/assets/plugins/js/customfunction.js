/**
 * jquery 根据json对象填充form表单
 * @author en
 * @param formId form表单id
 * @param jsonDate json对象
 */
function loadDatatoForm(formId, jsonDate) {
    var obj = jsonDate;
    var key, value, tagName, type, arr;
    for (x in obj) {//循环json对象
        key = x;
        value = obj[x];
        //$("[name='"+key+"'],[name='"+key+"[]']").each(function(){
        //更加form表单id 和 json对象中的key查找 表单控件
        $("#" + formId + " [name='" + key + "'],#" + formId + " [name='" + key + "[]']").each(function () {
            tagName = $(this)[0].tagName;
            type = $(this).attr('type');
            if (tagName == 'INPUT') {
                if (type == 'radio') {
                    $(this).prop('checked', $(this).val() == value);
                } else if (type == 'checkbox') {
                    try {
                        //数组
                        arr = value.split(',');
                        for (var i = 0; i < arr.length; i++) {
                            if ($(this).val() == arr[i]) {
                                $(this).prop('checked', true);//attr
                                break;
                            }
                        }
                    } catch (e) {
                        //单个
                        $(this).attr('checked', value);
                    }
                } else {
                    $(this).val(value);
                }
            } else if (tagName == 'TEXTAREA') {
                $(this).val(value);
            } else if (tagName == 'SELECT') {
                //console.log($(this).hasClass("select2"));
                if ($(this).hasClass("select2")) {
                    //select2 插件的赋值方法
                    $(this).val(value).trigger("change");
                } else {
                    $(this).val(value);
                }

            }

        });
    }
}

/**
 * 按照数字顺序排序的排序函数 array[] 数字排序 从小到大
 * @param {} a 
 * @param {} b 
 * @returns {} 
 */
function numberorderAsc(a, b) { return a - b; }

/**
 * 按照数字顺序排序的排序函数  array[] 数字排序 从大到小
 * @param {} a 
 * @param {} b 
 * @returns {} 
 */
function numberorderDesc(a, b) { return b - a; }

/**
 * jquery 根据json对象创建Select下拉框
 * @author en
 * @param fromId form表单id
 * @param jsonDate json对象
 */
function selectLoadData(selectId, jsonData) {
    if (selectId.indexOf('#') != 0) {
        selectId = '#' + selectId;
    }
    $(selectId).empty();//清空该元素
    for (k in jsonData) {
        $(selectId).append('<option value="' + jsonData[k].id + '">' + jsonData[k].text + '</option>');
    }
}

/**
 * jquery 根据url创建下拉框
 * @author en
 * @param fromId form表单id
 * @param url 查询下拉框的url
 * @param value 设置值
 */
function createSelect(selectId, url, value) {

    $.post(url, function (returnJson) {
        $(selectId).empty();//清空该元素
        //创建option
        for (k in returnJson) {
            $(selectId).append('<option value="' + returnJson[k].id + '">' + returnJson[k].text + '</option>');
        }
        //设置选中值
        if (value != undefined && value != null && value != '') {
            $(selectId).val(value);
        }
    });
}

//字符串值不为空
function strValIsNotNull(strVal) {
    return strVal != undefined && strVal != null && strVal != '';
}

//为空判断封装方法（Object对象）
function FZpanduan(objdata) {
    let obj = objdata
    for (k in obj){
        //toUpperCase()转成大写，indexOf("ID")返回字符出现的索引位置，如果能找到，则返回索引值，否则返回 -1
        //字符串带ID的，如果为空就等0
        if(k.toUpperCase().indexOf("ID") != -1){
            if(obj[k]==null || obj[k]==undefined || obj[k]==""){
                obj[k]="0"
            }
        }else {
            if(obj[k]==null || obj[k]==undefined){
                obj[k]=""
            }
        }
    }
    return objdata;

    /*let a1 = 'lee';
    let b1 = objdata
    b = 'cheng'
    console.log(a) // 输出结果仍为lee*/

    /*let a2 = { name: 'lee' }
    let b2 = a
    b.name = 'cheng'
    console.log(a.name) // 输出结果为cheng*/
}

/**
 * @description: 存储 token
 * @param {*} key   键名
 * @param {*} value 键值
 * @param {*} time  需要存储多长时间(单位为 h)
 * @return {*}
 */
function saveCookie(key, value, time) {
    time = time * 60 * 60 * 1000 * 24// 单位：天
    const d = new Date()
    d.setTime(d.getTime() + time)
    // 存储到cookie
    document.cookie = key + '=' + value + ';expires=' + d.toGMTString() + ';path=/'
}
/*const token = 'this is a token'
const key = 'my_token'
saveCookie(key, token, 1)
saveCookie('user_login', 'i am people', 2)
saveCookie('register', 'this is register', 3)*/
/**
 * @description: 获取某个cookie
 * @param {*} cname  cookie名
 * @return {*}  返回的就是cookie值
 */
function getCookie(cname) {
    let value = ''
    const cookies = document.cookie.split('; ')
    for (let i = 0; i < cookies.length; i++) {
        const cke = cookies[i].split('=')
        if (cke[0] === cname) {
            value = cke[1]
            break
        }
    }
    return value
}


// //权限方法封装
// function JurisdictionIndexOf(JurisdictionName,text) {
//     console.log(functionObj[0]);
//     console.log(JurisdictionName,text);
//     var indexOf = 0;
//     for (k in functionObj[0]) {
//         if(functionObj[0][k].parentModuleName==JurisdictionName){
//             var typenames = functionObj[0][k].typeNames.split(',');
//             var bits = functionObj[0][k].usingBits.split(',');
//             for (let i = 0; i < typenames.length; i++) {
//                 //有该权限
//                 if(text==typenames[i] && bits[i]=="1"){
//                     indexOf = 1;
//                 }
//             }
//         }
//     }
//     return indexOf;
// }
/*if (escape(cname) == aCrumb[0]){
    //unescape()函数 用于对已经使用 escape()函数 编码的字符串进行解码，并返回解码后的字符串
    value = unescape(aCrumb[1]);
}*/
/*
const result = getCookie('user_login')
console.log(result);*/
