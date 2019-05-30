


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2019/5/27
 *     desc  : log日志工具类
 *     revise:
 * </pre>
 */
class LogUtils{

  ///打印日志
  static log(String str){
    if(str.isNotEmpty){
      print("yc---------" + str);
    }
  }

  ///打印日志
  static showPrint(String msg){
    if(msg!=null){
      print("yc---------" + msg);
    }
  }

}