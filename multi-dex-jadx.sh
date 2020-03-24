#!/bin/bash
while getopts "d:o:" arg
do
	case $arg in
		d)
			apkPath=$OPTARG
			apkName=${OPTARG##*/}
			apkName=`basename $apkPath .apk`
			;;
		o)
			outputDir=$OPTARG
			;;
		?)
			echo "unsupported argument"
	esac
done

if [ x"$apkPath" = x ];then
	echo "hello~ please input your apk path..."
	exit 1
fi

if [ x"$outputDir" = x ];then
	outputDir="$apkName"_jadx 
fi

echo "source apk path:"$apkPath
echo "source apk name:"$apkName
echo "decompile result path:"$outputDir

mkdir $outputDir

cp $apkPath "$outputDir"/"$apkName".zip

unzip -o "$outputDir"/"$apkName".zip -d $outputDir > /dev/null
codePath=$outputDir"/code"
echo "decompile code path:"$codePath
mkdir $codePath

index=1
for file in `ls $outputDir`
do
	if [ x"${file##*.}" = x"dex" ];then
		jadx -j 1 -r --no-imports -d "$codePath"_"$index" $outputDir/$file
		# rsync中目录路径带/表示将所有文件复制到目标目录下，而非复制文件夹 
		rsync -a "$codePath"_"$index"/ $codePath
		# 删除临时目录
		rm -rf. "$codePath"_"$index"
		let index++
	fi
done