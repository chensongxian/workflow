/**
 * Created by Administrator on 2016-8-18.
 */
//校验密码：只能输入6-12个字母、数字、下划线
function isPasswd(s)
{
    var patrn=/^[\w]{6,12}$/;
    if (!patrn.exec(s)) return false;
    return true;
}

function isEmpty (str) {
    if ((str==null)||(str.length==0)) return true;
    else return(false);
}

function allNumber(str) {
    return /^[0-9]*$/.test(str);
}
function isEmail (theStr) {
    var atIndex = theStr.indexOf('@');
    var dotIndex = theStr.indexOf('.', atIndex);
    var flag = true;
    theSub = theStr.substring(0, dotIndex+1)
    if ((atIndex < 1)||(atIndex != theStr.lastIndexOf('@'))||(dotIndex < atIndex + 2)||(theStr.length <= theSub.length))
    { return(false); }
    else { return(true); }
}
