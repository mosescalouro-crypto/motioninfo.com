<cfset returnArray = ArrayNew(1) />

<cfquery name="users" dataSource="#application.datasource#">
    SELECT TOP 20 * from users
    WHERE (<cfif len(url.term)>
            reg like <cfqueryparam value="%#URL.term#%" cfsqltype="cf_sql_varchar">
            OR name like <cfqueryparam value="%#URL.term#%" cfsqltype="cf_sql_varchar">
        </cfif>)
    ORDER BY name ASC
</cfquery>

<cfloop query="users">
<cfoutput>
    <cfset resultStruct = StructNew() />
    <cfset resultStruct["reg"] = reg />
    <cfset resultStruct["name"] = name />
    <cfset resultStruct["email"] = email />
    <cfset resultStruct["phone"] = phone />
    <cfset resultStruct["pin"] = pin />
    <cfset resultStruct["user_id"] = id />
</cfoutput>
<cfset ArrayAppend(returnArray,resultStruct) />
</cfloop>

<cfoutput>
#serializeJSON(returnArray)#
</cfoutput>