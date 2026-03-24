<%--
  Class Name : EgovIndvdlSchdulManageModify.jsp
  Description : ?ºÏ†ïÍ¥ÄÎ¶??òÏ†ï ?òÏù¥ÏßÄ
  Modification Information
 
      ?òÏ†ï??        ?òÏ†ï??                  ?òÏ†ï?¥Ïö©
    -------    --------    ---------------------------
     2008.03.09    ?•Îèô??         ÏµúÏ¥à ?ùÏÑ±
     2011.08.31   JJY       Í≤ΩÎüâ?òÍ≤Ω Î≤ÑÏ†Ñ ?ùÏÑ±
 
    author   : Í≥µÌÜµ?úÎπÑ??Í∞úÎ∞ú?Ä ?•Îèô??    since    : 2009.03.09
   
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>

<c:set var="ImgUrl" value="/images/egovframework/cop/smt/sim/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>?ºÏ†ï ?òÏ†ï</title>
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>

<script type="text/javaScript" language="javascript">


/* ********************************************************
 * Ï¥àÍ∏∞?? ******************************************************** */
function fn_egov_init_IndvdlSchdulManage(){

    var existFileNum = document.getElementById("indvdlSchdulManageVO").fileListCnt.value;     
    var maxFileNum = document.getElementById("indvdlSchdulManageVO").posblAtchFileNumber.value;


    if(existFileNum=="undefined" || existFileNum ==null){
        existFileNum = 0;
    }

    if(maxFileNum=="undefined" || maxFileNum ==null){
        maxFileNum = 0;
    }       

    var uploadableFileNum = maxFileNum - existFileNum;

    if(uploadableFileNum<0) {
        uploadableFileNum = 0;
    }
                    
    if(uploadableFileNum != 0){
        
        fn_egov_check_file('Y');
        
        var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
        multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
        
    }else{
        fn_egov_check_file('N');
    }   
}
/* ********************************************************
 * Î™©Î°ù ?ºÎ°ú Í∞ÄÍ∏? ******************************************************** */
function fn_egov_list_IndvdlSchdulManage(){
    location.href = "<c:url value='/'/>/cop/smt/sim/EgovIndvdlSchdulManageMonthList.do";
}
/* ********************************************************
 * ?Ä?•Ï≤òÎ¶¨ÌôîÎ©? ******************************************************** */
function fn_egov_save_IndvdlSchdulManage(){
	var form = document.getElementById("indvdlSchdulManageVO");
    if(confirm("<spring:message code="common.save.msg" />")){
        if(!validateIndvdlSchdulManageVO(form)){            
            return;
        }else{
            var schdulBgndeYYYMMDD = document.getElementById('schdulBgndeYYYMMDD').value;
            var schdulEnddeYYYMMDD = document.getElementById('schdulEnddeYYYMMDD').value;
            schdulBgndeYYYMMDD = schdulBgndeYYYMMDD.replaceAll('-','');
            schdulEnddeYYYMMDD = schdulEnddeYYYMMDD.replaceAll('-','');
            if(schdulBgndeYYYMMDD > schdulEnddeYYYMMDD) { alert("?ºÏ†ïÏ¢ÖÎ£å?ºÏûêÍ∞Ä  ?ºÏ†ï?úÏûë?ºÏûêÎ≥¥Îã§ ?ëÏùÑ???ÜÏäµ?àÎã§"); return false; }
            form.schdulBgnde.value = schdulBgndeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('schdulBgndeHH') +  fn_egov_SelectBoxValue('schdulBgndeMM') +'00';
            form.schdulEndde.value = schdulEnddeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('schdulEnddeHH') +  fn_egov_SelectBoxValue('schdulEnddeMM') +'00';

            form.action="<c:url value='/'/>cop/smt/sim/EgovIndvdlSchdulManageModifyActor.do"
            form.submit();
        }
    }
}

function fn_egov_check_file(flag) {
    if(flag=="Y") {
        document.getElementById('file_upload_posbl').style.display = "block";
        document.getElementById('file_upload_imposbl').style.display = "none";          
    } else {
        document.getElementById('file_upload_posbl').style.display = "none";
        document.getElementById('file_upload_imposbl').style.display = "block";
    }
}   

