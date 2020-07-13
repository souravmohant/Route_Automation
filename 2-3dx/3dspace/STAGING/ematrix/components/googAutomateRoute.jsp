<%--  googAutomateRoute.jsp   -   To open the Edit All dialog based on type
   Copyright (c) 1993-2018 Dassault Systemes.
   All Rights Reserved.
   This program contains proprietary and trade secret information of MatrixOne, Inc.
   Copyright notice is precautionary only and does not evidence any actual or intended publication of such program

   static const char RCSID[] = $Id: emxEditAllTasksValidation.jsp
--%>

<%@include file  = "../emxUICommonAppInclude.inc"%>
<%@include file  = "emxRouteInclude.inc"%>

<html>
<head>
<script src='../common/scripts/emxUICore.js'></script>
<script src='../common/scripts/emxUIModal.js'></script>
<script src='../emxUIPageUtility.js'></script>
<script language="javascript" src="../common/scripts/emxUIConstants.js"></script>
</head>
<body>
<script>
<%

String routeId = emxGetParameter(request,"objectId");
String RTUrl = "googAutomateRouteDialogFS.jsp?objectId=" + routeId;
System.out.println("====RTUrl==="+RTUrl);
%>

            //XSSOK
			var URL = "<%=RTUrl%>";
            document.location.href = URL;

</script>
</body>
</html>
