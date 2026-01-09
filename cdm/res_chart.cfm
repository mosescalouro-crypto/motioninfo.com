<canvas id="chart" height="320"></canvas>

<script type="text/javascript">
var ctx = document.getElementById("chart").getContext("2d");
var data = {
  labels: [<cfoutput><cfloop from="0" to="23" index="h">"#timeFormat(dateAdd("h", h, dateformat(now(),'#application.dateformat#')))#",</cfloop></cfoutput>],
  datasets: [{
      label: "Commercial Departures",
      backgroundColor: "#4365B0",
      borderColor: "#4365B0",
      data: [
      <cfoutput>
        <cfset totals = arrayNew(1)>
        <cfloop from="0" to="23" index="h">
          <cfquery dataSource="OAG" name="flights"> 
              SELECT flightcount FROM flights_hourly
              WHERE ForDate = '#d#'
              and OnHour = #h#
          </cfquery>
          <cfif flights.recordcount>
            <cfset fc = flights.flightcount>
          <cfelse>
            <cfset fc = 0>
          </cfif>
          <cfset totals[evaluate(h+1)] = fc>
          #fc#,
        </cfloop>
      </cfoutput>
      ]
    },
    {
      label: "GA Departures",
      backgroundColor: "#ffd800",
      borderColor: "#ffd800",
      data: [
      <cfoutput>
        <cfloop from="0" to="23" index="h">
          <cfquery dataSource="OAG" name="reservations"> 
              SELECT * FROM reservations_hourly
              WHERE ForDate = '#d#'
              and OnHour = #h#
              ORDER BY ForDate, OnHour
          </cfquery>
          <cfif reservations.recordcount>
            <cfset rc = reservations.flightcount>
          <cfelse>
            <cfset rc = 0>
          </cfif>
          <cfset totals[evaluate(h+1)] = evaluate(totals[evaluate(h+1)] + rc)>
          #rc#,
        </cfloop>
      </cfoutput>
      ]
    },
    {
      label: "Remaining Availability",
      backgroundColor: "#ccc",
      borderColor: "#ccc",
      data: [
      <cfoutput>
        <cfloop from="1" to="24" index="h">
          <cfif evaluate(48 - totals[h]) gt 0>
            #evaluate(48 - totals[h])#, 
          <cfelse>
            0,
          </cfif>
        </cfloop>
      </cfoutput>
      ]
    }]
};

var myBarChart = new Chart(ctx, {
  type: 'bar',
  data: data,
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      xAxes: [{stacked: true}],
      yAxes: [{
        stacked: true,
        ticks: {
          beginAtZero: true
         }
      }]
    },
    onClick: handleClick
  }
});


var resDate = '<cfoutput>#dateFormat(d,"yyyymmdd")#</cfoutput>'
function handleClick(evt)
{
    var activeElement = myBarChart.getElementAtEvent(evt);
    var time = activeElement[0]["_model"]["label"].split(":");
    var hr = time[0];
    var ap = time[1].split(" ");
    var ap = ap[1];

    //$("#resForm input[name='departure']").val(resDate + ' ' + activeElement[0]["_model"]["label"]);
    $("#slotPlaceholder").remove();
    $("#slotButtons").load("../getSlots.cfm?date="+resDate+"&hr="+hr+"&ap="+ap, function() {
      $('[data-toggle="popover"]').popover();
    });
}

</script>