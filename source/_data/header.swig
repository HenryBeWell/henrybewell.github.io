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
