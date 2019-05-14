#!/bin/sh
#found on https://github.com/pbowden-msft, thanks Paul!

# Functions
function DetectVolumeLicense {
	VOLUMELICENSE="/Library/Preferences/com.microsoft.office.licensingV2.plist"
	
	# checks to see if a volume license file is present
	if [ -f "$VOLUMELICENSE" ]; then
		/bin/echo "Yes"
	else
		/bin/echo "No"
	fi
}

function DetectO365License {
	# creates a list of local usernames with UIDs above 500 (not hidden)
	userList=$( /usr/bin/dscl /Local/Default -list /Users uid | /usr/bin/awk '$2 >= 501 { print $1 }' )
	
	while IFS= read aUser
	do
		# get the user's home folder path
		homePath=$( eval /bin/echo ~$aUser )
	
		# list of potential Office 365 activation files
		O365SUBMAIN="$homePath/Library/Group Containers/UBF8T346G9.Office/com.microsoft.Office365.plist"
		O365SUBBAK1="$homePath/Library/Group Containers/UBF8T346G9.Office/com.microsoft.e0E2OUQxNUY1LTAxOUQtNDQwNS04QkJELTAxQTI5M0JBOTk4O.plist"
		O365SUBBAK2="$homePath/Library/Group Containers/UBF8T346G9.Office/e0E2OUQxNUY1LTAxOUQtNDQwNS04QkJELTAxQTI5M0JBOTk4O" # hidden file
	
		# checks to see if an O365 subscription license file is present for each user
		if [[ -f "$O365SUBMAIN" || -f "$O365SUBBAK1" || -f "$O365SUBBAK2" ]]; then
			activations=$((activations+1))
		fi
	done <<< "$userList"
	
	# returns the number of activations to O365ACTIVATIONS
	/bin/echo $activations
}

## Main

VLPRESENT=$(DetectVolumeLicense)
O365ACTIVATIONS=$(DetectO365License)

if [ "$VLPRESENT" == "Yes" ] && [ "$O365ACTIVATIONS" ]; then
	/bin/echo "<result>Volume and Office 365 licenses detected. Only the volume license will be used.</result>"

elif [ "$VLPRESENT" == "Yes" ]; then
	/bin/echo "<result>Volume license</result>"
	
elif [ "$O365ACTIVATIONS" ]; then
	/bin/echo "<result>Office 365 activations: $O365ACTIVATIONS</result>"
	
elif [ "$VLPRESENT" == "No" ] && [ ! "$O365ACTIVATIONS" ]; then
	/bin/echo "<result>No licenses</result>"
fi

exit 0