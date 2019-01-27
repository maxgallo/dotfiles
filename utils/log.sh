colorBlack='\033[0;30m'
colorRed='\033[0;31m'
colorGreen='\033[0;32m'
colorYellow='\033[0;33m'
colorCyan='\033[0;36m'
colorNormal='\033[0m' # No Color

colorBgNormal='\033[49m'
colorBgCyan='\033[46m'
colorBgBlue='\033[44m'
colorBgYellow='\033[43m'

weightBold=$(tput bold)
weightNormal=$(tput sgr0)

function logStep {
    local stepTitle=$1
    echo ""
    echo -e $colorBlack $colorBgYellow $weightBold \>\>\>\> $colorNormal $colorBgNormal $weightBold $stepTitle $weightNormal  
    echo ""
}

export -f logStep