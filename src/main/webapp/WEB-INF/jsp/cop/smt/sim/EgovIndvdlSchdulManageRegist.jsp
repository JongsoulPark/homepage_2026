<%--
  Class Name : EgovIndvdlSchdulManageRegist.jsp
  Description : ?ºÏ†ïÍ¥ÄÎ¶??±Î°ù ?òÏù¥ÏßÄ
  Modification Information
 
      ?òÏ†ï??        ?òÏ†ï??                  ?òÏ†ï?¥Ïö©
    -------    --------    ---------------------------
     2008.03.09    ?•Îèô??         ÏµúÏ¥à ?ùÏÑ±
     2011.08.31   JJY       Í≤ΩÎüâ?òÍ≤Ω Î≤ÑÏ†Ñ ?ùÏÑ±
 
    author   : Í≥µÌÜµ?úÎπÑ??Í∞úÎ∞ú?Ä ?•Îèô??    since    : 2009.03.09
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ImgUrl" value="/images/egovframework/cop/smt/sim/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>?ºÏ†ï ?±Î°ù</title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>


<script type="text/javaScript" language="javascript">


/* ********************************************************
 * Ï¥àÍ∏∞?? ******************************************************** */
 function fn_egov_init_IndvdlSchdulManage(){

     var maxFileNum = document.getElementById('posblAtchFileNumber').value;
     
     if(maxFileNum==null || maxFileNum==""){
          maxFileNum = 3;
      }
          
     var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
     
     multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );


     document.getElementsByName('reptitSeCode')[0].checked = true;


     if("${indvdlSchdulManageVO.schdulBgnde}".length > 0){
         var schdulBgnde = "${indvdlSchdulManageVO.schdulBgnde}";
         document.getElementById("schdulBgndeYYYMMDD").value = schdulBgnde.substring(0,4) + "-" + schdulBgnde.substring(4,6) + "-" + schdulBgnde.substring(6,8);
     }

     if("${indvdlSchdulManageVO.schdulEndde}".length > 0){
         var schdulEndde = "${indvdlSchdulManageVO.schdulEndde}";
         document.getElementById("schdulEnddeYYYMMDD").value = schdulEndde.substring(0,4) + "-" + schdulEndde.substring(4,6) + "-" + schdulEndde.substring(6,8);
     }
}
/* ********************************************************
* Î™©Î°ù ?ºÎ°ú Í∞ÄÍ∏?******************************************************** */
function fn_egov_list_IndvdlSchdulManage(){
  location.href = "${pageContext.request.contextPath}/cop/smt/sim/EgovIndvdlSchdulManageMonthList.do";
}
/* ********************************************************
* ?Ä?•Ï≤òÎ¶¨ÌôîÎ©?******************************************************** */
function fn_egov_save_IndvdlSchdulManage(){
  //form.submit();return;
  var form = document.getElementById("indvdlSchdulManageVO");
function fn_egov_save_IndvdlSchdulManage(){
  var form = document.getElementById("indvdlSchdulManageVO");
  if(confirm("<spring:message code="common.save.msg" />")){
      var schdulBgndeYYYMMDD = document.getElementById('schdulBgndeYYYMMDD').value;
      var schdulEnddeYYYMMDD = document.getElementById('schdulEnddeYYYMMDD').value;
      schdulBgndeYYYMMDD = schdulBgndeYYYMMDD.replaceAll('-','');
      schdulEnddeYYYMMDD = schdulEnddeYYYMMDD.replaceAll('-','');
      if(schdulBgndeYYYMMDD > schdulEnddeYYYMMDD) { alert("???????????  ???????????? ???????????"); return false; }
      form.schdulBgnde.value = schdulBgndeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('schdulBgndeHH') + fn_egov_SelectBoxValue('schdulBgndeMM') + '00';
      form.schdulEndde.value = schdulEnddeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('schdulEnddeHH') + fn_egov_SelectBoxValue('schdulEnddeMM') + '00';
      form.submit();
  }
}
  }
  return FValue;
}
/* ********************************************************
* SELECT BOX VALUE FUNCTION
******************************************************** */
function fn_egov_SelectBoxValue(sbName)
{
  var FValue = "";
  for(var i=0; i < document.getElementById(sbName).length; i++)
  {
      if(document.getElementById(sbName).options[i].selected == true){
          
          FValue=document.getElementById(sbName).options[i].value;
      }
  }
  
  return  FValue;
}
/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
  return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
   var str = this;
   if(src == repl){return str;}
   while(str.indexOf(src) != -1) {
      str = str.replace(src, repl);
   }
   return str;
}
</script>

