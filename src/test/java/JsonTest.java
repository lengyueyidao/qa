import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.jiahao.qa.service.QuestionService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.pegdown.PegDownProcessor;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-mybatis.xml")
public class JsonTest {

	@Resource
	private QuestionService questionService;

	@Test
	public void Test() {
		StringBuffer sb = new StringBuffer();
		try {
			String txtFilePath = "C:/data.json";//
			String tmpLineVal;
			InputStreamReader read = new InputStreamReader(new FileInputStream(
					txtFilePath), "utf-8");
			BufferedReader bufread = new BufferedReader(read);

			while ((tmpLineVal = bufread.readLine()) != null) {
				sb.append(tmpLineVal);
			}
			bufread.close();
			read.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		//String str = "{\"title\":\"{public}\"}";
		//System.out.println(sb.toString());
		JSONArray array = JSON.parseArray(sb.toString());
		//System.out.println(array.size());
		for(int i = 0; i < array.size(); i++) {
			JSONObject obj = array.getJSONObject(i);
			String title = obj.getString("title");
			String content = obj.getString("content");
			JSONArray arr = obj.getJSONArray("tags");
			StringBuffer sb1 = new StringBuffer();
			for(int j = 0; j < arr.size(); j++) {
				JSONObject obj1 = arr.getJSONObject(j);
				String tag = obj1.getString("tag");
				if(j == 0) {
					sb1.append(tag);
				}
				else {
					sb1.append(";"+tag);
				}
			}
			if(arr.size() > 0) {
				questionService.insertQuestion(title, content, "1", sb1.toString());
			}
			System.out.println("当前插入："+i);
		}

	}

}
