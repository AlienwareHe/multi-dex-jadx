由于Jadx在反编译一两百MB的大型APK的时候，对内存有较高的要求，常常反编译到一半就会陷入频繁GC导致hang住的情况，解决方案一般是分Dex进行反编译，但是手工逐个输入命令最后还要合并显然很麻烦，

因此写了个脚本工具自动将apk解压，分别编译每个dex文件最后通过rsync将所有反编译产出合并。

# base
基于jadx与apktool，因此确保这两个命令都添加至了环境变量中

# feature
* jadx反编译dex成java文件
* apktool反编译资源文件及smali文件

# 参数选项
-d 目标APK路径

-o 反编译产出目录

# eg
./multi-dex-jadx.sh -d ~/code/crawl/xxxx.apk -o ./hello
