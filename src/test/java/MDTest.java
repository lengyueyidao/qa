import org.pegdown.PegDownProcessor;

/**
 * Created by Alvin on 2016/10/30.
 */
public class MDTest {
    public static void main(String[] args) {

        PegDownProcessor pdp = new PegDownProcessor(Integer.MAX_VALUE);
        System.out.println(pdp.markdownToHtml("### 服务端测试结果\n" +
                "\n" +
                "UserSystem_BasicDataService_TestCase_20160415110013 测试完成，共7个测试用例，成功6个，失败1个。\n" +
                "\n" +
                "| 用例名称 | HTTP请求描述 | URL | 断言类型 | 错误描述 |\n" +
                "| -----|:----:|:----:|:----:|:----:|\n" +
                "| SuiFang_UserSystem_Hospital 1-1   | HttpRequest_getHospital4.2   | [链接](http://dict.xingshulin.com/cdsw/default/data/hospital/1/%e5%8c%97%e4%ba%ac%e4%ba%ac%e5%8c%97/0/100)  | jp@gc - JSON Content Assertion  |  ERROR!!! key:id,expectedValue:294,actualValue:283 ERROR!!! key:name,expectedValue:北京京北医院,actualValue:北京市海淀区北下关医院   |\n" +
                "\n" +
                "[详细日志](http://www.baidu.com)"));

    }
}
