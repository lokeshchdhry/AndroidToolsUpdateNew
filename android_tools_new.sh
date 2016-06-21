#!/bin/bash

function check_SDK_tools_update(){
	a=$(android list sdk| grep 'Android SDK Tools'|cut -c34-)
	# echo $a
	if [ "$a" != '' ]; then
		echo $(date) "---> New Android SDK Tools Update Ver.$a Avaliable"
		osascript -e 'display notification "New Android SDK Tools avaliable :'"$a"'" with title "New Android SDK Tools avaliable"'
	else
		echo $(date) "---> No New Android SDK Tools Update Avaliable"
		osascript -e 'display notification "No New Android SDK Tools avaliable" with title "No New Android SDK Tools avaliable"'
	fi
}

function check_SDK_build_tools(){
	b=$(android list sdk| grep 'Android SDK Build-tools'|cut -c40-)
	# echo $b
	if [ "$b" != '' ]; then
		echo $(date) "---> New Android SDK Tools Update Ver.$b Avaliable"
		osascript -e 'display notification "New Android SDK Build Tools avaliable :'"$b"'" with title "New Android SDK Build Tools avaliable"'
	else
		echo $(date) "---> No New Android SDK Build Tools Update Avaliable"
		osascript -e 'display notification "No New Android SDK Build Tools avaliable" with title "No New Android SDK Build Tools avaliable"'
	fi
}

function check_android_platform(){
	c=$(android list sdk| grep 'SDK Platform Android'|cut -c28-)
	# echo $c
	if [ "$c" != '' ]; then
		echo $(date) "---> New Android Platform Update Ver.$c Avaliable"
		osascript -e 'display notification "New Android Platform avaliable :'"$c"'" with title "New Android Platform avaliable"'
	else
		echo $(date) "---> No New Android SDK Platform Update Avaliable"
		osascript -e 'display notification "No New Android Platform avaliable" with title "No New Android Platform avaliable"'
	fi
}

installed_NDK(){
  ndk_path="/Users/lokeshchoudhary/Desktop/androidNDK"
  cd $ndk_path
  latest_NDK_installed=$(ls $ndk_path|sort|tail -1|awk -F "android-ndk-" '{print $2}')
  echo $(date) "---> Highest Installed NDK :"$latest_NDK_installed
}

check_avaliable_NDK(){
  installed_NDK
  url="https://developer.android.com/ndk/downloads/index.html#Downloads"
  ava_ndk=$(curl -s $url|grep "android-ndk-r"|awk -F "android-ndk" '{print $2}'|head -1|awk -F '-' '{print $2}')
  echo $(date) "---> Avaliable NDK :"$ava_ndk

  if [ "$latest_NDK_installed" != "$ava_ndk" ]; then
    echo $(date) "---> New NDK Avaliable :"$ava_ndk
    echo
    osascript -e 'display notification "New Android NDK Avaliable :'"$ava_ndk"'" with title "New Android NDK Avaliable"'
  else
    echo $(date) "---> No New Android NDK Avaliable"
    osascript -e 'display notification "No New Android NDK Avaliable" with title "No New Android NDK Avaliable"'
    echo
    #osascript -e 'display notification "No New Android NDK Avaliable" with title "No New Android NDK Avaliable"'
  fi
}

while [ true ]
do
	check_SDK_tools_update
	check_SDK_build_tools
	check_android_platform
	check_avaliable_NDK
  sleep 1800
done


