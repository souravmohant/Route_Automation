<%--  googEditRouteTemplateAllTasksDialog.jsp

   Copyright (c) 1992-2018 Dassault Systemes.All Rights Reserved.
   This program contains proprietary and trade secret information of MatrixOne,Inc.
   Copyright notice is precautionary only and does not evidence any actual or intended publication of such program

   static const char RCSID[] = $Id: googEditRouteTemplateAllTasksDialog.jsp.jsp.rca 1.19 Tue Oct 28 19:01:04 2008 przemek Experimental przemek $
--%>

<%@page import="com.matrixone.apps.framework.ui.UIUtil"%>
<%@include file  = "../emxUICommonAppInclude.inc"%>
<%@include file  = "emxRouteInclude.inc"%>
<%@include file  = "../emxJSValidation.inc" %>
<%@page import  = "com.matrixone.apps.domain.util.*"%>
<head>
	<%@include file = "../common/emxUIConstantsInclude.inc"%>
<script language="JavaScript" src="../common/scripts/emxUICore.js"
	type="text/javascript"></script>
<script language="JavaScript" src="../common/scripts/emxUIConstants.js"
	type="text/javascript"></script>
	<script language="Javascript">
		addStyleSheet("emxUIDefault");
		addStyleSheet("emxUIList");
	</script>
</head>

<%

String mode=emxGetParameter(request,"mode");
String selectedIDS                        = emxGetParameter(request,"objectId");
MapList routeSequenceLists = new MapList();
HashMap programMap = new HashMap();
programMap.put("routeID", selectedIDS);

routeSequenceLists = (MapList)JPO.invoke(context, "googCustomFunctions", null, "getRouteSequenceList", JPO.packArgs(programMap), MapList.class);

String strPersonDetails = MqlUtil.mqlCommand(context, "list person *");
String strGroupDetails = MqlUtil.mqlCommand(context, "list group *");
StringList strPersonDetailsList = (StringList) FrameworkUtil.split(strPersonDetails, "\n");
StringList strGroupDetailsList = (StringList) FrameworkUtil.split(strGroupDetails, "\n");
String [] strGrouparray = new String[strGroupDetailsList.size()];
for(int i = 0;i<strGroupDetailsList.size();i++){
	strGrouparray[i] = strGroupDetailsList.get(i);
}
System.out.println(strPersonDetailsList);
System.out.println(strGroupDetailsList);
String stretest = "hi";
%>

<%@include file = "../emxUICommonHeaderBeginInclude.inc" %>

<script>
 function setUnloadMethod()
 {
	var bodyElement = document.getElementById("taskdelete");  
    if (isIE && bodyElement){    
        bodyElement.onunload = function () { closeWindow(); };
    }else{
        bodyElement.setAttribute("onbeforeunload",  "return closeWindow()");
    }
 }
 function submitForm() {
	 //var URL = "<%=strGroupDetailsList%>";
	
	 
	  array = "<%=strGrouparray%>";
for (index = 0; index < array.length; index++) { 
    alert(array[index]); 
}  
	
	   for (var i=0; i<document.TaskSummary.length;i++) {
		  if ( (document.TaskSummary.elements[i].type == "text") && (document.TaskSummary.elements[i].name == "personname" || document.TaskSummary.elements[i].name == "order")) {
		  if((document.TaskSummary.elements[i].name == "personname") && (document.TaskSummary.elements[i].value.length == 0)) {
			 alert("Enter Task Assignee Details before submitting the Page");
			 document.TaskSummary.elements[i].focus();
                return;
			 } else if((document.TaskSummary.elements[i].name == "personname") && (document.TaskSummary.elements[i].value.length > 0)) {
				
				
				
			 }
			 if((document.TaskSummary.elements[i].name == "order") && (document.TaskSummary.elements[i].value.length == 0)) {
			 alert("Enter Task Sequence Order Details before submitting the Page");
			 document.TaskSummary.elements[i].focus();
                return;
			 }
		  }
	   }
  } 
  function doCheck(){
    var objForm   = document.TaskSummary;
    var chkList   = objForm.chkList;
    for (var i=0; i < objForm.elements.length; i++){
      if (objForm.elements[i].name.indexOf('chkItem') > -1){
        objForm.elements[i].checked = chkList.checked;
      }
    }
  }
  function updateCheck() {
    var objForm = document.TaskSummary;
    var chkList = objForm.chkList;
    chkList.checked = false;
  }
  
  function removeOnloadEvents()
{
	var bodyElement = document.getElementById("taskdelete");
	if (isIE && bodyElement){	
   		bodyElement.onunload = null;
	}else{
	  	bodyElement.setAttribute("onbeforeunload",  "");
	}
}

  function addNewRow(){
    alert("=====Inside addNewRow=====");
	var templateName='';

	  var table = document.getElementById("taskList");
	  var rowCount = table.rows.length;
	  var row = table.insertRow(1);
	  
	  //<tr class='<fw:swap id="even"/>'>
	  row.setAttribute('class', '<fw:swap id="even"/>');
	  var colCount = table.rows[0].cells.length;
	  for(var i=0; i<colCount; i++) {           
			var newcell	= row.insertCell(i);
			 
			/*  if(i == 0){
				 var ele = document.createElement('input');
				 ele.setAttribute('type', 'checkbox');
				 ele.setAttribute('name', 'chkItem1');
				 ele.setAttribute('id', 'chkItem1');
                 ele.setAttribute('value', '');
				 newcell.appendChild(ele);
			 }  */
			 if(i == 0){
				   var ele2 = document.createElement('input');
				   ele2.setAttribute('type', 'text');
                   ele2.setAttribute('value', '');
				   ele2.setAttribute('name', 'personname');
				   newcell.appendChild(ele2);
			 } else if (i == 1){
				 
				 var ele3 = document.createElement('input');
				   ele3.setAttribute('type', 'text');
                   ele3.setAttribute('value', '');
				   ele3.setAttribute('name', 'order');
				   newcell.appendChild(ele3);
				
			  } else if (i == 2){
				  var textarea = document.createElement("textarea");
				  textarea.setAttribute('name', 'Title');
				  textarea.setAttribute('value', '');
				  newcell.appendChild(textarea);
				  
			  } else {
				    var textarea1 = document.createElement("textarea");
				    textarea1.setAttribute('name', 'Instruction');
				    textarea1.setAttribute('value', '');
				    newcell.appendChild(textarea1);
			  }
             
			
			}
    
  }
  
  function personNameValidation(){
	  
	  //alert("========personNameValidation=========");
	 // alert("====personNameValidation======"+document.TaskSummary.elements.value);
  }

