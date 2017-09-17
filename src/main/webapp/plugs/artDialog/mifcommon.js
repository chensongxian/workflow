
var mif = new mifCommon();
function mifCommon() {
}
mifCommon.prototype.ajaxLoadDropDownItems = function (id, url, addblank, dispalyName, valueName, defaultValue, triggerOnChange) {
    if (typeof (addblank) == 'undefined') {
        addblank = true;
    }
    if (typeof (dispalyName) == 'undefined') {
        dispalyName = 'Key';
    }
    if (typeof (valueName) == 'undefined') {
        valueName = 'Val';
    }
    $.getJSON(url, function (data) {
        var jsondata = eval(data);
        var ddl = $('#' + id);
        ddl.empty();
        if (addblank) {
            var blankItem = $("<option value=''>-</option>");
            blankItem.appendTo(ddl);
        }
        $.each(jsondata, function (i, item) {
            var val1 = null;
            var val2 = null;
            $.each(item, function (key) {
                if (key == dispalyName) {
                    val1 = item[key];
                }
                else if (key == valueName) {
                    val2 = item[key];
                }

            })
            if (val1 != null && val2 != null) {
                var tempItem = $("<option style='height:25px;' value=" + val2 + ">" + val1 + "</option>");
                tempItem.appendTo(ddl);
            }
        })
        if (typeof (defaultValue) != 'undefined' && defaultValue != null) {
            ddl.val(defaultValue);
            if (typeof (triggerOnChange) != 'undefined' && triggerOnChange) {
                ddl.change(); //
            }
        }
    });
}
mifCommon.prototype.showOkMessageBox = function (msg, autoCloseForm) {
    art.dialog({
        icon: 'succeed',
        content: msg,
        ok: true,
        close: function () {
            if (typeof (autoCloseForm) != 'undefined' && autoCloseForm) {
                mif.closeForm();
            }
            return true;
        },

        lock: true, opacity: 0
    });
}
mifCommon.prototype.showWarningMessageBox = function (msg) {
    art.dialog({
        icon: 'warning',
        content: msg,
        ok: true,
        lock: true, opacity: 0
    });
}
mifCommon.prototype.showErrorMessageBox = function (msg) {
    art.dialog({
        icon: 'error',
        content: msg,
        ok: true,
        lock: true, opacity: 0
    });
}
mifCommon.prototype.showQueryMessageBox = function (msg, okfun, cancelfun) {
    art.dialog({
        icon: 'question',
        content: msg,
        ok:function () {
            if (typeof (okfun) != 'undefined' && okfun != null) {
                okfun();
            }
            else {
                return true;
            }
        },
        cancelVal: '取消',
        cancel: function () {
            if (typeof (cancelfun) != 'undefined' && cancelfun != null) {
                cancelfun();
            }
            else {
                return true;
            }
        },
        lock: true, opacity: 0
    });
}
mifCommon.prototype.showWaittingBox = function (msg) {
    art.dialog({
        id: 'waittingDlg',
        content: '<span><img src="/images/progress_loading.gif" style="vertical-align:middle;" /> ' + msg + '</span>',
        title: false,
        cancel: false,
        lock: true, opacity: 0.3
    });
}
mifCommon.prototype.closeWaittingBox = function (openByParent) {
    mif.closeForm('waittingDlg', openByParent);
}
mifCommon.prototype.getCheckBoxListVal = function (id, splitChar) {
    var result = "";
    var split = ',';
    if (typeof (splitChar) != undefined && splitChar != null && splitChar != '') {
        split = splitChar;
    }
    $('input[type=checkbox,name="' + id + '"]:checked').each(function () {
        result += $(this).val() + split;
    })
    return result;

    //    for (var i = 0; i < 500; i++) {
    //        var itemId = id + 'i';
    //        if ($("#" + itemId).length <= 0) {
    //            break;
    //        }
    //        else {
    //            if ($("#" + itemId).attr("checked") == true) {
    //                if (result != "") {
    //                    result += split;
    //                }
    //                result += split;
    //            }
    //        }
    //    }
}
mifCommon.prototype.setCheckBoxListVal = function (valArray) {
//    var result = "";
//    var split = ',';
//    if (typeof (splitChar) != undefined && splitChar != null && splitChar != '') {
//        split = splitChar;
//    }
//    for (var i = 0; i < 500; i++) {
//        var itemId = id + 'i';
//        if ($("#" + itemId).length <= 0) {
//            break;
//        }
//        else {
//            if($("#" + itemId).attr("value"))
//        }
//    }
}

