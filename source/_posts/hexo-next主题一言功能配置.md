---
title: hexo next主题一言功能配置
date: 2021-06-10 21:43:34
tags: 
- hexo
categories: 
- hexo
---
## 说明

[一言](https://hitokoto.cn/)网创立于2016年，隶属于萌创Team，目前网站主要提供一句话服务。

<!-- more -->

动漫也好、小说也好、网络也好，不论在哪里，我们总会看到有那么一两个句子能穿透你的心。我们把这些句子汇聚起来，形成一言网络，以传递更多的感动。如果可以，我们希望我们没有停止服务的那一天。

简单来说，一言指的就是一句话，可以是动漫中的台词，也可以是网络上的各种小段子。
或是感动，或是开心，有或是单纯的回忆。来到这里，留下你所喜欢的那一句句话，与大家分享，这就是一言存在的目的。（来源于一言官方网站）

## hexo-next配置

1. 站点目录下的 `source\_data\next.yml`启用`header`:

   ```yaml
   custom_file_path:
     #head: source/_data/head.swig
     header: source/_data/header.swig
     #sidebar: source/_data/sidebar.swig
     #postMeta: source/_data/post-meta.swig
     #postBodyEnd: source/_data/post-body-end.swig
     footer: source/_data/footer.swig
     bodyEnd: source/_data/body-end.swig
     variable: source/_data/variables.styl
     custom: source/_data/custom.styl
     #mixin: source/_data/mixins.styl
     style: source/_data/styles.styl
   ```

2. 同级目录下新建`header.swig`（如果存在则忽略）并添加如下配置：

```javascript
 <!-- 一言API -->
<!-- 现代写法，推荐 -->
<!-- 兼容低版本浏览器 (包括 IE)，可移除 -->
<!-- 加入网易云音乐热门评论，实时更新 -->
<div class="poem-wrap">
    <div class="poem-border poem-left">
    </div>
    <div class="poem-border poem-right">
    </div>
    <h1>一言</h1>
    <p id="hitokoto">loading...</p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bluebird@3/js/browser/bluebird.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/whatwg-fetch@2.0.3/fetch.min.js"></script>
<!--End-->
<script>
  fetch('https://v1.hitokoto.cn')
    .then(function (res){
      return res.json();
    })
    .then(function (data) {
      var hitokoto = document.getElementById('hitokoto');
      hitokoto.innerText = data.hitokoto + '\n——' + data.from;
    })
    .catch(function (err) {
      console.error(err);
    })
</script>

```

3. 同级目录下新建`styles.styl`（如果存在则忽略）并添加如下配置：

```css
/* 增加每日一言模块 */
.poem-wrap {
    position: relative;
    width: 730px;
    max-width: 80%;
    border: 2px solid #797979;
    border-top: 0;
    text-align: center;
    margin: 80px auto;
}
.poem-left {
    left: 0;
}
.poem-border {
    position: absolute;
    height: 2px;
    width: 27%;
    background-color: #797979;
}
.poem-right {
    right: 0;
}
.poem-wrap h1 {
    position: relative;
    margin-top: -20px;
    display: inline-block;
    letter-spacing: 4px;
    color: #797979;
}
.poem-wrap p:nth-of-type(1) {
    font-size: 25px;
    text-align: center;
    margin: 0 auto;
}
.poem-wrap p {
    width: 70%;
    margin: auto;
    line-height: 30px;
    color: #797979;
    font-family: "Linux Biolinum", "Noto Serif SC", Helvetica, Arial, Menlo, Monaco, monospace, sans-serif;
}
.poem-wrap p:nth-of-type(2) {
    font-size: 18px;
    margin: 15px auto;
}
.bozhushuo {
    text-align: center;
    font-size: 19px!important;
    margin: 0 0 12px!important;
    line-height: 1.9rem;
    font-family: "Linux Biolinum", "Noto Serif SC", Helvetica, Arial, Menlo, Monaco, monospace, sans-serif;
}
.notice {
    margin: 30px auto;
    padding: 20px;
    border: 1px dashed #e6e6e6;
    color: #969696;
    position: relative;
    display: inline-block;
    width: 95%;
    background: #fbfbfb50;
    border-radius: 10px;
    font-size: 16px;
}
.notice-content {
    display: initial;
    vertical-align: middle;
}
```