/* ********************************************************
* Ï£ºÍ? Î∂Ä???ùÏóÖÏ∞ΩÏó¥Í∏?******************************************************** */
function fn_egov_schdulDept_DeptSchdulManage(){

    var arrParam = new Array(1);
    arrParam[0] = self;
    arrParam[1] = "typeDeptSchdule";
    
    window.showModalDialog("/uss/olp/mgt/EgovMeetingManageLisAuthorGroupPopup.do", arrParam ,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
}


/* ********************************************************
* ?ÑÏù¥?? ?ùÏóÖÏ∞ΩÏó¥Í∏?******************************************************** */
function fn_egov_schdulCharger_DeptSchdulManagee(){
    var arrParam = new Array(1);
    arrParam[0] = window;
    arrParam[1] = "typeDeptSchdule";

    window.showModalDialog("/uss/olp/mgt/EgovMeetingManageLisEmpLyrPopup.do", arrParam,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
}

/* ********************************************************
* RADIO BOX VALUE FUNCTION
******************************************************** */
function fn_egov_RadioBoxValue(sbName)
{
    var FLength = document.getElementsByName(sbName).length;
    var FValue = "";
    for(var i=0; i < FLength; i++)
    {
        if(document.getElementsByName(sbName)[i].checked == true){
            FValue = document.getElementsByName(sbName)[i].value;
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
<body onLoad="fn_egov_init_IndvdlSchdulManage();">
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
                            <li><strong>?ºÏ†ïÍ¥ÄÎ¶??òÏ†ï</strong></li>
                        </ul>
                    </div>
                </div>
                
                <!-- Í≤Ä???ÑÎìú Î∞ïÏä§ ?úÏûë -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>?ºÏ†ïÍ¥ÄÎ¶??òÏ†ï</strong></h2></div>
                </div>
                <form:form modelAttribute="indvdlSchdulManageVO" action="/cop/smt/sim/EgovIndvdlSchdulManageModifyActor.do" method="post" enctype="multipart/form-data">
                    <div class="modify_user" >
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
                            <tr>
                                <th width="20%" height="23" class="required_text" nowrap >?ºÏ†ïÍµ¨Î∂Ñ<!--  <img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                                <td width="80%" >
							        <form:select path="schdulSe">
							            <form:option value="" label="?†ÌÉù"/>
							            <form:options items="${schdulSe}" itemValue="code" itemLabel="codeNm"/>
							        </form:select>
							        <div><form:errors path="schdulSe" cssClass="error"/></div>
                                </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23" class="required_text" nowrap >Ï§ëÏöî??!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                                <td width="80%" >
							        <form:select path="schdulIpcrCode">
							            <form:option value="" label="?†ÌÉù"/>
							            <form:options items="${schdulIpcrCode}" itemValue="code" itemLabel="codeNm"/>
							        </form:select>
							        <div><form:errors path="schdulIpcrCode" cssClass="error"/></div>
                                </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23" class="required_text" nowrap >Î∂Ä??!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                                <td width="80%" >
 							            <form:input path="schdulDeptName" size="73" cssClass="txaIpt" readonly="true" maxlength="1000" />
							        <form:hidden path="schdulDeptId" />
							        <div><form:errors path="schdulDeptName" cssClass="error"/></div>
                                </td>
                            </tr>
                            <tr>
                                <th width="20%" height="23" class="required_text" nowrap >?ºÏ†ïÎ™?!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                                <td width="80%" >
							      <form:input path="schdulNm" size="73" cssClass="txaIpt" maxlength="255" />
							      <div><form:errors path="schdulNm" cssClass="error"/></div>
                                </td>
                            </tr>
                            <tr>
                                <th height="23" class="required_text" >?ºÏ†ï ?¥Ïö©<!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                                <td>
							        <form:textarea path="schdulCn" rows="3" cols="80" cssClass="txaClass"/>
							        <div><form:errors path="schdulCn" cssClass="error"/></div>
                                </td>
                            </tr>
                            <tr> 
                              <th width="20%" height="23" class="required_text" nowrap >Î∞òÎ≥µÍµ¨Î∂Ñ<!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                              <td width="80%">
						       <form:radiobuttons path="reptitSeCode" items="${reptitSeCode}" itemValue="code" itemLabel="codeNm"/>
						       <div><form:errors path="reptitSeCode" cssClass="error"/></div>
                              </td>
                            </tr>
                        
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >?†Ïßú/?úÍ∞Ñ<!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                            <td width="80%" >
							    <form:input path="schdulBgndeYYYMMDD" size="10" readonly="true" maxlength="10" />
							        <a href="#LINK" onClick="javascript:fn_egov_NormalCalendar(document.getElementById('indvdlSchdulManageVO'), document.getElementById('indvdlSchdulManageVO').schdulBgndeYYYMMDD,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>'); return false;">
							    <img src="<c:url value='/images/calendar.gif' />"  align="middle" style="border:0px" alt="?ºÏ†ï?úÏûë?¨Î†•" title="?ºÏ†ï?úÏûë?¨Î†•">
							    </a>
							    &nbsp&nbsp~&nbsp&nbsp
							    <form:input path="schdulEnddeYYYMMDD" size="10" readonly="true" maxlength="10" />
							        <a href="#LINK" onClick="javascript:fn_egov_NormalCalendar(document.getElementById('indvdlSchdulManageVO'), document.getElementById('indvdlSchdulManageVO').schdulEnddeYYYMMDD,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>'); return false;">
							    <img src="<c:url value='/images/calendar.gif' />" align="middle" style="border:0px" alt="?ºÏ†ïÏ¢ÖÎ£å?¨Î†•" title="?ºÏ†ïÏ¢ÖÎ£å?¨Î†•">
							    </a>&nbsp;
							        
							        <form:select path="schdulBgndeHH">
							            <form:options items="${schdulBgndeHH}" itemValue="code" itemLabel="codeNm"/>
							        </form:select>??							        <form:select path="schdulBgndeMM">
							            <form:options items="${schdulBgndeMM}" itemValue="code" itemLabel="codeNm"/>
							        </form:select>Î∂?							        ~
							        <form:select path="schdulEnddeHH">
							            <form:options items="${schdulEnddeHH}" itemValue="code" itemLabel="codeNm"/>
							        </form:select>??							        <form:select path="schdulEnddeMM">
							            <form:options items="${schdulEnddeMM}" itemValue="code" itemLabel="codeNm"/>
							        </form:select>Î∂?                            </td>
                          </tr>
                          
                          <tr> 
                            <th width="20%" height="23" class="required_text" nowrap >?¥Îãπ??!--<img src="${ImgUrl}icon/required.gif" width="15" height="15">--></th>
                            <td width="80%" >
						            <form:input path="schdulChargerName" size="73" cssClass="txaIpt" readonly="true" maxlength="10" />
						         <div><form:errors path="schdulChargerName" cssClass="error"/></div>
						       <form:hidden path="schdulChargerId" />
                            </td>
                          </tr>
                          
						 <!-- Ï≤®Î?Î™©Î°ù??Î≥¥Ïó¨Ï£ºÍ∏∞ ?ÑÌïú -->  
						  <c:if test="${indvdlSchdulManageVO.atchFileId ne null && indvdlSchdulManageVO.atchFileId ne ''}">
						    <tr> 
						        <th height="23" class="required_text">Ï≤®Î??åÏùº Î™©Î°ù</th>
						        <td>
						            <c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfs.do" >
						                <c:param name="param_atchFileId" value="${egovc:encrypt(indvdlSchdulManageVO.atchFileId)}" />
						            </c:import>     
						        </td>
						    </tr>
						  </c:if>   
						 
		 
			
						 <!-- Ï≤®Î??îÏùº ?ÖÎ°ú?úÎ? ?ÑÌïú Start -->
						  <tr> 
						    <th height="23" class="required_text">?åÏùºÏ≤®Î?</th>
						    <td style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;" >
						        <div id="file_upload_posbl"  style="display:none;" >    
						                      <input name="file_1" id="egovComFileUploader" title="?åÏùºÏ≤®Î?" type="file"  />
						                        <div id="egovComFileList"></div>
						        </div>
						        <div id="file_upload_imposbl"  style="display:none;" >
						        </div>  
						    </td>       
						  </tr>
						 <!-- Ï≤®Î??îÏùº ?ÖÎ°ú?úÎ? ?ÑÌïú end.. -->
                        </table>
                    </div>

	                    <!-- Î≤ÑÌäº ?úÏûë(?ÅÏÑ∏ÏßÄ??styleÎ°?div??ÏßÄ?? -->
	                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
							<!-- Î™©Î°ù/?Ä?•Î≤Ñ?? -->
	                        <table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr> 
							  <td>
							     <a href="<c:url value='/'/>/cop/smt/sim/EgovIndvdlSchdulManageMonthList.do" onclick="JavaScript:fn_egov_list_IndvdlSchdulManage(); return false;"><spring:message code="button.list" /></a> 
							  </td>
							  <td width="10"></td>
							  <td>
							     <a href="#LINK" onclick="JavaScript:fn_egov_save_IndvdlSchdulManage(); return false;"><spring:message code="button.save" /></a> 
							  </td>
							</tr>
							</table>
	                    </div>
	                    <!-- Î≤ÑÌäº ??-->                           

						  <c:if test="${indvdlSchdulManageVO.atchFileId eq null || indvdlSchdulManageVO.atchFileId eq ''}">
						    <input type="hidden" name="fileListCnt" value="0" />
						    <input name="atchFileAt" type="hidden" value="N">
						  </c:if> 
						
						  <c:if test="${indvdlSchdulManageVO.atchFileId ne null && indvdlSchdulManageVO.atchFileId ne ''}">
						    <input name="atchFileAt" type="hidden" value="Y"> 
						  </c:if> 


						<form:hidden path="schdulId" />
						<form:hidden path="schdulKindCode" />
						<input type="hidden" name="schdulBgnde" id="schdulBgnde" value="" />  
						<input type="hidden" name="schdulEndde" id="schdulEndde" value="" />  
						
						<input type="hidden" name="posblAtchFileNumber" value="3" />  
						<input type="hidden" name="cmd" id="cmd" value="<c:out value='save'/>" />
						<input type="hidden" name="cal_url" id="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />

            </form:form>
        
        </div>
        </div>
        <!-- //?òÏù¥ÏßÄ ?§ÎπÑÍ≤åÏù¥????-->  
        <!-- //content ??-->    
    </div>  
    <!-- //container ??-->
    <!-- footer ?úÏûë -->
    <div id="footer"><jsp:include page="/WEB-INF/jsp/main/inc/EgovIncFooter.jsp"/></div>
    <!-- //footer ??-->
<!-- //?ÑÏ≤¥ ?àÏù¥????-->
</body>
</html>