mifCommon.prototype.ajax = function (url, params, sucFun) {
    var dataParam = "";
    if (typeof (params) != 'undefined' && params != null) {
        dataParam = params;
    }
    $.ajax({
        type: "POST",
        url: url,
        data: dataParam,//"name=John&location=Boston",
        traditional: true,
        cache: false,
        success: function (data) {
            if (typeof (sucFun) != 'undefined' && sucFun != null) {
                sucFun(data);
            }
            else {
                return true;
            }

        },
        error: function (x, e) {
            mif.showErrorMessageBox(x.responsetText);
        }
    });
}
mifCommon.prototype.simpleProcessReturnResult = function (robj) {
    if (robj.ExeResult) {
        mif.showOkMessageBox(robj.Message);
    }
    else {
        mif.showErrorMessageBox(robj.ErrorMessage);
    }
}

mifCommon.prototype.closeForm = function (formId,openByParent) {
    var dlgId = 'detail';
    if (typeof (formId) != "undefined") {
        dlgId = formId;
    }
    if (typeof (openByParent) != "undefined" && openByParent==false) {
        art.dialog({ id: dlgId }).close();
    }
    else
    {
    parent.art.dialog({ id: dlgId }).close();
    }
}
mifCommon.prototype.claerInput = function (id, exceptIds) {//奇了怪了，只能用claerInput
    var exceptIdstring = "";
    if (typeof (exceptIds) != 'undefined' && exceptIds != null) {
        for (var i = 0; i < exceptIds.length; i++) {
            if ($.trim(exceptIds[i]) != "") {
                if (exceptIdstring != "") {
                    exceptIdstring += ",";
                }
                exceptIdstring += "#" + $.trim(exceptIds[i]);
            }
        }

    }
    $(':input', '#' + id)
     .not(':button, :submit, :reset,' + exceptIdstring)
     .val('')
     .removeAttr('checked')
     .removeAttr('selected');
}
mifCommon.prototype.setEnable = function (id, exceptIds, enable) {
    var exceptIdstring = "";
    if (typeof (exceptIds) != 'undefined' && exceptIds != null) {
        for (var i = 0; i < exceptIds.length; i++) {
            if ($.trim(exceptIds[i]) != "") {
                if (exceptIdstring != "") {
                    exceptIdstring += ",";
                }
                exceptIdstring += "#" + $.trim(exceptIds[i]);
            }
        }

    }
    $(':input[type!=hidden]', '#' + id)
     .not(exceptIdstring)
     .attr('disabled', !enable);

}
mifCommon.prototype.setEnable2 = function (ids, enable) {
    if (typeof (ids) != 'undefined' && ids != null) {
        for (var i = 0; i < ids.length; i++) {
            $('#' + $.trim(ids[i])).attr('disabled', !enable);
        }

    }
}
mifCommon.prototype.submit = function (beforeSubmit, formId) {
    var submit = true;
    if (typeof (beforeSubmit) != 'undefined' && beforeSubmit != null) {
        submit = beforeSubmit();
    }
    if (submit || typeof (submit) == 'undefined' || submit == null) {
        if (typeof (formId) != 'undefined' && formId != null) {
            $("#" + formId).submit();
        }
        else {
            $("form").submit();
        }
    }
    //    $("form").submit(function (e) {
    //        alert("Submitted");
    //    });
}

