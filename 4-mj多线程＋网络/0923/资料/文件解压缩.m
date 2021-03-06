一、技术方案
1.第三方框架：SSZipArchive
2.依赖的动态库：libz.dylib

二、压缩1
1.第一个方法
/**
 zipFile ：产生的zip文件的最终路径
 directory ： 需要进行的压缩的文件夹路径
 */
[SSZipArchive createZipFileAtPath:zipFile withContentsOfDirectory:directory];

2.第一个方法
/**
 zipFile ：产生的zip文件的最终路径
 files ： 这是一个数组，数组里面存放的是需要压缩的文件的路径
 files = @[@"/Users/apple/Destop/1.png", @"/Users/apple/Destop/3.txt"]
 */
[SSZipArchive createZipFileAtPath:zipFile withFilesAtPaths:files];

三、解压缩
/**
 zipFile ：需要解压的zip文件的路径
 dest ： 解压到什么地方
 */
[SSZipArchive unzipFileAtPath:zipFile toDestination:dest];