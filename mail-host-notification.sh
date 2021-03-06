#!/bin/sh
# shyamjos.com (2017)

if [ "$HOSTSTATE" = "DOWN" ]
then
        color=#FF5566

#elif [ "$HOSTSTATE" = "UP" ]
#then
else
        color=#44BB77

fi



template=`cat <<TEMPLATE
<!DOCTYPE html>
<html>
<head>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #1bd0b2;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #fffff;
}
</style>
</head>
<body>

<table>
<th colspan=2 bgcolor=#17B294><center>Icinga Server Monitoring</center></th>

<tr>
<td>Notification Type</td>
<td>$NOTIFICATIONTYPE</td>
</tr>
<tr>
<td>Host</td>
<td>$HOSTALIAS</td>
</tr>



<tr>
<td>IP Address</td>
<td>$HOSTADDRESS</td>
</tr>

<tr>
<td>State </td>
<td bgcolor=$color><b>$HOSTSTATE</b></td>
</tr>

<tr>
<td>Date/Time</td>
<td>$LONGDATETIME</td>
</tr>


<tr>
<td>Additional Info</td>
<td>$HOSTOUTPUT</td>
</tr>

<tr>
<td>Comment</td>
<td>[$NOTIFICATIONAUTHORNAME] : $NOTIFICATIONCOMMENT</td>
</tr>

<tr>
<td>Alert History</td>
<td><a  target="_blank"  href="http://192.168.60.1/icingaweb2/dashboard#!/icingaweb2/monitoring/host/history?host=$HOSTALIAS"> Open Dashboard </a></td>
</tr>
</table>

</body>
</html>
TEMPLATE
`
#Do not remove -e 'my_hdr From:', This is used for setting 'from' address in mutt

/usr/bin/printf "%b" "$template" | mutt -e "set content_type=text/html" -e 'my_hdr From:Icinga Alert <icinga-alerts@example.com>' -s "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME is $HOSTSTATE" $USEREMAIL
