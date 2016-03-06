# TWTicketPrinter


（ThoughtWorks Home Work --- 收银台）

##Introductions

因为用到了一些开源框架（如：[Kiwi](https://github.com/kiwi-bdd/Kiwi), [ReacticveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)等），如因为三方控件导致程序不能运行，请先<kbd> Pod Install</kbd>

经过思考，我将程序大致分为了3个模块。

```flow
st=>start: 开始
e=>end: 结束
parse=>operation: 解析建模
calc=>operation: 计算处理
output=>operation: 打印结果
st->parse->calc->output->e
```

>1.解析模块： 主要负责对输入的数据进行解析并且建模。(如：BarCodeParser)
>
>2.计算，处理模块 (如：SaleStrategy、SaleFactory)
>
>3.输出模块  (如：OutputBuilder)

##techniques
 >- **策略模式**
 >- **享元模式**
 >- **代理模式** (用于需求扩展)
 >- **单例**
 >- **反射**
 >- **MVVM**    (UI写了一个简单的MVVM)


文件结构

**Configs** 文件夹下，放一些测试数据都和策略配置文件。

 **Moudles** 文件夹下，放的是核心的类

**TWTicketPrinterTests** 工程里，写了一些TestCase

##Contacts
Gmail:  **haoer715@gmail.com**