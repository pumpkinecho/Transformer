# 大模型中期作业项目运行要求

提前安装好pytorch 11.8版本，根据requirements.txt文件安装相关的库环境

![image-20251109120742481](C:\Users\pumpkin\AppData\Roaming\Typora\typora-user-images\image-20251109120742481.png)

运行主文件夹Transformer/scripts/run.sh即可，代码里面使用的均为相对路径，在命令行里要进入Transformer文件夹再运行。参数可省略。

```python
# 参数依次是随机种子，batch-size，学习率，训练轮次，省略参数即为默认值
bash scripts/run.sh 41 32 3e-4 30
```

![image-20251109123859886](C:\Users\pumpkin\AppData\Roaming\Typora\typora-user-images\image-20251109123859886.png)

项目结构图如上。



数据集超过了25MB，训练好的权重文件几百MB，不知道为什么开了梯子借助LFS也上传不上去，数据集和生成的文本文件以及训练好的权重文件以网盘的形式上传，下载后按照下面的文件目录形式放到对应目录下即可。

通过网盘分享的文件：数据集
链接: https://pan.baidu.com/s/1rIhmo4gUNPzbqflH1U9cCQ?pwd=94xy 提取码: 94xy

![Snipaste_2025-11-09_18-20-10](D:\Studty\model\image\Snipaste_2025-11-09_18-20-10.png)
