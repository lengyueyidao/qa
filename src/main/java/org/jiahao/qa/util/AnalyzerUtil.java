package org.jiahao.qa.util;

import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

/**
 * 分词工具类
 * Created by Alvin on 2016/11/5.
 */
public class AnalyzerUtil {

    public static List<String> analyze(String q) throws IOException {
        List<String> list = new ArrayList<String>();

        //创建IKAnalyzer中文分词对象
        IKAnalyzer analyzer = new IKAnalyzer();
        // 使用智能分词
        analyzer.setUseSmart(true);

        TokenStream tokenStream = analyzer.tokenStream("content",
                new StringReader(q));
        tokenStream.addAttribute(CharTermAttribute.class);
        while (tokenStream.incrementToken()) {
            CharTermAttribute charTermAttribute = tokenStream
                    .getAttribute(CharTermAttribute.class);
            System.out.println(charTermAttribute.toString());
            list.add(charTermAttribute.toString());
        }
        return list;
    }

}
