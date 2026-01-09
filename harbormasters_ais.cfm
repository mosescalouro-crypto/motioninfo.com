<cfquery datasource='USCG_PATON' name='users'>
select * from  uscg_paton.dbo.users
where acl='HM'
and lastlogin > getdate()-1500
and id not in (18659,6959,155,19909,50,52,5939,467)
order by StateOrProvince,city
</cfquery>

<!------->
<cfmail to='mjc@mgn.com' from='mjc@mgn.com' subject='Vessel Tracking / Equipment Hosting - #companyname#' query='users'>

Hi #First_Name#,

Our company is expanding it's coverage of AIS equipped vessels and we would like to place equipment at your location(s). 

The equipment consists of 2 foot antennas (roof mounted), 50 foot lengths of cable,  radio/internet boxes, power and computer cables.

At no cost, in exchange for hosting our equipment, you would have access to our current web based live display.

Would you be able to host our equipment?

Best regards, 
Moses Calouro
Maritime Information Systems, Inc.
http://www.maritimeinfosystems.com
Tel:  +1 401-247-7780
Cel: + 1 401-255-4045
</cfmail>
