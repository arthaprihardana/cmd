#!/bin/bash
# created by : Artha Prihardana
# email : artha.prihardana@ai.astra.co.id
select_platform() {
    title="Pilih Platform"
    prompt="Silahkan pilih platform:"
    options=("Android" "iOS")
    echo "$title"
    PS3="$prompt "
    select opt in "${options[@]}" "Batal"; do
        case "$REPLY" in

        1 ) android_platform ;;
        2 ) ios_platform ;;

        $(( ${#options[@]}+1 )) ) echo "Keluar Cuuy!!!"; break;;
        *) echo "Ga ada pilihan nya cuy. Pilih 1-3 aja.";continue;;

        esac

    done
}

progress_bar() {
	local PROG_BAR_MAX=${1:-30}
	local PROG_BAR_DELAY=${2:-1}
	local PROG_BAR_TODO=${3:-"."}
	local PROG_BAR_DONE=${4:-"="}
	local i

	echo -en "["
	for i in `seq 1 $PROG_BAR_MAX`
	do
		echo -en "$PROG_BAR_TODO"
	done
	
	echo -en "]\0015["
	for i in `seq 1 $PROG_BAR_MAX`
	do
		echo -en "$PROG_BAR_DONE"
		sleep ${PROG_BAR_DELAY}
	done
	echo
}

ios_platform() {
    title="Pilih Environment"
    prompt="Silahkan pilih environment:"
    options=("Development" "Production" "Production-2")
    echo "$title"
    PS3="$prompt "
    select opt in "${options[@]}" "Kembali"; do
        case "$REPLY" in

        1 ) echo "Silahkan tunggu proses compile iOS";
            yarn deploy-dev > /dev/null 2>&1;
            cd cordova/eApproval/;
            cordova prepare ios > /dev/null 2>&1;
            cd ../..;
            node ./config/version.js && [[ $(git status --porcelain -z | gawk '/version.json/ && /E-Approval-Info.plist/' ) ]] && git add version.json cordova/eApproval/platforms/ios/;
            cd cordova/eApproval/platforms/ios;
            xcodebuild archive -workspace E-Approval.xcworkspace -scheme E-Approval -archivePath ~/Desktop/Athena.xcarchive > /dev/null 2>&1;
            xcodebuild -exportArchive -archivePath ~/Desktop/Athena.xcarchive/ -exportPath ~/Desktop/ -exportOptionsPlist ../../../../ipa-options.plist > /dev/null 2>&1;
            echo "`date` : Build iOS berhasil"
            echo "Lokasi file ipa di ~/Desktop/E-Approval.ipa";
            exit 2;
            break;;
        2 ) echo "Silahkan tunggu proses compile iOS";
            yarn deploy-prd > /dev/null 2>&1;
            cd cordova/eApproval/;
            cordova prepare ios > /dev/null 2>&1;
            cd ../..;
            node ./config/version.js && [[ $(git status --porcelain -z | gawk '/version.json/ && /E-Approval-Info.plist/' ) ]] && git add version.json cordova/eApproval/platforms/ios/;
            cd cordova/eApproval/platforms/ios;
            xcodebuild archive -workspace E-Approval.xcworkspace -scheme E-Approval -archivePath ~/Desktop/Athena.xcarchive > /dev/null 2>&1;
            xcodebuild -exportArchive -archivePath ~/Desktop/Athena.xcarchive/ -exportPath ~/Desktop/ -exportOptionsPlist ../../../../ipa-options.plist > /dev/null 2>&1;
            echo "`date` : Build iOS berhasil"
            echo "Lokasi file ipa di ~/Desktop/E-Approval.ipa";
            exit 2;
            break;;
        3 ) echo "Silahkan tunggu proses compile iOS";
            yarn deploy-prd2 > /dev/null 2>&1;
            cd cordova/eApproval/;
            cordova prepare ios > /dev/null 2>&1;
            cd ../..;
            node ./config/version.js && [[ $(git status --porcelain -z | gawk '/version.json/ && /E-Approval-Info.plist/' ) ]] && git add version.json cordova/eApproval/platforms/ios/;
            cd cordova/eApproval/platforms/ios;
            xcodebuild archive -workspace E-Approval.xcworkspace -scheme E-Approval -archivePath ~/Desktop/Athena.xcarchive > /dev/null 2>&1;
            xcodebuild -exportArchive -archivePath ~/Desktop/Athena.xcarchive/ -exportPath ~/Desktop/ -exportOptionsPlist ../../../../ipa-options.plist > /dev/null 2>&1;
            echo "`date` : Build iOS berhasil"
            echo "Lokasi file ipa di ~/Desktop/E-Approval.ipa";
            exit 2;
            break;;

        $(( ${#options[@]}+1 )) ) select_platform; break;;
        *) echo "Ga ada pilihan nya cuy. Pilih 1-3 aja.";continue;;

        esac
    done
}

android_platform() {
    title="Pilih Environment"
    prompt="Silahkan pilih environment:"
    options=("Development" "Production" "Production-2")
    echo "$title"
    PS3="$prompt "
    select opt in "${options[@]}" "Kembali"; do
        case "$REPLY" in

        1 ) echo "Silahkan tunggu proses compile android";
            yarn deploy-dev > /dev/null 2>&1;
            cd cordova/eApproval/;
            cordova prepare android > /dev/null 2>&1;
            cd ../..;
            node ./config/version.js && [[ $(git status --porcelain -z | gawk '/version.json/ && /E-Approval-Info.plist/' ) ]] && git add version.json cordova/eApproval/platforms/ios/;
            yarn build-android-dev > /dev/null 2>&1;
            echo "`date` : Build android berhasil"; 
            echo "Lokasi file android di $PWD/cordova/eApproval/platform/android/app/build/outputs/apk/release/app-release.apk";
            exit 2;
            break;;
        2 ) echo "Silahkan tunggu proses compile android";
            yarn deploy-prd > /dev/null 2>&1;
            cd cordova/eApproval/;
            cordova prepare android > /dev/null 2>&1;
            cd ../..;
            node ./config/version.js && [[ $(git status --porcelain -z | gawk '/version.json/ && /E-Approval-Info.plist/' ) ]] && git add version.json cordova/eApproval/platforms/ios/;
            yarn build-android-prd > /dev/null 2>&1;
            echo "`date` : Build android berhasil"; 
            echo "Lokasi file android di $PWD/cordova/eApproval/platform/android/app/build/outputs/apk/release/app-release.apk";
            exit 2;
            break;;
        3 ) echo "Silahkan tunggu proses compile android";
            yarn deploy-prd2 > /dev/null 2>&1;
            cd cordova/eApproval/;
            cordova prepare android > /dev/null 2>&1;
            cd ../..;
            node ./config/version.js && [[ $(git status --porcelain -z | gawk '/version.json/ && /E-Approval-Info.plist/' ) ]] && git add version.json cordova/eApproval/platforms/ios/;
            yarn build-android-prd > /dev/null 2>&1;
            echo "`date` : Build android berhasil"; 
            echo "Lokasi file android di $PWD/cordova/eApproval/platform/android/app/build/outputs/apk/release/app-release.apk";
            exit 2;
            break;;

        $(( ${#options[@]}+1 )) ) select_platform; break;;
        *) echo "Ga ada pilihan nya cuy. Pilih 1-3 aja.";continue;;

        esac

    done
}

spin(){
  spinner="/|\\-/|\\-"
  while :
  do
    for i in `seq 0 7`
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      echo "$1"
      sleep 1
    done
  done
}

select_platform
