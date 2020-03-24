由于Jadx在反编译一两百MB的大型APK的时候，对内存有较高的要求，常常反编译到一半就会陷入频繁GC导致hang住的情况，解决方案一般是分Dex进行反编译，但是手工逐个输入命令最后还要合并显然很麻烦，

因此写了个脚本工具自动将apk解压，分别编译每个dex文件最后通过rsync将所有反编译产出合并。


# 参数选项
-d 目标APK路径

-o 反编译产出目录

# eg
./multi-dex-jadx.sh -d ~/code/crawl/elong_9_58_2.apk -o ./hello
