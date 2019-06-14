#!/bin/bash

#VARIABLES TO CHANGE
SVCACCOUNT=nameofjamfaccount
COMPANY=acme
SVCPASSWORD=lolplaintext
MOJAVE=153
HIGHSIERRA=154
SIERRA=155
EOL=156

#get record from advancedsearch API endpoint
mojavesearch=$(curl https://$COMPANY.jamfcloud.com/JSSResource/advancedcomputersearches/id/$MOJAVE --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
mojavenum=$(echo $mojavesearch | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')
echo $mojavenum > flatfiledb/mojave.txt

#get record from advancedsearch API endpoint
highsierrasearch=$(curl https://$COMPANY.jamfcloud.com/JSSResource/advancedcomputersearches/id/$HIGHSIERRA --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
highsierranum=$(echo $highsierrasearch | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')
echo $highsierranum > flatfiledb/highsierra.txt

#get record from advancedsearch API endpoint
sierra=$(curl https://$COMPANY.jamfcloud.com/JSSResource/advancedcomputersearches/id/$SIERRA --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
sierranum=$(echo $sierra | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')
echo $sierranum > flatfiledb/sierra.txt

#get record from advancedsearch API endpoint
eolsearch=$(curl https://$COMPANY.jamfcloud.com/JSSResource/advancedcomputersearches/id/$EOL --user $SVCACCOUNT:$SVCPASSWORD)
#parse out total quantity
eolnum=$(echo $eolsearch | xpath '//computers' 2>&1| awk -F'<size>|</size>' '{print $2}')
echo $eolnum > flatfiledb/eol.txt