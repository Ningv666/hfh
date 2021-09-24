var express = require('express');
var router = express.Router();
const pool = require('../util/pool')
const md5 = require('md5');
const moment = require('moment');
//配置multer中间件
const multer = require('multer')
obj = multer.diskStorage({
  destination : function(req, file, cb){ //指定目录
    cb(null, 'public/images')
  },
  filename : function (req, file, cb){ // 指定文件名
    // console.log(uuid.v1())
    // console.log(uuid.v4())
    let name = file.originalname
    console.log(name);
    // name:  abcd.jpg    xxxdfdd.zip
    
    let ext = name.substr(name.lastIndexOf('.'))
    console.log(ext);
    cb(null, uuid.v4() + ext)
  }
})
const uploadTools = multer({
  storage : obj
})
const uuid = require('uuid')
/* GET users listing. */
// 查询用户收藏信息// 查询用户评论信息// 查询用户发表文章信息
router.get('/uinfo',(req,res,next)=>{
  let obj = req.query;
  let sql =  `select * from hf_collect where uid=? and flag = 0`;
  pool.query(sql,[obj.uid],(err,result)=>{
    if(err) {next(err);}
    var collects = result;
    sql = `select * from hf_comment where uid=? and flag = 0`;
      pool.query(sql,[obj.uid],(err,result)=>{
      if(err) {next(err);}
      var comments = result;
      sql = `select * from hf_article where author=?`
      pool.query(sql,[obj.uname],(err,result)=>{
        if(err) {next(err);}
        res.send({
          collects,
          comments,
          works:result
        })
      })
      });
  })
})
// 用户登录
//用户登录（post /login）
//地址：/users/login
router.post("/login",(req,res,next)=>{
  let obj = req.body;
  console.log(req.body);
  let sql = `select * from hf_user where phone =? and upwd =MD5(?)`;
  pool.query(sql,[obj.phone,obj.upwd],(err,result)=>{
    if(err) {next(err);}
    if(result.length){
      res.send({msg:`登录成功`,data:result,code:200});
    }else{
      res.send({msg:`登录失败，账号或密码错误`,data:result,code:201})
    }
  })
});
// 用户注册
// 用户注册（post /reg）
// 地址：/users/reg
router.post("/reg",(req,res,next)=>{
  let obj = req.body;
  console.log(req.body);
  delete obj.repwd;
  delete obj.checkbox;
  obj.upwd = md5(obj.upwd)//密码加密
  if(req.body.gender==0){//按照男女性别给默认头像
    obj.picture = '/img/avatar/IMG_20210910142851.jpg'
  }else {
    obj.picture = '/img/avatar/IMG_20210906152555.jpg'
  } 
  let sql = `select * from hf_user where uname=?`
  pool.query(sql,[obj.uname],(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      res.send({msg:`用户名已存在`,code:201})
    }else {
      sql = `select * from hf_user where phone=?`
      pool.query(sql,[obj.phone],(err,result)=>{
        if(err) next(err)
        if(result.length>0){
           res.send({msg:`号码已被注册`,code:201})
        }else {
            sql = `insert into hf_user set ?`;
            pool.query(sql,[obj],(err,result)=>{
              if(err) {console.log(err);}
              console.log(result);
              if(result.affectedRows>0){
                sql = `select * from hf_user where phone=?`
                pool.query(sql,[obj.phone],(err,result)=>{
                  if(err) {console.log(err);}
                  res.send({msg:`注册成功`,code:200,result:result});
                })
              }else{
                res.send({msg:`注册失败请重新注册`,code:201});
              }
            })
        }
      })
    }
  })
});
// 添加收藏
// /users/addcollect
router.post("/addcollect",(req,res,next)=>{
  let obj = req.body;
  obj.time = moment().format('X');
  obj.type = obj.type?obj.type:'图文'
  console.log(obj);
  let sql = `insert into hf_collect set ?`;
  pool.query(sql,[obj],(err,result)=>{
    if(err) throw(err);
    console.log(result);
    if(result.affectedRows>0){
      res.send({msg:'收藏成功',code:200});
    }else {
      res.send({msg:'收藏失败，请重新收藏',code:201});
    }
  })
})
// 取消收藏
// /users/delcollect
router.post("/delcollect",(req,res,next)=>{
  let obj = req.body;
  let sql = `update hf_collect set flag =1 where uid = ? and id = ?`;
  pool.query(sql,[obj.uid,obj.aid],(err,result)=>{
    if(err) throw(err);
    if(result.affectedRows>0){
      res.send({msg:'取消收藏成功',code:200});
    }else {
      res.send({msg:'取消收藏失败',code:201});
    }
  })
})
// 按照cid取消收藏
// /users/decollect
router.post("/decollect",(req,res,next)=>{
  let obj = req.body;
  let sql = `update hf_collect set flag =1 where ccid = ?`;
  pool.query(sql,[obj.cid],(err,result)=>{
    if(err) throw(err);
    if(result.affectedRows>0){
      res.send({msg:'取消收藏成功',code:200});
    }else {
      res.send({msg:'取消收藏失败',code:201});
    }
  })
})
// 查询是否收藏// /users/selcollect
router.post("/selcollect",(req,res,next)=>{
  let obj = req.body;
  let sql = `select * from hf_collect where flag =0 and uid =? and id =?`;
  pool.query(sql,[obj.uid,obj.aid],(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      res.send({msg:'已收藏',code:200});
    }else {
      res.send({msg:'未收藏',code:201});
    }
  })
})
// 查询用户收藏列表// /users/selcollectlist
router.post("/selcollectlist",(req,res,next)=>{
  let obj = req.body;
  let sql = `select * from hf_collect as a inner join hf_article as b on a.id = b.aid where a.flag =0 and a.uid =?`;
  pool.query(sql,[obj.uid],(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      res.send({msg:'查询成功',code:200,result});
    }else {
      res.send({msg:'查询失败',code:201,result});
    }
  })
})
// 添加评论  /users/addcomment
router.post("/addcomment",(req,res,next)=>{
  let obj = req.body;
  obj.time =  moment().format('X');
  let sql = `insert into hf_comment set ?`;
  pool.query(sql,obj,(err,result)=>{
    if(err) next(err);
    if(result.affectedRows>0){
      res.send({msg:'评论成功',code:200});
    }else {
      res.send({msg:'评论失败，请重新评论',code:201});
    }
  })
})
// 删除评论  /users/delcomment
router.post("/delcomment",(req,res,next)=>{
  let obj = req.body;
  console.log(obj);
  let sql = `update hf_comment set flag =1 where cid=?`;
  pool.query(sql,[obj.cid],(err,result)=>{
    if(err) throw(err);
    console.log(result);
    if(result.affectedRows>0){
      res.send({msg:'删除评论成功',code:200});
    }else {
      res.send({msg:'删除评论失败',code:201});
    }
  })
})
// 查询文章评论
//  /users/selcomment
router.post("/selcomment",(req,res,next)=>{
  let obj = req.body;
  let sql = `select * from hf_comment as a inner join hf_user as u on a.uid = u.uid where a.aid = ? and a.flag = 0`;
  pool.query(sql,[obj.aid],(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      res.send({msg:'查询评论成功',code:200,result:result});
    }else {
      res.send({msg:'查询评论失败',code:201});
    }
  })
})
// 上传图片
router.post('/upload',uploadTools.array('file'),(req,res,next)=>{
   res.send(req.files);
})
// 发表图文
//users/addarticle
router.post("/addarticle",(req,res,next)=>{
  let obj = req.body;
  let files = obj.files;
    delete obj.files;
    obj.img = files[0];
  obj.time =  moment().format('X');
  pool.query('select * from hf_user where uid = ?',[obj.uid],(err,result)=>{
    obj.author = result[0].uname;
    delete obj.uid;
    console.log(result);
    obj.picture = result[0].picture;
    console.log(obj);
      let sql = `insert into hf_article set ?`
      pool.query(sql,obj,(err,result)=>{
    if(err) throw(err);
    if(files.length>0){
      sql = `select aid from hf_article where time = ?`;
      pool.query(sql,obj.time,(err,result)=>{
        let aid = result[0].aid;
        console.log(result);
        sql = `insert into hf_img(aid,img) values(?,?) `
        for(var i =1;i<files.length;i++){
          pool.query(sql,[aid,files[i]],(err,result)=>{
            if(err)throw err;
          })
        }
      })
    }
    if(result.affectedRows>0){
      res.send({msg:'发表成功',code:200});
    }else {
      res.send({msg:'发表失败',code:201});
    }
  })
  })

});


// 模糊查询
//users/search
router.get('/search',(req,res,next)=>{
   // 获取客户端传递的page参数
   let page = req.query.page?req.query.page:1;
   let pagesize = 20;
   // 计算从第几条记录开始返回
   let offset = (page-1)*pagesize;
  let obj = req.query;
  let type = obj.type?obj.type:1;
  let key = `%${obj.key}%`;
  if(type==1){
    sql=`select * from hf_article where title like ? or content like ? limit ?,?`
  }else if(type==2){
    sql=`select * from hf_show where title like ? or address like ? limit ?,?`
  }else if(type==3){
    sql=`select * from hf_study where title like ? or des like ? limit ?,?`
  }
    pool.query(sql,[key,key,offset,pagesize],(err,result)=>{
      if(err) throw(err);
      if(result){       
      res.send({msg:'查询成功',result:result});
    }else {
      res.send({msg:'查询成功,无数据',result:result});
      }
    })

})



module.exports = router;
