alias ll='ls -al'
alias sourcekitsad='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias refresh_bash_profile='source ~/.bash_profile'	
alias clear='printf "\033c"'
alias edbash='sublime ~.bash_profile'


#HTV alias
alias hypertv='/usr/local/hypertv.sh'
alias edprop='sublime /usr/local/liferay-portal-5.2.3/portal-ext.properties'



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
	open -a "/Applications/Google Chrome.app" "http://macs.local:${port}/"
	python -m SimpleHTTPServer "$port"
}
export -f server




 
####### WATCHER start ####
function execute_me_on_file_changes {
   
    echo -e "file changed"


    #cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/bootstrap/js/ui-bootstrap-tpls-0.12.1.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/bootstrap/js/ui-bootstrap-tpls-0.12.1.js"
    #cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/hypertv/gaming.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/hypertv/gaming.js"
    

    
    # cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/css/hypertv/hypertv.css" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/css/hypertv/hypertv.css"
    # cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/hypertv/hypertv.utils.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/hypertv/hypertv.utils.js"
    # cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/hypertv/login.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/hypertv/login.js"
    # cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/hypertv/gaming.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/hypertv/gaming.js"
    # cp "/Users/macs/HyperTVx/EclipseWorkspace/htbackend/ext-web/docroot/html/js/hypertv/notification.js" "/usr/local/liferay-portal-5.2.3/tomcat/webapps/ROOT/html/js/hypertv/notification.js"
    
    # curl -s "http://macsmbpr.local:8080/htx/rest/restricted/clearcaches" > /dev/null

    refresh_current_chrome_tab
    
    echo -e " --> action on file changes completed " $(date | awk '{print $4}') "\n"
}
export -f execute_me_on_file_changes


function watchfolder {
	FOLDER=$1
	if [ -z "$FOLDER" ]; then
		echo "No folder specified, using current"
		FOLDER='.'
	fi 

	fswatch -o -0 $FOLDER | xargs -0 -n 1 -I {} bash -c 'execute_me_on_file_changes'  
}

export -f watchfolder
####### WATCHER end ####







