// 把内容塞到body中
//document.write('hahahahha');
//document.write('<div style="color:red;">123</div>');


//alert(document.body.childNodes.length);

var list = document.body.childNodes;
var len = document.body.childNodes.length;
//alert(len);
//for(var i = 0; i<len; i++) {
//    var ele = list[i];
//    alert(ele.tagName);
//}

// 创建了一个img标签，添加到body中
var img = document.createElement('img');
img.src = 'images/icon_01.png';

// 将img标签拼接到body标签的最后面
//document.getElementsByName('body')[0].appendChild(img);
// 取得body最简单最可靠的办法：document.body
document.body.appendChild(img);

// 创建了一个img标签，添加到body中
var img2 = document.createElement('img');
img2.src = 'images/icon_02.png';
document.body.appendChild(img2);

// 添加p标签到div中
var div = document.getElementById('content');
var p = document.createElement('p');
// 设置p标签里面的内容
p.innerHTML = '5879347985437895798';
div.appendChild(p);

// 获得img标签
var mj = document.getElementsByClassName('mj')[0];
//document.body.removeChild(mj);
mj.parentNode.removeChild(mj);

//alert(document.body.childNodes.length);

// CRUD 增删改查
// Create
// Read
// Update
// Delete