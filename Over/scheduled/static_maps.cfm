<cfexecute name="C:\Program Files (x86)\phantomjs-2.1.1\bin\phantomjs.exe"
			arguments="--debug=true C:\Apache24\htdocs\motioninfo.net\overflights\scheduled\renderer.js 97462"
			timeout="30"
			variable="test"
			errorVariable="err">
</cfexecute>

<cfdump var=#variables#>