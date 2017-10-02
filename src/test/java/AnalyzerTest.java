/**
 * Created by Alvin on 2016/11/5.
 */
import java.io.StringReader;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.wltea.analyzer.lucene.IKAnalyzer;

public class AnalyzerTest {
    public static void main(String[] args) {
        String keyWord1 = "IKAnalyzer的分词效果到底怎么样呢，我们来看一下吧";
        String keyWord2 = "Java虚拟机的运行的原理是怎么样的？";
        String keyWord = "mysql中INSTR函数的用法INSTR(字段名, 字符串)这个函数返回字符串在某一个字段的内容中的位置, 没有找到字符串返回0,否则返回位置(从1开始)####";
        String keyWord3 = "喜欢";
        //创建IKAnalyzer中文分词对象
        IKAnalyzer analyzer = new IKAnalyzer();
        // 使用智能分词
        analyzer.setUseSmart(true);
        // 打印分词结果
        try {
            printAnalysisResult(analyzer, keyWord3);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 打印出给定分词器的分词结果
     *
     * @param analyzer
     *            分词器
     * @param keyWord
     *            关键词
     * @throws Exception
     */
    private static void printAnalysisResult(Analyzer analyzer, String keyWord)
            throws Exception {
        System.out.println("["+keyWord+"]分词效果如下");
        TokenStream tokenStream = analyzer.tokenStream("content",
                new StringReader(keyWord));
        tokenStream.addAttribute(CharTermAttribute.class);
        while (tokenStream.incrementToken()) {
            CharTermAttribute charTermAttribute = tokenStream
                    .getAttribute(CharTermAttribute.class);
            System.out.println(charTermAttribute.toString());

        }
    }
}