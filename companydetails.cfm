<cfabort>
<cfparam name="companyid" type="integer">


<cfquery datasource="directory" name=company>
Select * from company 
where companyid = #companyid#
</cfquery>

<cfquery datasource="Directory" name=segcat>
Select *
FROM SEGCAT inner join taxonomy on segcatid = id
Where companyid = '#companyid#'
</cfquery>
<cfset CATEGORYLIST = (SEGCAT.Category)>

<HTML>
<HEAD>
<TITLE><cfoutput>#company.companyname# - MGN Business Card Listing</TITLE>
<meta http-equiv="Description" name="Description" content="#company.shortdescription#">
<meta http-equiv="Keywords" name="Keywords" content="#company.COMPANYNAME#,#categorylist#,#company.keywords#">
</cfoutput>
</HEAD>
<cfinclude template="header.cfm">


<!---- USE COMPANYID if it exists, if not, use path_info --->
<cfif #parameterexists(url.companyid)# is "NO">

   <cfif parameterexists(cgi.script_name) is "YES">
  <cfset COMPANYID = #right(cgi.script_name, len(cgi.script_name)-20)#>
   </cfif>
</cfif>
<!----
<cfquery datasource=directory name=log>
insert into log(companyid,ipaddress,browser,area,bc)values(0,'#cgi.remote_addr#','#cgi.http_user_agent#',15,#companyid#)
</cfquery>
---->
<cfquery datasource="directory" name=JOBS>
Select * from jobs
where companyid = #companyid#
and display = 1
and date > getdate()-90
order by date desc
</cfquery>


<cfquery datasource="directory" name=pressreleases>
Select * from newsrelease
where companyid = #companyid#
order by begindate desc
</cfquery>



<cfquery datasource=directory name=agents>
Select * from port_related
where company_id = #companyid#
</cfquery>



<cfquery datasource="directory" name=contacts maxrows=100>
Select * from contacts
where companyid = #companyid#
and last is not null

order by sortorder
</cfquery>


<cfquery datasource="Directory" name=bbp maxrows=25>
Select *
FROM bbhistory Where companyid = #companyid#
order by entrydate desc
</cfquery><br>





<cfif company.portid is not "">
<cfquery datasource="directory" name="ports">
Select * from ports
where ID = #company.portid#
</cfquery>
</cfif>

<cfset companyemail = '#company.email#'>
<cfset broker="#company.broker#">
<cfset port_agent=#company.port_agent#>
<cfset trainingcenter=''>
<cfset freightrfq="#company.freightrfq#">
<cfset freightemail='Nada'>
<cfset portid = "#company.portid#">
<!----

---->
<body bgcolor="white" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">




<table border=0><tr><td valign=top>


<h3>COMPANY DETAILS:</h3>
<table border=0 width=468><tr><td valign=top>


<cfoutput query="contacts">
	<cfset listdate = "#company.listdate#">
	<cfset email='#email#'>
	<cfset bunkersupplier='#company.BunkerSupplier#'>
</cfoutput>

<cfoutput>
<cfif cgi.remote_addr CONTAINS '65.209.' or cgi.remote_addr CONTAINS '64.17.245.'>
<cfif cgi.remote_addr is not '65.209.124.156' or cgi.remote_addr is not '192.168.1.156' or cgi.remote_addr is not '192.168.1.159' >
<font size="-1"><a href=admin/directory/companyindex.cfm?companyid=#companyid#>UPDATE LISTING</a></font>
</cfif>
</cfif>
</cfoutput>
<cfif parameterexists(type) is "no">

<cfoutput query=company>
<div align="center"><cfif logo is not ""><img border="0" src="logos/#logo#"></a></cfif></div>





<font size="-1" face=arial>
<table bgcolor="blue" border=1 cellpadding=0 cellspacing=1 width=100%><tr><td>
<table width="100%" border="0" bgcolor=white>
<tr><td colspan=3 bgcolor=silver><font face=arial size="+2">
<b>#companyname#</b>
</td></tr>
<tr>
<td valign=top>


<font size="-1" face="arial">
<cfif address is not "">#address#<br></cfif>
#city# #state# #zip# <br>#country#<br>
<P>


</td>
<td>&nbsp;</td>
<td valign=top align=right>
<table border=0 cellpadding=0 cellspacing=0 bgcolor=white>
<tr>
<td>
<cfif email is not " ">
<cfif email is not "">
<table>
<tr>
<td>
<a HREF="" onClick="window.open('/message.cfm?companyid=#companyid#', 'RIC','width=400,height=523,resizable=yes');return false;">
<img src="images/e_mail.jpg" border=0></a>
</td>
<td><font size="-1" face=arial>
Company<br> Email<br> 
</td>
</tr>
</table>
</cfif>
</cfif>
</td>
<td>
<cfif phone is not "">
<table>
<tr>
<td>
<img src="images/phone.gif">
</td>
<td valign=middle><font size="-1" face=arial>
 #phone#
</td>
</tr>
</table>
</cfif>
</td>
</tr>

<tr>
<td>
<cfif Url is not "">
<table>
<tr>
<td>
<a href="web.cfm?companyid=#companyid#" target="_new">
<img src="images/web_address.gif" border=0></a>

</td>
<td><font size="-1" face=arial>
Web<br>Site<br> 
</td>
</tr>
</table>
</cfif>

</td>
<td>
<cfif fax is not "">
<table>
<tr>
<td>
<img src="images/fax.gif">
</td>
<td valign=middle><font size="-1" face=arial>
#fax#
</td>
</tr>
</table>
</cfif>
</td>
</tr>
</table>




</td></tr><tr>
<td colspan=3 align=left>

<cfif contacturl is not "">Contact URL: <a href="#contacturl#"><font size="-1">#contacturl#</font></a> <br></cfif>



<P>

<cfif office2 is not "">
<P>
<b>Additional offices:</b><br>
#office2#
</cfif>

<P>
<cfset listdate = #listdate#>
</cfoutput>






</FONT>


<br><br>

<!----
<font size=-1>
<B>Contacts:</B><br><br>

<font size=-1>


<cfoutput query="contacts">
<cfif full_Name is "">   </cfif>
	<cfif last is not "">
	<li>#first# #middle# #last# 
		<cfif title is not "">- #title#</cfif>
		<cfif email is not ""> <a HREF="" onClick="window.open('/message.cfm?companyid=#companyid#&contactid=#contactid#', 'RIC','width=400,height=523,resizable=yes');return false;"><img src=images/email.gif border=0></a></cfif>



<cfelse>

<li>#first# #last# 
		<cfif title is not "">- #title#</cfif>
</cfif>

</cfoutput>

<br><br>
	
--->





<font size=-1>
		<B>Segments & Categories:</B><br>
<cfif #segcat.recordcount# gt 0>
		<ol>
		<cfoutput query=segcat>

	<cfset segment = #segment#>	
	<cfset category = #category#>	<FONT SIZE="-1">
		<li>#category#
		</cfoutput></FONT>
		</ol>
		</FONT>
</cfif>

<cfif portid is not "">
<cfoutput>
		View Port,Terminal,and Berth details for the <a href="worldports/portdetails.cfm?ports__Id=#ports.id#">Port of #ports.port_name#</a>
		</cfoutput>
		</cfif>
		
		<P></p>

<cfoutput query=company maxrows=1>


<font size=-1>
	<B>Short Description:</B><br>
	<cfif shortdescription is not "">

	<TABLE><tr><TD><FONT SIZE="-1" face=arial>
	<p>
	#paragraphformat(shortdescription)#</FONT>
	</p>
	</TD></TR></TABLE>
	</cfif>
		<B>Detailed Description:</B><br>
	<cfif detaileddescription is not "">

	<TABLE><tr><TD><P><FONT SIZE="-1" face=arial><p>
	#paragraphformat(detaileddescription)#	</p></TD></TR></TABLE>
	</cfif>
	
	<cfif stocksymbol is not "">
	<br><b>Stock Symbol:</b> <a href="stocks/graph.cfm?symbol=#stocksymbol#">#stocksymbol#</a><br>
	</cfif>
	
		
	


	</cfoutput>
	</cfif>

  
<cfif parameterexists(type) is "YES">
<CFSET TYPE=1>
</cfif>
<cfif parameterexists(trainingcenter) is "YES">

</cfif>
<cfif parameterexists(port_agent) is "YES">
<cfif port_agent is "YES">
<cfoutput>
<b>Ports covered:</b> #agents.recordcount#
<cfloop query=agents>

<cfquery datasource=directory name=pn>
select port_name from ports
where id = #agents.port_id#
</cfquery>

<li>#pn.port_name#
</cfloop>
</cfoutput>

</cfif>
</cfif>

<P>

<font size=-1>
	<B>Press Releases:</B><br>
<cfif pressreleases.recordcount gt 0>

<cfoutput query=pressreleases maxrows=10 group=title>
<li>#dateformat(begindate,'d/m/yy')# - <a href="/news/newsreleasedetails.cfm?id=#id#&type=0">#title#</a>
</cfoutput>

</cfif>

<cfif bbp.recordcount gt 0>
<cfinclude template="bunkers/bbprices.cfm">

</cfif>
<P><font size=-1>
	<B>Employment Opportunities:</B><br>
<cfif jobs.recordcount gt 0>
	
<cfoutput query=jobs>
<li><a href="/careercenter/bulletinboard_detail.cfm?ID=#id#">#title#</a> - #dateformat(date,'mm/dd/yyyy')#
</cfoutput>

</cfif>

<P>
<cfoutput>
<font size=-1>
Last update: #dateformat(company.updatedate,'mmmm d, yyyy')#</font> 
</cfoutput>
<P>
</td></tr></table>
</td>
</tr></table>
</td></tr></table>

<a href="javascript:history.go(-1)"><img src="/images/goback.gif" border=0></a><P>


</td><td>&nbsp;&nbsp;</td>

<td valign=top></td></tr></table>


<cfif parameterexists(type) is "NO">
<cfinclude template="footer.cfm">
</cfif>





