var express = require('express');
var router = express.Router();
const pool = require('../util/pool')
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
// 获取主页轮播图与话题部分
router.get('/carousel',function(req,res,next){
  pool.query('select * from hf_carousel where type="1"',(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      var lunbo = result;
    }
    pool.query('select * from hf_topic limit 0,3',(err,result)=>{
      if(err) next(err);
      if(result.length>0){
        let topicpart = result;
        res.send({lunbo,topicpart});
      }
    })
  })
})
// 获取所有话题部分
router.get('/topics',function(req,res,next){
  pool.query('select * from hf_topic',(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      let topics = result;
      res.send({topics});
    }
  })
})
// 查询首页推荐图文部分
router.get('/articles',(req,res,next)=>{
 // 获取客户端传递的page参数
  let page = req.query.page?req.query.page:1;
  let pagesize = 20;
  // 计算从第几条记录开始返回
  let offset = (page-1)*pagesize;
  let rowcount;
  //用来存储获取到的总记录数量
  let sql = 'select COUNT(aid) as count from hf_article '; 
    pool.query(sql,(err,result)=>{   
      if(err)next(err);      
      rowcount = result[0].count;      
      let pagecount = Math.ceil(rowcount/pagesize)
      sql = 'select *  from hf_article order by aid desc limit ?,? ';
        pool.query(sql, [offset, pagesize], (err, result) => {
            if (err) next(err);
            res.send({ message: 'ok', code: 200, result: result, pagecount: pagecount });
        });
    })
})
// 查看文章的详情信息(查看评论)
router.get('/article',(req,res,next)=>{
  let id = req.query.id? req.query.id :1;
  let sql = "select * from hf_article where aid =?";
  pool.query(sql,[id],(err,result)=>{
    if(err) next(err);
    let details = result;
    sql = "select * from hf_img where aid =?";
    pool.query(sql,[id],(err,result)=>{
    if(err) next(err);
    let imgs = result;
    sql = "select * from hf_comment as a inner join hf_user as u on a.uid = u.uid where a.aid = ? and a.flag = 0";
    pool.query(sql,[id],(err,result)=>{
      if(err) next(err);
      res.send({
        details,imgs,result
      })
    })
    })
  })
})
// 获取首页视频部分
router.get('/video',function(req,res,next){
   // 获取客户端传递的page参数
  let page = req.query.page?req.query.page:1;
  let pagesize = 5;
  // 计算从第几条记录开始返回
  let offset = (page-1)*pagesize;
  let rowcount;
  let sql = 'select COUNT(vid) as count from hf_video'; 
  pool.query(sql,(err,result)=>{
      if(err)next(err);      
      rowcount = result[0].count;      
      let pagecount = Math.ceil(rowcount/pagesize)
      pool.query('select * from hf_video limit ?,?',[offset,pagesize],(err,result)=>{
      if(err) next(err);
      if(result.length>0){     
        res.send({ message: 'ok', code: 200, result: result, pagecount: pagecount });
      }
    })
  })
})
// 查询二级类别表
router.get('/stype',function(req,res,next){
  let id = req.query.id? req.query.id:1;
  pool.query('select * from hf_stype where fid =?',[id],(err,result)=>{
    if(err) next(err);
    if(result.length>0){     
      res.send({result});
    }
  })
})
// 按照type查询演出信息2:即将开始；1：进行中 3:表示活动已过期
router.get('/shows',function(req,res,next){
  // 获取类型
  let type = req.query.type? req.query.type:2;
   // 获取客户端传递的page参数
   let page = req.query.page?req.query.page:1;
   let pagesize = 10;
   // 计算从第几条记录开始返回
   let offset = (page-1)*pagesize;
  pool.query('select * from hf_show where isnow =? limit ?,?',[type,offset,pagesize],(err,result)=>{
    if(err) next(err);   
      res.send({result});
  })
})
// 查询演出的详情信息
router.get('/show',function(req,res,next){
  // 获取类型
  let id = req.query.id? req.query.id:1;
  pool.query('select * from hf_show where sid = ?',[id],(err,result)=>{
    if(err) next(err);
    if(result.length>0){     
      res.send({result});
    }
  })
})
// 查询雅集页轮播图
router.get('/lunbo',function(req,res,next){
  pool.query('select * from hf_carousel where type="2"',(err,result)=>{
    if(err) next(err);
    if(result.length>0){
      res.send(result);
    }
  })

})
// 按类别查询学堂列表
router.get('/studys',(req,res,next)=>{
  let type = req.query.type?req.query.type:'秒懂汉服';
  console.log(req.query.type)
    // 获取客户端传递的page参数
  let page = req.query.page?req.query.page:1;
  let pagesize = 10;
    // 计算从第几条记录开始返回
  let offset = (page-1)*pagesize;
  let sql = 'select * from hf_study where type= ? limit ?,?'
  pool.query(sql,[type,offset,pagesize],(err,result)=>{
    if(err) next(err);
    res.send(result);
  })
})
// 查询学堂的详细信息
router.get('/study',(req,res,next)=>{
  let id = req.query.id?req.query.id:1;
  let sql = 'select * from hf_study where ssid= ?'
  pool.query(sql,[id],(err,result)=>{
    if(err) next(err);
    res.send(result);
  })
})




module.exports = router;