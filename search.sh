#!/bin/bash

#Variables
SVCACCOUNT=svc_read
COMPANY=acme
SVCPASSWORD=lolplaintext
MOJAVE=153
HIGHSIERRA=154
SIERRA=155
EOL=156

#get record from advancedsearch API endpoint
mojavesearch=$(curl https://$COMPANY.jamfcloud.com/advancedcomputersearches/id/$MOJAVE --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
compid=$(echo $mojavesearch | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')

#get record from advancedsearch API endpoint
highsierrasearch=$(curl https://$COMPANY.jamfcloud.com/advancedcomputersearches/id/$HIGHSIERRA --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
compid=$(echo $highsierrasearch | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')

#get record from advancedsearch API endpoint
sierra=$(curl https://$COMPANY.jamfcloud.com/advancedcomputersearches/id/$SIERRA --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
compid=$(echo $sierra | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')

#get record from advancedsearch API endpoint
eolsearch=$(curl https://$COMPANY.jamfcloud.com/advancedcomputersearches/id/$EOL --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
compid=$(echo $eolsearch | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')