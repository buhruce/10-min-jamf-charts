#!/bin/bash

#Variables
SVCACCOUNT=svc_read
COMPANY=acme
SVCPASSWORD=lolplaintext
MOJAVE=153
HIGHSIERRA=154

#get record from advancedsearch API endpoint
complist=$(curl https://$COMPANY.jamfcloud.com/advancedcomputersearches/id/$MOJAVE --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
compid=$(echo $complist | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')