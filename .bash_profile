alias ll='ls -al'
alias sourcekitsad='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias refresh_bash_profile='source ~/.bash_profile'	

export LC_ALL="en_US.UTF-8"
export CLICOLOR=1
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin"
export JAVA_HOME=$(/usr/libexec/java_home)

# Refresh last chrome tab
refresh_current_chrome_tab() {
	osascript -e '
		tell application "Google Chrome"
		  activate
		  delay 1
		  tell application "System Events"
		    tell process "Google Chrome"
		      keystroke "r" using {command down, shift down}
		    end tell
		  end tell
		end tell
		 
		tell application "terminal" to activate
	'
}
export -f refresh_current_chrome_tab



# Start an HTTP server from a directory, optionally specifying the port
function server(){
	local port="${1:-8001}"
	#open "http://macsmbpr.local:${port}/"
	open -a "/Applications/Google Chrome.app" "http://macsmbpr.local:${port}/"
	python -m SimpleHTTPServer "$port"
}
export -f server





####### WATCHER ####
# Create a new watch.sh file and run it on the folder you want to monitor
######################
#!/bin/bash
 
 
# function execute_me_on_file_changes {
   
#     echo -e "file changed"

#     cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/hypertv/login.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/hypertv/login.js"
#     curl -s "http://macsmbpr.local:8080/htx/rest/restricted/clearcaches" > /dev/null

#     refresh_current_chrome_tab
    
#     echo -e " --> action on file changes completed " $(date | awk '{print $4}') "\n"
# }
# export -f execute_me_on_file_changes

# fswatch -o -0 . | xargs -0 -n 1 -I {} bash -c 'execute_me_on_file_changes'   




