import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * Created by Alvin on 2016/11/8.
 */
public class t {
    public static void main(String[] args) {

        /*String json = " {\"title\":\"这是标题\",content\":\"这是内容\",\"tags\":[{\"tag\":\"标签1\"},{\"tag\":\"标签2\"},{\"tag\":\"标签3\"}]}";
        JSONObject obj = JSON.parseObject(json);
        System.out.println(obj.getString("title"));
        System.out.println(obj.getString("content"));*/
        JSONObject json = new JSONObject();
        json.put("title", "这是标题");
        json.put("content", "这是内容");
        JSONArray array = new JSONArray();
        JSONObject json1 = new JSONObject();
        json1.put("tag", "标签1");
        JSONObject json2 = new JSONObject();
        json2.put("tag", "标签2");
        JSONObject json3 = new JSONObject();
        json3.put("tag", "标签3");
        array.add(json1);
        array.add(json2);
        array.add(json3);
        json.put("tags",array);
        System.out.println(json.toJSONString());

    }
}