</script>
<body id="taskdelete" name="taskdelete" onload="setUnloadMethod()" class="editable">
<form name = "TaskSummary" method="post" onSubmit="javascript:submitForm(); return false" action="googemxEditRouteTemplateAllTasksProcess1.jsp">
<table class="list" id="taskList">
	<tbody>
  <tr>
			<!--<th style="text-align:center">
            <input type="checkbox" name="chkList" id="chkList" onclick="doCheck()"/>
            </th> -->
			<th nowrap class="required">
		    <emxUtil:i18n localize="i18nId">Name</emxUtil:i18n>
		    </th>
			<th nowrap class="required">
		    <emxUtil:i18n localize="i18nId">Order</emxUtil:i18n>
		    </th>
			<th nowrap>
		    <emxUtil:i18n localize="i18nId">Title</emxUtil:i18n>
		    </th>
			<th nowrap>
		    <emxUtil:i18n localize="i18nId">Instruction</emxUtil:i18n>
		    </th>
		    
		 
  </tr>


<framework:mapListItr mapList="<%=routeSequenceLists%>" mapName="routeMap">
<%
 
 String sPersonName = (String)routeMap.get("Name");
 String strRouteOrder = (String)routeMap.get("Order");
 String strTemplateNodeId = (String)routeMap.get("Nodeid");
 String strTemplateTitle = (String)routeMap.get("Title");
 String strTemplateInstruction = (String)routeMap.get("Instruction"); 

%>
    <tr class="odd">
          <input type="hidden" name="NodeID" value="<xss:encodeForHTMLAttribute><%=strTemplateNodeId%></xss:encodeForHTMLAttribute>" />
         <!-- <td style="text-align: center;vertical-align:top;">
		  <input type = "checkbox" name = "chkItem1" id = "chkItem1" value = "<xss:encodeForHTMLAttribute><%=strTemplateNodeId%></xss:encodeForHTMLAttribute>" onClick="updateCheck()"/>		
		  </td>-->
		   <td >
           <input type="text" name="personname" value="<xss:encodeForHTMLAttribute><%=sPersonName%></xss:encodeForHTMLAttribute>" onChange="personNameValidation()"/> 
          </td>
		  <td >
           <input type="text" name="order" value="<xss:encodeForHTMLAttribute><%=strRouteOrder%></xss:encodeForHTMLAttribute>"/> 
          </td>
		   <td style="vertical-align:top">
                <textarea style="min-height:50px;" rows="6" name="Title"><%=strTemplateTitle%></textarea>              
		   </td>
		   <td style="vertical-align:top">
               <textarea style="min-height:50px;" rows="6" name="Instruction"><%=strTemplateInstruction%></textarea>                
		   </td>

	</tr>
  </framework:mapListItr>

  </tbody>
  </table>
  
</form>
</body>
<%
%>
<%@include file = "../emxUICommonEndOfPageInclude.inc" %>

