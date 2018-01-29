#!/bin/bash

#Checks to see what the current route to 192.168.9.14 is. This host is reachable only via the primary circuit.
CURR_ROUTE=`/sbin/route -n | grep 192.168.9.14 | awk '{print $2}'`

# Pings to check for response. This host is reachable only via the primary circuit.
/bin/ping -c 5 192.168.9.14 >& /dev/null

# If the above IP does NOT respond to ping, this implies that the primary circuit is down, therefore change the route to 12.12.12.20
if [ $? -ne 0 ]
then
# failure of ping
if [ "$CURR_ROUTE" != "12.12.12.20" ]; then
echo "-------------------------------------------------------------------" >> /var/log/routetest.log	
echo "Circuit logging process started at:" >> /var/log/routetest.log
getdate >> /var/log/bbg_routetest.log
echo "Link Failed..." >> /var/log/routetest.log
echo "Changing route to 12.12.12.20" >> /var/log/routetest.log
echo "-------------------------------------------------------------------" >> /var/log/routetest.log
clish -c "set config-lock on override" >& /dev/null
clish -c "set static-route 192.168.9.0/24 nexthop gateway address 11.11.11.21 off" >& /dev/null
clish -c "set static-route 192.168.9.0/24 nexthop gateway address 12.12.12.20 on" >& /dev/null
clish -c "set config-lock off" >& /dev/null
fi

# Otherwise, one the ping starts to reply again, revert the routes so that it once again routes via 11.11.11.21
else
if [ "$CURR_ROUTE" != "11.11.11.21" ]; then
echo "-------------------------------------------------------------------" >> /var/log/routetest.log	
echo "Circuit logging process started at:" >> /var/log/routetest.log
getdate >> /var/log/routetest.log
echo "Link Recovered..." >> /var/log/routetest.log
echo "Changing route to 11.11.11.21" >> /var/log/routetest.log
echo "-------------------------------------------------------------------" >> /var/log/routetest.log
clish -c "set config-lock on override" >& /dev/null
clish -c "set static-route 192.168.9.0/24 nexthop gateway address 12.12.12.20 off" >& /dev/null
clish -c "set static-route 192.168.9.0/24 nexthop gateway address 11.11.11.21 on" >& /dev/null
clish -c "set config-lock off" >& /dev/null
fi
fi
