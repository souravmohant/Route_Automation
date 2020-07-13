/*
*=================================================================
** emxManufacturerEquivalentPartFormCreateValidation.js
** Copyright Dassault Systemes, 2007. All rights reserved
** This program is proprietary property of Dassault Systemes and its subsidiaries.
** This documentation shall be treated as confidential information and may only be used by employees or contractors
** with the Customer in accordance with the applicable Software License Agreement
** static const char RCSID[] = $Id: /ENOManufacturerEquivalentPart/CNext/webroot/manufactuerequivalentpart/emxManufacturerEquivalentPartFormCreateValidation.js 1.1.2.1.1.1 Wed Oct 29 22:14:50 2008 GMT przemek Experimental$ 
*=================================================================
*/
<%@include file = "../emxUICommonAppNoDocTypeInclude.inc"%>
<%@include file = "emxMEPCommonInclude.inc"%>

<%@ page import="com.matrixone.apps.domain.util.MqlUtil"%>

<%!
//[Google Custom]: MEP Name validation(30836149) - Modified by Shajil on 20/03/2018 - Starts
	public String getPageInfo(Context context,String pageName,String keyName){
		Map<String, String> pageInfo = new HashMap<String, String>();
		String MQLResult = "";
		try{
		MQLResult = MqlUtil.mqlCommand(context, "print page " + pageName
				+ " select content dump");
		byte[] bytes = MQLResult.getBytes("UTF-8");
		InputStream input = new ByteArrayInputStream(bytes);
		Properties properties = new Properties();
		properties.load(input);
		if (properties.keySet() != null) {
			Iterator keyTypeSymbolicNames = properties.keySet().iterator();
			while (keyTypeSymbolicNames.hasNext()) {
				String keyType = (String) keyTypeSymbolicNames.next();
				pageInfo.put(keyType, properties.getProperty(keyType));
				
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInfo.get(keyName);
	}
//[Google Custom]: MEP Name validation(30836149) - Modified by Shajil on 20/03/2018 - Ends
%>
<% 
String strDecimalSymb = Character.toString(PersonUtil.getDecimalSymbol(context));

StringList selectList = new StringList(2);
selectList.addElement(DomainObject.SELECT_NAME);
selectList.addElement(DomainObject.SELECT_ID);
com.matrixone.apps.common.Person contextPerson = com.matrixone.apps.common.Person.getPerson(context);
Company contextComp = contextPerson.getCompany(context);
Map compMap = contextComp.getInfo(context, selectList);
String defaultLocation      = (String) compMap.get(DomainObject.SELECT_NAME);
String defaultLocationId    = (String) compMap.get(DomainObject.SELECT_ID);
//[Google Custom]: MEP Name validation(30836149) - Modified by Shajil on 20/03/2018 - Starts
String emxNameBadChars = getPageInfo(context,"googCustomValidation","emxFramework.Javascript.MEP.NameBadChars");
//[Google Custom]: MEP Name validation(30836149) - Modified by Shajil on 20/03/2018 - Ends

%>

function commaToDecimalSeparator(value) {
    
    if (value && value.indexOf(",") != -1 ) {
    	return value.replace(",", ".");
    }
    return value;
    
}

//Checking for Positive Real value of the field
function checkPositiveReal(fieldname)
{

    var fieldname = "";
    if(!fieldname) {
        fieldname=this;
    }

    var value = fieldname.value ;
    //XSSOK     
    if("<%=strDecimalSymb%>" == ","){
         value = commaToDecimalSeparator(fieldname.value);
    }

    if( isNaN(value) || value < 0 )
    {
        
        alert("<emxUtil:i18nScript localize='i18nId'>emxManufacturerEquivalentPart.Alert.checkPositiveNumeric</emxUtil:i18nScript>");
        fieldname.focus();
        return false;
    }
    return true;
}



function ManufacturerChangeEvent() {
    
    var createForm = document.forms['emxCreateForm'];
  
    var manufacturer    = createForm.elements["ManufacturerDisplay"];  
    //var mflocOID        = createForm.elements["ManufacturerLocationOID"];
   // var mflocDisp       = createForm.elements["ManufacturerLocationDisplay"];
   // var mfloc           = createForm.elements["ManufacturerLocation"];
    var revDisp         = createForm.elements["Revision"];
    var revHidden       = createForm.elements["rev"];
    //Modified for build 2 Changes by Preethi Rajaraman -- Starts
    //var btnMfgLoc       = createForm.elements["btnManufacturerLocation"];
	//Modified for build 2 Changes by Preethi Rajaraman -- Ends
    var btnUsgLoc       = createForm.elements["btnUsageLocation"];
    
    if(manufacturer.value == '') 
    {
       // mflocOID.value      = '';
       // mflocDisp.value     = '';
      //  mfloc.value         = '';
        revDisp.value       = 'Unknown';
        revHidden.value     ='Unknown';
        //Modified for build 2 Changes by Preethi Rajaraman -- Starts
        //btnMfgLoc.disabled  = true;
		//Modified for build 2 Changes by Preethi Rajaraman -- Ends
        btnUsgLoc.disabled  = true;
    } else {
		//Modified for build 2 Changes by Preethi Rajaraman -- Starts
        //btnMfgLoc.disabled = false;
		//Modified for build 2 Changes by Preethi Rajaraman -- Ends
        btnUsgLoc.disabled = false;
    }  
              
    return true;
}

function ManufacturerLocationValidate() {
  
    var createForm      = document.forms['emxCreateForm'];
    var manufacturer    = createForm.elements["ManufacturerDisplay"];
	//Modified for build 2 Changes by Preethi Rajaraman -- Starts
    //var mflocOID        = createForm.elements["ManufacturerLocationOID"];
    //var mflocDisp       = createForm.elements["ManufacturerLocationDisplay"];
    //var mfloc           = createForm.elements["ManufacturerLocation"];
    //Modified for build 2 Changes by Preethi Rajaraman -- Ends
    
    if(manufacturer.value == '') 
    {
        alert("<emxUtil:i18nScript localize='i18nId'>emxManufacturerEquivalentPart.Alert.MfgSelectionMsg</emxUtil:i18nScript>");
        manufacturer.focus();
        return false;
    }   
        return true;
}


function preProcessInCreateMEPPart() {
	   if(document.forms[0].MEPTitle){
          document.getElementById("MEPTitle").readOnly = true;
       } 
	   document.emxCreateForm.btnUsageLocation.disabled = true;
	  //Modified for build 2 Changes by Preethi Rajaraman -- Starts
     //disableMFGLocationOnLoad(true);   
	//Modified for build 2 Changes by Preethi Rajaraman -- Ends
      defaultLocationName();
      reloadUOMField();
}

function disableMFGLocationOnLoad() {
    document.emxCreateForm.btnManufacturerLocation.disabled = true;
}

function defaultLocationName() {
	//XSSOK
    document.emxCreateForm.UsageLocationOID.value = "<%=defaultLocationId%>";
    //XSSOK
    document.emxCreateForm.UsageLocationDisplay.value = "<%=defaultLocation%>";
    //XSSOK
    document.emxCreateForm.UsageLocation.value = "<%=defaultLocationId%>";
}
//UOM Management - start
function reloadUOMField(){
    emxFormReloadField("UOM");
}

function validateUOMField()
{
	var UOMVal = document.emxCreateForm.UOM;
	if(UOMVal)
		return true;
	else
	{
		alert("Unit of Measure cannot be empty. Choose a valid Unit of Measure Type and Unit of Measure");
		return false;
	}
}
function preProcessInCreateMPN(){
	var createForm      = document.forms['emxCreateForm'];
	reloadUOMField();
}
//UOM Management - End

//This function sets the flag value and calls for updating Specification Title field.
function setMEPTitleFlag() {  
    bMEPTitleFlag="true";
    var txtMEPTitle = document.getElementById("VPMProductName1").value;

    if (txtMEPTitle == "") {
        bMEPTitleFlag="false";
    } 
    else if (txtMEPTitle != "")
    {
        //Check for Bad Name Chars
        var strInvalidChars = checkStringForChars(txtMEPTitle, ARR_NAME_BAD_CHARS, false);
        if(strInvalidChars.length > 0)
        {
            var strAlert = "<emxUtil:i18nScript localize='i18nId'>emxEngineeringCentral.Alert.InvalidChars</emxUtil:i18nScript>"+strInvalidChars;
            alert(strAlert);
            document.getElementById("VPMProductName1").value ='';
            bMEPTitleFlag="false";
            return false;
        }
    } 
    else 
    {
        return true; 
    }
    updateMEPTitle();
    return true;
}

var bMEPTitleFlag;
function updateMEPTitle() {
    var txtMEPTitle = document.getElementById("VPMProductName1").value;
    var strFieldValue =document.forms[0].Name.value;
    
    //Check for Bad Name Chars
    var strInvalidChars = checkStringForChars(strFieldValue, ARR_NAME_BAD_CHARS, false);
    if(strInvalidChars.length > 0) {
         var strAlert = "<emxUtil:i18nScript localize='i18nId'>emxEngineeringCentral.Alert.InvalidChars</emxUtil:i18nScript>"+strInvalidChars;
         alert(strAlert);
         document.forms[0].Name.value ='';
         return false;
    }
  
    if (txtMEPTitle == "" || bMEPTitleFlag!="true") {
        document.getElementById("VPMProductName1").value = strFieldValue;
    }
    return true;
}

//[Google Custom]: MEP Name validation(30836149) - Modified by Shajil on 06/03/2018 - Starts
function validateMEPName(){
	
	var mepName = this.value;
	var badChar = "<%=emxNameBadChars%>";
	var badCharNames = "";
	badCharNames = badChar.split(" ");
	var retVal = checkStringForChars(mepName,badCharNames,false);
	retVal = retVal.trim();
	if (retVal.length != 0) {
             alert("<emxUtil:i18nScript localize="i18nId">emxManufacturerEquivalentPart.Common.InvalidName</emxUtil:i18nScript>"+retVal+"<emxUtil:i18nScript localize="i18nId">emxManufacturerEquivalentPart.Common.AlertRemoveInValidChars</emxUtil:i18nScript>");
             return;
         }
		 
	     return true;
}
//[Google Custom]: MEP Name validation(30836149) - Modified by Shajil on 06/03/2018 - Ends
//Added by Sourav for the MEP Comma Issue Starts here
function populateTitleField(){
	
	 var mepName = this.value;
	 var newMEPName = mepName;
	 var nameMEP = newMEPName.replace(",", "");
	  if(document.forms[0].MEPTitle){
           document.getElementById("Name").value = nameMEP;
		   document.getElementById("MEPTitle").value = mepName;
        } 
	 return true;
}
//Added by Sourav for the MEP Comma Issue Ends here