//--------------------json region--------------------------
function obj2str(o, flag, replace,fieldArray) {
    var arr_start = "ARRAY_S";
    var arr_end = "ARRAY_E";
    if (flag == null) {
        flag = "\""; //默认是双引号  
    }
    if (replace == null) {
        replace = true;
    }
    var r = [];
    if (typeof o == "string" || o == null) {
        return o;
    }
    //alert(typeof(o));  
    if (typeof o == "object") {
        //alert(o.sort);  
        if (!o.sort) {
            //alert("in if");  
            r[0] = "{";
            for (var i in o) {
                if (typeof (fieldArray) != undefined && fieldArray != null) {
                    var find = false;
                    for (var n = 0; n < fieldArray.length; n++) {
                        if (fieldArray[n] == i) {
                            find = true;
                            break;
                        }
                    }
                    if (find == false) {
                        continue;
                    }
                }
                r[r.length] = flag;
                r[r.length] = i;
                r[r.length] = flag;
                r[r.length] = ":";
                r[r.length] = flag;
                r[r.length] = obj2str(o[i], flag, false, fieldArray);
                r[r.length] = flag;
                r[r.length] = ",";
            }
            r[r.length - 1] = "}";
        } else {//数组元素  
            r[0] = arr_start;
            for (var i = 0; i < o.length; i++) {
                r[r.length] = flag;
                r[r.length] = obj2str(o[i], flag, false, fieldArray);
                r[r.length] = flag;
                r[r.length] = ",";
            }
            r[r.length - 1] = arr_end;
        }

        var str = r.join("");
        //alert("结果:"+str);  
        //针对{} 就是没有属性的对象，会返回单个 },把它补齐  
        if (str == "}") {
            str = "{}";
        }
        //针对[] 就是长度为0的数组，会返回单个 ],把它补齐  
        if (str == arr_end) {
            str = arr_start + arr_end;
        }

        if (replace) {//在递归子循环中不替换,到最后统一替换  
            //替换掉 "{ }" "[ ]"  
            var reg = new RegExp(flag + "{", "g"); // 包含字符 "{  
            str = str.replace(reg, "{");

            reg = new RegExp("}" + flag, "g"); // 包含字符 }"  
            str = str.replace(reg, "}");

            reg = new RegExp(flag + arr_start, "g"); // 包含字符 "[  
            str = str.replace(reg, "[");

            reg = new RegExp(arr_end + flag, "g"); // 包含字符 ]"  
            str = str.replace(reg, "]");

            //alert(str);  

            if (str.indexOf(arr_start + "{") > -1) {
                reg = new RegExp(arr_start + "{", "g");
                str = str.replace(reg, "[{");
            }
            if (str.indexOf("}" + arr_end) > -1) {
                reg = new RegExp("}" + arr_end, "g");
                str = str.replace(reg, "}]");
            }
        }
        //alert("--"+str);  
        return str;
    }
    return o.toString();
}
//====================json end=============================
//---------------ztree region----------------------------
mifCommon.prototype.initTree = function (treeId, setting, nodeJson,asyncUrl) {

    var set = {
        data: {
            simpleData: {
                enable: true
            }
        },
        async: {
				enable: true,
				url: asyncUrl,
				autoParam:["id", "name=n", "level=lv"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			}

    };
    if (typeof (setting) != 'undefined' && setting != null) {
        set = setting;
    }

    $.fn.zTree.init($("#" + treeId), set, nodeJson);
}
mifCommon.prototype.initAsyncTree = function (treeId, asyncUrl, fnOnClick, fnonAsyncSuccess) {
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: false
        },

        async: {
            enable: true,
            url: asyncUrl,
            autoParam: ["id", "name=n", "level=lv"]
        },
        callback: {
            onClick: fnOnClick,
            onAsyncSuccess: fnonAsyncSuccess
        }


    };
    if (typeof (setting) != 'undefined' && setting != null) {
        set = setting;
    }
    var ztree = $.fn.zTree.init($("#" + treeId), setting);
    return $.fn.zTree.getZTreeObj(treeId);
}
//================ztree end===============================




function KeyValObj(key, val) {
    this.Key = key;
    this.Val = val;
}
