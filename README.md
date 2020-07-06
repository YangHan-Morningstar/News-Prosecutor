# 新闻检察官

## 一、简介

“新闻检察官”是一款基于SwiftUI框架、CreateML机器学习框架的虚假新闻检测App，它能够允许用户在手机离线的状态下对文本新闻或者图片新闻进行真假检测，同时用户也可以在其中进行辨别真假训练，提高自身的辨别能力，最终达到有效防止虚假新闻传播的目的。

## 二、系统说明

### 2.1 功能介绍

* 文本真实性检测：系统能够对用户输入的新闻文本进行检测，并返回文本的真实性结果。
* 图片真实性检测：系统能够对用户输入的新闻图片进行检测，并返回图片的真实性结果。
* 知识提供：用户可在其中学习如何辨别虚假新闻。
* 实战训练： 系统会随机生成题目（包括文本和图片），用户可以进行训练，提高自身辨别能力。

### 2.2 数据介绍

* 图片数据集：网上搜集，训练集30000余张，测试集6800余张。
* 文本数据集：网上搜集，训练集22000余条，测试集5000余条。

### 2.3 模型介绍

* 文本检测：基于CreateML机器学习框架中的最大熵模型。

<img width="400" height="250" src="https://github.com/YangHan-Morningstar/News-Prosecutor/blob/master/News%20Prosecutor/Preview%20Content/Preview%20Assets.xcassets/TextModel.imageset/TextModel.png"/>

* 图片检测：基于CreateML机器学习框架中的场景打印特征提取器及图片识别模型。

<img width="400" height="250" src="https://github.com/YangHan-Morningstar/News-Prosecutor/blob/master/News%20Prosecutor/Preview%20Content/Preview%20Assets.xcassets/ImageModel.imageset/ImageModel.png"/>

### 2.4 其他

* 采用MVVM软件架构模式。
* 使用CoreData数据库。

## 三、注意事项

* 不要上传与新闻无关的文本或者图片，否则检测结果并不准确。
* 仅限iOS使用。