</head>
<body onLoad="fn_egov_init_IndvdlSchdulManage()">
<noscript>?êÎ∞î?§ÌÅ¨Î¶ΩÌä∏Î•?ÏßÄ?êÌïòÏßÄ ?äÎäî Î∏åÎùº?∞Ï??êÏÑú???ºÎ? Í∏∞Îä•???¨Ïö©?òÏã§ ???ÜÏäµ?àÎã§.</noscript>    
<!-- ?ÑÏ≤¥ ?àÏù¥???úÏûë -->
<div id="wrap">
    <!-- header ?úÏûë -->
    <div id="header_mainsize"><jsp:include page="/WEB-INF/jsp/main/inc/EgovIncHeader.jsp"/></div>
    <div id="topnavi"><jsp:include page="/WEB-INF/jsp/main/inc/EgovIncTopnav.jsp"/></div>        
    <!-- //header ??--> 
    <!-- container ?úÏûë -->
    <div id="container">
        <!-- Ï¢åÏ∏°Î©îÎâ¥ ?úÏûë -->
        <div id="leftmenu"><jsp:include page="/WEB-INF/jsp/main/inc/EgovIncLeftmenu.jsp"/></div>
        <!-- //Ï¢åÏ∏°Î©îÎâ¥ ??-->
            <!-- ?ÑÏû¨?ÑÏπò ?§ÎπÑÍ≤åÏù¥???úÏûë -->
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>?¨Ïö©?êÍ?Î¶?/li>
                            <li>&gt;</li>
                            <li><strong>?ºÏ†ïÍ¥ÄÎ¶??±Î°ù</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- Í≤Ä???ÑÎìú Î∞ïÏä§ ?úÏûë -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>?ºÏ†ïÍ¥ÄÎ¶??±Î°ù</strong></h2></div>
                </div>
                <form:form modelAttribute="indvdlSchdulManageVO" action="${pageContext.request.contextPath}/cop/smt/sim/EgovIndvdlSchdulManageRegistActor.do" name="indvdlSchdulManageVO" method="post" enctype="multipart/form-data">
                    <div class="modify_user" >
                        <table>
                            <tr>
                                <th width="20%" height="23" class="required_text"  >?ºÏ†ïÍµ¨Î∂Ñ<img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                                <td width="80%" >
                                    <form:select path="schdulSe">
                                        <form:option value="" label="?†ÌÉù"/>
                                        <form:options items="${schdulSe}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>
                                    <form:errors path="schdulSe" cssClass="error"/>
                                </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23" class="required_text"  >Ï§ëÏöî??img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                                <td width="80%" >
                                    <form:select path="schdulIpcrCode">
                                        <form:option value="" label="?†ÌÉù"/>
                                        <form:options items="${schdulIpcrCode}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>
                                    <form:errors path="schdulIpcrCode" cssClass="error"/>
                                </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23" class="required_text"  >Î∂Ä??img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                                <td width="80%" >
                                    <form:input path="schdulDeptName" size="73" cssClass="txaIpt" readonly="true" maxlength="1000" />
                                    <form:hidden path="schdulDeptId" />
                                    <form:errors path="schdulDeptName" cssClass="error"/>
                               </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23" class="required_text"  >?ºÏ†ïÎ™?img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                                <td width="80%" >
                                    <form:input path="schdulNm" size="73" cssClass="txaIpt"  />
                                    <form:errors path="schdulNm" cssClass="error"/>
                                </td>
                            </tr>
                            <tr>
                                <th height="23" class="required_text" >?ºÏ†ï ?¥Ïö©<img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                                <td>
                                    <form:textarea path="schdulCn" rows="3" cols="80" />
                                    <form:errors path="schdulCn" cssClass="error"/>
                                </td>
                            </tr>
                            <tr> 
                              <th width="20%" height="23" class="required_text"  >Î∞òÎ≥µÍµ¨Î∂Ñ<img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                              <td width="80%">
                                  <form:radiobutton path="reptitSeCode" value="1" />?πÏùº
                                  <form:radiobutton path="reptitSeCode" value="2"/>Î∞òÎ≥µ
                                  <form:radiobutton path="reptitSeCode" value="3"/>?∞ÏÜç
                                  <form:errors path="reptitSeCode" cssClass="error"/>
                              </td>
                            </tr>
                        
                          <tr> 
                            <th width="20%" height="23" class="required_text"  >?†Ïßú/?úÍ∞Ñ<img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                            <td width="80%" >
                                <form:input path="schdulBgndeYYYMMDD" size="11" readonly="true" maxlength="10" />
                                <a href="#LINK" onClick="javascript:fn_egov_NormalCalendar(document.indvdlSchdulManageVO, document.indvdlSchdulManageVO.schdulBgndeYYYMMDD,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>');">
                                <img src="<c:url value='/images/calendar.gif' />"  align="middle" style="border:0px" alt="?ºÏ†ï?úÏûë?¨Î†•" title="?ºÏ†ï?úÏûë?¨Î†•">
                                </a>
                                &nbsp;&nbsp;~&nbsp;&nbsp;
                                <form:input path="schdulEnddeYYYMMDD" size="11" readonly="true" maxlength="10" />
                                <a href="#LINK" onClick="javascript:fn_egov_NormalCalendar(document.indvdlSchdulManageVO, document.indvdlSchdulManageVO.schdulEnddeYYYMMDD,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>');">
                                <img src="<c:url value='/images/calendar.gif' />" align="middle" style="border:0px" alt="?ºÏ†ïÏ¢ÖÎ£å?¨Î†•" title="?ºÏ†ïÏ¢ÖÎ£å?¨Î†•">
                                </a>&nbsp;&nbsp;
                                    
                                    <form:select path="schdulBgndeHH">
                                        <form:options items="${schdulBgndeHH}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>??                                    <form:select path="schdulBgndeMM">
                                        <form:options items="${schdulBgndeMM}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>Î∂?                                    ~
                                    <form:select path="schdulEnddeHH">
                                        <form:options items="${schdulEnddeHH}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>??                                    <form:select path="schdulEnddeMM">
                                        <form:options items="${schdulEnddeMM}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>Î∂?                            </td>
                          </tr>
                          
                          <tr> 
                            <th width="20%" height="23" class="required_text"  >?¥Îãπ??img alt="required" src="<c:url value="/images/required.gif"/>" width="15" height="15" ></th>
                            <td width="80%" >
                                <form:input path="schdulChargerName" size="73" cssClass="txaIpt" readonly="true" maxlength="10" />
                                <form:errors path="schdulChargerName" cssClass="error"/>
                                <form:hidden path="schdulChargerId" />
                            </td>
                          </tr>
                          
                        <!-- Ï≤®Î??åÏùº ?åÏù¥Î∏??àÏù¥?ÑÏõÉ ?§Ï†ï Start.. -->
                          <tr>
                            <th height="23" class="required_text" >?åÏùºÏ≤®Î?</th>
                            <td>
                                           <input name="file_1" id="egovComFileUploader" title="?åÏùºÏ≤®Î?" type="file" />
                                           <div id="egovComFileList"></div>
                             </td>
                          </tr>
                        <!-- Ï≤®Î??åÏùº ?åÏù¥Î∏??àÏù¥?ÑÏõÉ End. -->

                        </table>
                    </div>
                    <!-- Î≤ÑÌäº ?úÏûë(?ÅÏÑ∏ÏßÄ??styleÎ°?div??ÏßÄ?? -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- Î™©Î°ù/?Ä?•Î≤Ñ?? -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                              <a href="${pageContext.request.contextPath}/cop/smt/sim/EgovIndvdlSchdulManageMonthList.do" onclick="JavaScript:fn_egov_list_IndvdlSchdulManage(); return false;"><spring:message code="button.list" /></a> 
                          </td>
                          <td>
                              <a href="#LINK" onclick="JavaScript:fn_egov_save_IndvdlSchdulManage();"><spring:message code="button.save" /></a> 
                          </td>  
                        </tr>
                        </table>
                    </div>
                    <!-- Î≤ÑÌäº ??-->                           
                    <input name="cmd" id="cmd"type="hidden" value="<c:out value='save'/>"/>
                    <input type="hidden" name="schdulKindCode" id="schdulKindCode" value="2" />
                    <input type="hidden" name="cal_url" id="cal_url" value="<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>" />
                    <input type="hidden" name="schdulBgnde" id="schdulBgnde" value="" />  
                    <input type="hidden" name="schdulEndde" id="schdulEndde" value="" /> 
                    <!-- Ï≤®Î??åÏùº Í∞?àòÎ•??ÑÌïú hidden -->
                    <input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3" />
                </form:form>

            </div>  
            <!-- //content ??-->    
    </div>  
    <!-- //container ??-->
    <!-- footer ?úÏûë -->
    <div id="footer"><jsp:include page="/WEB-INF/jsp/main/inc/EgovIncFooter.jsp"/></div>
    <!-- //footer ??-->
</div>
<!-- //?ÑÏ≤¥ ?àÏù¥????-->
</body>
</html>

