<%--  googAutomateRouteDialogFS.jsp
   Copyright (c) 1992-2018 Dassault Systemes.
   All Rights Reserved.
   This program contains proprietary and trade secret information of MatrixOne, Inc.
   Copyright notice is precautionary only and does not evidence any actual or intended publication of such program

   static const char RCSID[] = $Id: emxEditAllTasksDialogFS.jsp.rca 1.14 Wed Oct 22 16:18:31 2008 przemek Experimental przemek $
--%>

<%@include file = "../emxUIFramesetUtil.inc"%>
<%@include file = "emxRouteInclude.inc"%>

<%
  framesetObject fs = new framesetObject();

  String initSource = emxGetParameter(request,"initSource");
  if (initSource == null){
    initSource = "";
  }

  String jsTreeID     = emxGetParameter(request,"jsTreeID");
  String suiteKey     = emxGetParameter(request,"suiteKey");
  String routeId = emxGetParameter(request,"objectId");
  String addTasks     = emxGetParameter(request,"addTasks");
  String fromPage     = emxGetParameter(request,"fromPage");
  String isRouteTemplateRevised = emxGetParameter(request,"isRouteTemplateRevised");
  

  
  //Added for IR-043896V6R2011
     String newTaskIds                      = emxGetParameter(request,"newTaskIds");
  //Addition ends for IR-043896V6R2011

  fs.setDirectory(appDirectory);
  fs.useCache(false);

  String strTaskEditSetting   = null;  

  String sTypeRoute          = PropertyUtil.getSchemaProperty(context, "type_Route");
  String sTypeRouteTemplate  = PropertyUtil.getSchemaProperty(context, "type_RouteTemplate");

  // Page Heading - Internationalized
  String PageHeading = "";
  PageHeading = "emxComponents.EditAllTasks.Heading";




  // Specify URL to come in middle of frameset
  StringBuffer contentURL = new StringBuffer(256);
   contentURL.append("googEditRouteAllTasksDialog.jsp");

  contentURL.append("?suiteKey=");
  contentURL.append(suiteKey);
  contentURL.append("&initSource=");
  contentURL.append(initSource);
  contentURL.append("&jsTreeID=");
  contentURL.append(jsTreeID);
  contentURL.append("&objectId=");
  contentURL.append(routeId);
  ////Added for IR-043896V6R2011
  contentURL.append("&addTasks=");
  contentURL.append(addTasks);
  contentURL.append("&fromPage=");
  contentURL.append(fromPage);
  contentURL.append("&newTaskIds=");
  contentURL.append(newTaskIds);
  contentURL.append("&isRouteTemplateRevised=");
  contentURL.append(isRouteTemplateRevised);
	  

  String HelpMarker = "emxhelpeditalltasks1";

  fs.initFrameset(PageHeading,HelpMarker,contentURL.toString(),false,true,false,false);


  fs.setStringResourceFile("emxComponentsStringResource");

  fs.createCommonLink("Assign User",
                            "addNewRow()",
                            "role_GlobalUser",
                            false,
                            true,
                            "default",
                            true,
                            3);

   fs.createCommonLink("Save MemberList",
                      "deleteRow()",
                      "role_GlobalUser",
                      false,
                      true,
                      "default",
                      false,
                      3);
        

  fs.createCommonLink("Submit",
                        "submitForm()",
                        "role_GlobalUser",
                        false,
                        true,
                        "common/images/buttonDialogNext.gif",
                        false,
                        3);
  
/* 
     fs.createCommonLink("emxComponents.Button.Cancel",
                      "closeWindow()",
                      "role_GlobalUser",
                      false,
                      true,
                      "common/images/buttonDialogCancel.gif",
                      false,
                      3); */
  fs.removeDialogWarning();
  fs.writePage(out);
%>

