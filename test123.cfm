<cfset directory=#dateformat(now(),'YYYYMMDD')#>
<CFIF DirectoryExists('c:\inetpub\wwwroot\virtual\motioninfo\kml\#directory#\')>
  Directory exists!
<CFELSE>
  Directory doesn't exist!
</CFIF>
