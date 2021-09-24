const mysql = require('mysql');
const pool = mysql.createPool({
    host: '127.0.0.1',   //MySQL服务器地址
    port: 3306,          //MySQL服务器端口号
    user: 'root',        //数据库用户的用户名
    password: '123456',        //数据库用户密码
    database: 'hf',    //数据库名称
    connectionLimit: 20, //最大连接数
    charset: 'utf8'      //数据库服务器的编码方式
  });

module.exports = pool;