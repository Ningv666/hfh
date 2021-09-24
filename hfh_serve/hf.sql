set names utf8;
drop database if exists hf;
create database hf charset=utf8;
use hf;

-- 用户信息表
create table hf_user(
  uid int primary key auto_increment,
  uname varchar(32) unique not null,
  upwd varchar(128) not null,
  phone varchar(32) unique not null,
  gender varchar(4) not null,
  picture varchar(128) not null
);

-- 文章信息表
create table hf_article(
  aid int primary key auto_increment,
  title varchar(128),
  content varchar(1024),
  author varchar(128) not null,
  time varchar(128) not null,
  picture varchar(128) not null,
  img varchar(256),
  topic varchar(128)
);
insert into hf_article values(null,'盛世需要美人点缀，乱世需要美人顶罪','商纣王为了妲己放弃了天下，唐玄宗为了天下放弃了玉环。拍摄地：重庆浅憩ln酒店@浅憩','程月','2021-06-06','/img/avatar/ooYBAGC4mKmAOqu_AAFKkkygNZE929.jpg','/img/article/60ba3498872a9d158f6273f6_1279-1706.jpg','2021国风大赏最美汉服集锦');
insert into hf_article values(null,'手边荷叶亭亭 玩笑两朵芙蕖','解一只舟楫/趁闲摇过长堤” 摄后若若 妆造诺白出镜绣崽自己是孟津的.荷花池，花开的不多荷叶长的蛮好。豪华大船房崽也有啦哈哈','弦乐','2021-06-06','/img/avatar/IMG_20210906152555.jpg','/img/article/611ba845fd2be27461feeef5_1279-1706.jpg','2021国风大赏最美汉服集锦');
insert into hf_article values(null,'盛夏游园穿着汉服去野餐','野餐爱好者又出来野餐啦,附上野餐攻略,我穿的是日常改良汉服，头发半扎.我用的蕾丝桌布当野餐布，带了些花💐装点布景，可以带上一些中式风格的道具哦！我们带了中式竹编提篮和传统油纸伞，国风氛围感get！
可以带些水果、点心！当道具拍完照还能吃','同袍','2021-06-06','/img/avatar/IMG_20210906152555.jpg','/img/article/6103710b2c7d0a0d081e4733_940-1253.jpeg','2021国风大赏最美汉服集锦');
insert into hf_article values(null,'唐宫夜宴同款汉服绝了','十三余这套唐宫夜宴联名款汉服我好喜欢啊！','同袍','2021-06-06','/img/avatar/IMG_20210906152555.jpg','/img/article/610117cefb69035e08029540_854-1280.png','2021国风大赏最美汉服集锦');
-- 视频信息表
create table hf_video(
  vid int primary key auto_increment,
  title varchar(128),
  content varchar(1024),
  author varchar(128) not null,
  time varchar(128) not null,
  picture varchar(128) not null,
  img varchar(256),
  video varchar(256),
  topic varchar(128)
);
insert into hf_video values(null,"蜀绣又名川秀，一根细细的银针，织就蜀地锦绣山河","","国风正当潮","2021.08.08","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","video\6109fc54fd2be27461fedc1f_288-512.png","video/1010912712_fsNlzMrP.mp4","乞巧节·这手艺惊艳所有人");
insert into hf_video values(null,"我的汉服快装不下了","最近又入手了 好几套汉服我的柜子真的是塞得满满当当的快要比我平常穿的衣服都多了最近爱上了这种变装的汉服展示 感觉像一个简单的处理 就能换一种完全不同的感觉 很酷","国风正当潮","2021.08.08","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","video\60de22929e05d0371ac3ecb1_288-512.png","video/1010894379_TN2PDR18.mp4","");
insert into hf_video values(null,"巧夺天工，天衣无缝，苏绣独创的神奇技法-双面三异绣（异色、异形、异针）。","","国风正当潮","2021.08.08","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","video\6109fbd03327bf081515f8eb_288-512.png","video/1010912710_UfMMPI1U.mp4","乞巧节·这手艺惊艳所有人");
insert into hf_video values(null,"小哥哥小姐姐穿汉服男装都好帅啊","","国风正当潮","2021.08.08","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","video\61011679fb69035e0802953f_288-512.png","video/1010910200_7P1wNGcE.mp4","2021国风大赏最美汉服集锦");

-- 文章图片表
create table hf_img(
  iid int primary key auto_increment,
  aid int not null,
  img varchar(128) not null,
  foreign key(aid) references hf_article(aid)
);
insert into hf_img values(null,1,"/img/article/60ba349c8dedc7002b793202_1279-1706.jpg");
insert into hf_img values(null,1,"/img/article/60ba349d8dedc7002b793203_1279-1706.jpg");
insert into hf_img values(null,1,"/img/article/60ba349beb4e4c7f63d93f2a_1279-1706.jpg");
insert into hf_img values(null,2,"/img/article/611ba8472c7d0a0d081e616b_1279-1706.jpg");
insert into hf_img values(null,2,"/img/article/611ba8482c7d0a0d081e616c_1279-1706.jpg");
insert into hf_img values(null,2,"/img/article/611ba8493327bf0815160bd3_1279-1706.jpg");
insert into hf_img values(null,3,"/img/article/6103710b2c7d0a0d081e4738_954-1272.jpeg");
insert into hf_img values(null,3,"/img/article/6103710c2c7d0a0d081e473a_923-1230.jpeg");
insert into hf_img values(null,3,"/img/article/6103710b2c7d0a0d081e4736_950-1266.jpeg");
insert into hf_img values(null,4,"/img/article/610117d0fb69035e08029541_1919-1067.jpg");


-- 评论信息表
create table hf_comment(
  cid int primary key auto_increment,
  aid int not null,
  uid int not null,
  content varchar(128) not null,
  time varchar(1024),
  foreign key(aid) references hf_article(aid),
  foreign key(uid) references hf_user(uid)
);

-- 收藏信息表
create table hf_collect(
  ccid int primary key auto_increment,
  id int not null,
  uid int not null,
  type varchar(128) not null,
  time varchar(1024),
  foreign key(uid) references hf_user(uid)
);

-- 话题信息表
create table hf_topic(
  tid int primary key auto_increment,
  name varchar(128) unique not null,
  content varchar(1024) not null
);
insert into hf_topic values(null,"2021国风大赏最美汉服集锦","2021华裳九州国风大赏，海马体、十三余、重回汉唐等众多汉服品牌新品亮相，你觉得哪套汉服最美？知名主播李佳琦身着断桥残雪联名款汉服亮相活动现场，带货总值突破5000万。汉服文化和穿搭已在年轻人中形成一种新的“国潮”。");
insert into hf_topic values(null,"风从东方来，舞出中国魂","一袭汉服优雅起，万种意蕴乐中升！身穿汉服一舞动人，感受盛世中华。同袍们，一起跳舞吗？");
insert into hf_topic values(null,"大揭秘！仙女这样梳头","作为一名袍子，每一根头发丝都要精致！一套好看的汉服怎么能少了合适的发型搭配？快来get精美又简单的汉服发型！你学fei了吗？");
insert into hf_topic values(null,"同袍云雅集"," 在这里，你可以通过发布视频的方式，与同袍们在云端交流绘画、穿搭、妆容vlog、科普、摄影等方面的心得或分享圈内资讯信息。只要稿件具有吸引力且与国风、汉服相关，还可能获得丰厚大奖哦~加入我们的官方群聊：494293437，了解更多详细信息！");
insert into hf_topic values(null,"图图表情包模仿大赛","大家好！我是住在翻斗花园的胡图图！听说网上的哥哥姐姐们都在用我的表情包，我有一个好消息告诉大家喔：图图表情包模仿大赛开始啦！快来比比谁更像我吧！");
insert into hf_topic values(null,"萌宠也能驾驭汉服？！","国潮再兴，同袍们不但自己穿上汉服，还不忘给家里的主子安排上。交领右衽和褒衣广袖的汉服同宠物的跨界结合会碰撞出什么样的火花呢？铲屎官有的我也要有，安排！");
insert into hf_topic values(null,"国风妆容能有多绝？","国风妆容对同袍们来说就是yyds！精致的国风妆容不仅超级吸睛，还能为汉服造型锦上添花！快来分享那些超惊艳的国风妆容吧");
insert into hf_topic values(null,"乞巧节·这手艺惊艳所有人","七夕有奖活动七夕节又称乞巧节，一直有着向七仙女“乞巧”（祈求巧手）的民俗，在这个特别的节日里，一起来领略那些令人惊艳的手艺吧！你学fei了吗？");

-- 演出信息表
create table hf_show(
  sid int primary key auto_increment,
  title varchar(128) not null,
  price varchar(128) not null,
  date varchar(128),
  img1 varchar(128) not null,
  img2 varchar(128) not null,
  address varchar(128) not null,
  username varchar(128) not null,
  userpic varchar(128) not null,
  time varchar(128) not null,
  des varchar(1024) not null,
  isnow int
  );
insert into hf_show values(null,"同袍云雅集","免费","09/30 10:00-11/26 23:59","/img/show/612d8ef187901f1b9fcce67b_1080-1544.jpg","/img/show/612d8ef587901f1b9fcce67c_1080-5500.jpg","福建省厦门市望海路8号厦门市软件园望海路8号楼","国风正当潮","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","2021.08.18"," <p> 活动时间:2021年08月30日-2021年9月26日，合计4周,总共四次周评选，以发布视频的方式赢取激励。</p><p>参与方式:带活动话题#同袍云雅集#上传原创视频，即可参与评选,评选会综合播放量、互动量、内容质量三个维度,快来参加吧~</p><p>关注@小主成长助手获取榜单排名及更多资讯,加入官方群聊:494293437，了解更多详细信息!</p>",1);
insert into hf_show values(null,"千秋雅集","免费","09/30 10:00-11/26 23:59","/img/show/60efa3a9687b8004160627cb_823-823.jpg","/img/show/60efa3ac687b8004160627cc_755-755.jpg","湖北省武汉市11号线光谷生物园(地铁站)","国风正当潮","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","2021.08.18","九月齐聚江城，共赏华服风采。专业汉服形象评选赛，超多传统文化互动活动，超多汉服品牌IP商官方直参！超大国风舞台，同袍自由展示舞台，专业摄像师免费跟拍，期待与大家的见面！",2);
insert into hf_show values(null,"天府文创锦绣云上”成都国际动漫嘉年华活动暨动漫产业发展论坛","免费","09/03 周五 13:30-21:00","/img/show/612705e4f3ce93170d1662d6_686-386.jpg","","四川省成都市交子大道中海国际中心D座","国风正当潮","/img/avatar/oYYBAGCbTsKAITmlAADLBUTdJDM641.png","2021.08.18","[“天府文创 锦绣云上”论坛 —— 咪咕动漫专题分享] 13：30-17：00
[文创集市]17：00-21：00
1、抽奖游戏：现场使用咪咕圈圈拍摄一段视频：“天府文创 锦绣云上”并发布成功，即可免费获得1张抽奖券。扫码进入咪咕圈圈官方汉服活动福利群，在群内发送暗号”咪咕圈圈我来了”，即可免费获得1张抽奖券。
2、换装体验：成都客梦锦城汉服体验馆提供免费汉服换装及简单妆造体验。
3、现场约拍：邀请摄影师进行摆拍动作指导及现场约拍服务",3);



-- 学堂信息表
create table hf_study(
  ssid int primary key auto_increment,
  title varchar(128) not null,
  img varchar(128) not null,
  username varchar(128) not null,
  userpic varchar(128) not null,
  time varchar(128) not null,
  des varchar(128) not null,
  type varchar(64) not null
);
insert into hf_study values(null,"什么是汉文化？","/img/article/ooYBAGC_FdaAKO47AAvVMl-ftiw793.png","汉服小知识",'/img/avatar/oYYBAGCbTuaAJkoGAAMEe9-6Gho134.png',"2021.06.08","<p>汉文化是中国文化的主体。又称为中华文化、华夏文化、儒家文化，指以春秋战国时期诸子百家学说为基础、儒家文化为主兼与法家、道家、墨家、阴阳家、名家、杂家、农家、小说家、纵横家、兵家、医家共同不断演化、发展而形成的文化。</p><p>汉民族在古代创造了辉煌灿烂的文化艺术，具有鲜明的特色。汉民族有五千多年有实物可考的历史，四千多年文字可考的历史，文化典籍极其丰富。几千年间，无论政治、军事、哲学、经济、史学、自然科学、文学（汉诗、文言文）、艺术等各个领域，都产生了众多具有深远影响的文化成就。</p><p><img src='/img/article/ooYBAGC_FdaAKO47AAvVMl-ftiw793.png'></p>","秒懂汉服");
insert into hf_study values(null,"萌新们躲避山寨的正确步骤","/img/article/oYYBAGC51tOAVbJGAAFnKtLu4Xk458.jpg","牛奶秋刀鱼",'/img/avatar/ooYBAGCbcveAUZ_2AAItje4jXCg269.png',"2021.06.08","<p>看见很多新人妹子们很难认出山寨汉服，而且淘宝山寨汉服商家比正规汉服商家都要多并且越来越多，感觉有必要专门说一下躲避山寨的一些步骤和措施，让新人妹子们少交学费。<br> 正版汉服商家总结2.0版（有补充改动）<br> 【高端成品店】<br> 江南桃花家，踏云馆，汉客丝路，春拾记，南朝，锦瑟衣庄，明华堂（微博），清辉阁， 小嫏嬛馆，桑缬（微博），云想，瞳莞，平江宝织，和宁工坊，撷秀，菩提雪，朝露之城，竹里馆，鹿苑听松（微博），天衣坊，小雅，控弦司，筱绣阁，静淞居<br> 【中端成品店】<br> 三十六雨，如是观，山市晴岚，司南阁，风熏堂，重回汉唐，京渝堂，她说，芷兰汀，缥染缃裁，沉香画舫，青丘夜雪，你好美荔，浅画青杏，薄雾微光（原国风少女），簪花阁，兰绮轩，司狐苑，如是观，云舒院，净燃，天河莲（原剑荷堂），燕雨花事，渔家的汉服日常，折花换酒（一念居），东京梦华录，游园惊梦，雁荡楠溪，花间赋<br> 【白菜成品店】；<br> 青莲堂，华兴唐，子夜歌，明月坞，煜书长安，南约，兰夜心，云水暮聆，冷袖香苑，陌上人家，兰若庭，久梦引，素影阁，槿罗记（原绮罗香），森唐，清泓记，绛雲，观止茶舍，华夏粹，花朝记，上雅工坊，北渚，国色芳华，天韵馆，楚辞兮兮，玺儿制作，怀谷居，河汉涓埃，城南旧事，霜云居，白苏记，花妖汉衣堂，夜聆工坊，小邾烟雨，晏曦楼，栖月小铺，青眸汉服，子裳漢服，清霄浮烟，越山清，顾七工作室，月韵云间，萧然小筑，入妙境，路尽隐香苑，山月春华，裕雅集，山风阁，殊不知，惊蛰之年，桃根渡，碧玉年华，掬水碎月，似东翎，福禄堂，彧卿工作室，上遥居，寒山渡<br></p>","秒懂汉服");
insert into hf_study values(null,"什么是汉服史？","/img/article/oYYBAGC51tOAVbJGAAFnKtLu4Xk458.jpg","汉服小知识",'/img/avatar/oYYBAGCbTuaAJkoGAAMEe9-6Gho134.png',"2021.07.08","<p>汉服史是指汉民族服饰发展史，汉服是中国汉民族的民族服饰，传承千年，历史悠久，一部汉服史等于半部中华文明史。了解汉服就一定要深入的了解汉服的历史，只有了解汉服的历史才能更好地热爱传承我们优秀的民族文化。</p><p><img alt="" src='http://images.migudm.cn/group1/M00/43/14/oYYBAGC-5vaAC0CTAARRheYoHTo559.png' style='height:426px; width:640px'></p><p>上古穴居而野处，衣毛而冒皮，未有制度。后世圣人易之以丝麻，观翚翟之文，荣华之色，乃染帛以效之，始作五采，成以为服。见鸟兽有冠角髯胡之制，遂作冠冕缨蕤，以为首饰。凡十二章。故《易》曰：“庖牺氏之王天下也，仰观象于天，俯观法于地，观鸟兽之文，与地之宜，近取诸身，远取诸物，于是始作八卦，以通神明之德，以类万物之情。”黄帝、尧、舜垂衣裳而天下治，盖取诸乾坤。乾坤有文，故上衣玄，下裳黄。日月星辰，山龙华虫，作缋宗彝，藻火粉米，黼黻絺绣，以五采章施于五色作服。天子备章，公自山以下，侯伯自华虫以下，子男自藻火以下，卿大夫自粉米以下。至周而变之，以三辰为旂旗。王祭上帝，则大裘而冕；公侯卿大夫之服用九章以下。秦以战国即天子位，灭去礼学，郊祀之服皆以袀玄。汉承秦故。至世祖践祚，都于土中，始修三雍，正兆七郊。显宗遂就大业，初服旒冕，衣裳文章，赤舄絇屦，以祠天地，养三老五更于三雍，于时致治平矣。这段文字出自《后汉书·舆服志》，这段文字高度概括了后汉明帝之前汉服的发展。汉明帝是中国汉服发展历史上一个重要的历史人物，《晋书·舆服志》中说明帝采《周官》、《礼记》，更服衮章，天子冠通天而佩玉玺。汉明帝恢复了自周代灭亡以后被荒废的冕服制度，汉明帝的“衣冠承周”是自汉武帝“罢黜百家·独尊儒术”后，中国人继思想领域后在衣冠领域的一次文化复兴。明帝以后的汉族王朝多延续周制而有所损益，形成了中国汉服万世一系的传承。</p>","秒懂汉服");
-- 学堂一级类别表
create table hf_ftype(
  tid int primary key auto_increment,
  name varchar(128) not null
);
-- 学堂二级类别表
create table hf_stype(
  typeid int primary key auto_increment,
  name varchar(128) not null,
  fid int
);
-- 轮播图
create table hf_carousel(
  cid int primary key auto_increment,
  url varchar(128) not null,
  href varchar(128) not null,
  type varchar(4) not null
);
insert into hf_carousel values(null,"img/lunbo/IMG_20210903_223810.jpg","/user","1");
insert into hf_carousel values(null,"img/lunbo/IMG_20210905113925.jpg","/user","1");
insert into hf_carousel values(null,"img/lunbo/IMG_20210905113953.jpg","/activity","1");
insert into hf_carousel values(null,"img/lunbo/IMG_20210903_223505.jpg","/activity","1");
insert into hf_carousel values(null,"img/lunbo/IMG_20210903_223630.jpg","/showdetails/1","1");
insert into hf_carousel values(null,"img/lunbo/IMG_20210905112858.jpg","/showdetails/2","1");
insert into hf_carousel values(null,"img/lunbo/IMG_20210903_223723.jpg","/showdetails/3","1");
