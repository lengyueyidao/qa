package org.jiahao.qa.util;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.*;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.util.Version;
import org.jiahao.qa.pojo.Question;
import org.wltea.analyzer.lucene.IKAnalyzer;

/**
 * 搜索工具类，才用lucene和IKAnalyzer
 * Created by Alvin on 2016/12/7.
 */
public class SearchUtil {

    /* 创建简单中文分析器 创建索引使用的分词器必须和查询时候使用的分词器一样，否则查询不到想要的结果 */
    private static Analyzer analyzer = new IKAnalyzer(false);
    // 索引保存目录
    private static File indexFile = null;

    static {
        Properties prop = new Properties();
        InputStream in = SearchUtil.class.getResourceAsStream( "/sysparm.properties" );
        try {
            prop.load(in);
            String path = prop.getProperty("INDEX_DIR").trim();
            indexFile = new File(path);
        } catch (IOException e) {
            e.printStackTrace();
            indexFile = new File("c:/indexDir/");
        }
    }

    /**
     * 创建索引文件到磁盘中永久保存
     */
    public static void createIndexFile(List<Question> qs) {
        long startTime = System.currentTimeMillis();
        System.out.println("*****************创建索引开始**********************");
        Directory directory = null;
        IndexWriter indexWriter = null;
        try {
            // 创建哪个版本的IndexWriterConfig，根据参数可知lucene是向下兼容的，选择对应的版本就好
            IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_36, analyzer);
            // 创建磁盘目录对象
            directory = new SimpleFSDirectory(indexFile);
            indexWriter = new IndexWriter(directory, indexWriterConfig);
            // indexWriter = new IndexWriter(directory, analyzer, true,IndexWriter.MaxFieldLength.UNLIMITED);
            // 这上面是使用内存保存索引的创建索引写入对象的例子，和这里的实现方式不一样，但是效果是一样的


            // 为了避免重复插入数据，每次测试前 先删除之前的索引
            indexWriter.deleteAll();
            // 获取实体对象
            for (int i = 0; i < qs.size(); i++) {
                Question q = qs.get(i);
                // indexWriter添加索引
                Document doc = new Document();
                doc.add(new Field("id", q.getId().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field("title", q.getTitle().toString(),Field.Store.YES, Field.Index.ANALYZED));
                doc.add(new Field("content", q.getContent().toString(),Field.Store.YES, Field.Index.ANALYZED));
                doc.add(new Field("userid", q.getUserid().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field("views", q.getViews().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field("answers", q.getAnswers().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field("date", q.getDate().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field("isover", q.getIsover().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field("username", q.getUsername().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
                for(int j = 0; j < q.getTags().size(); j++) {
                    doc.add(new Field("tagid", q.getTags().get(j).getId().toString(), Field.Store.YES, Field.Index.NOT_ANALYZED));
                }
                // 添加到索引中去
                indexWriter.addDocument(doc);
                System.out.println("索引添加成功：第" + (i + 1) + "次！！");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (indexWriter != null) {
                try {
                    indexWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (directory != null) {
                try {
                    directory.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("创建索引文件成功，总共花费" + (endTime - startTime) + "毫秒。");
        System.out.println("*****************创建索引结束**********************");
    }

    /**
     * 直接读取索引文件，查询索引记录
     *
     * @throws IOException
     */
    public static void openIndexFile() {
        long startTime = System.currentTimeMillis();
        System.out.println("*****************读取索引开始**********************");
        List<Question> qs = new ArrayList<Question>();
        // 得到索引的目录
        Directory directory = null;
        IndexReader indexReader = null;
        try {
            directory = new SimpleFSDirectory(indexFile);
            // 根据目录打开一个indexReader
            indexReader = IndexReader.open(directory);
            //indexReader = IndexReader.open(directory,false);
            System.out.println("在索引文件中总共插入了" + indexReader.maxDoc() + "条记录。");
            // 获取第一个插入的document对象
            Document minDoc = indexReader.document(0);
            // 获取最后一个插入的document对象
            Document maxDoc = indexReader.document(indexReader.maxDoc() - 1);
            // document对象的get(字段名称)方法获取字段的值
            System.out.println("第一个插入的document对象的标题是：" + minDoc.get("title"));
            System.out.println("最后一个插入的document对象的标题是：" + maxDoc.get("title"));
            //indexReader.deleteDocument(0);
            int docLength = indexReader.maxDoc();
            for (int i = 0; i < docLength; i++) {
                Document doc = indexReader.document(i);
                Question q = new Question();
                if (doc.get("id") == null) {
                    System.out.println("id为空");
                } else {
                    q.setId(doc.get("id"));
                    q.setTitle(doc.get("title"));
                    q.setContent(doc.get("content"));
                    qs.add(q);
                }
            }
            System.out.println("显示所有插入的索引记录：");
            for (Question q : qs) {
                System.out.println(q);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (indexReader != null) {
                try {
                    indexReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (directory != null) {
                try {
                    directory.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("直接读取索引文件成功，总共花费" + (endTime - startTime) + "毫秒。");
        System.out.println("*****************读取索引结束**********************");
    }

    /**
     * 查看IKAnalyzer 分词器是如何将一个完整的词组进行分词的
     *
     * @param text
     * @param isMaxWordLength
     */
    public static void splitWord(String text, boolean isMaxWordLength) {
        try {
            // 创建分词对象
            Analyzer analyzer = new IKAnalyzer(isMaxWordLength);
            StringReader reader = new StringReader(text);
            // 分词
            TokenStream ts = analyzer.tokenStream("", reader);
            CharTermAttribute term = ts.getAttribute(CharTermAttribute.class);
            // 遍历分词数据
            System.out.print("IKAnalyzer把关键字拆分的结果是：");
            while (ts.incrementToken()) {
                System.out.print("【" + term.toString() + "】");
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println();
    }

    /**
     * 根据关键字实现全文检索
     */
    public static HashMap searchIndexFile(String keyword, Integer startPos, Integer pageSize, Integer iso, String tagid) {

        HashMap map = new HashMap();
        int total = 0;
        long startTime = System.currentTimeMillis();
        System.out.println("*****************查询索引开始**********************");
        IndexReader indexReader = null;
        IndexSearcher indexSearcher = null;
        List<Question> qs = new ArrayList<Question>();
        try {
            indexReader = IndexReader.open(FSDirectory.open(indexFile));
            // 创建一个排序对象，其中SortField构造方法中，第一个是排序的字段，第二个是指定字段的类型，第三个是是否升序排列，true：升序，false：降序。
            //Sort sort = new Sort(new SortField[] {new SortField("title", SortField.STRING, false),new SortField("content", SortField.STRING, false) });
            //Sort sort = new Sort();
            // 创建搜索类
            indexSearcher = new IndexSearcher(indexReader);
            // 下面是创建QueryParser 查询解析器
            // QueryParser支持单个字段的查询，但是MultiFieldQueryParser可以支持多个字段查询，建议用后者这样可以实现全文检索的功能。
            // QueryParser queryParser = new QueryParser(Version.LUCENE_36, "title", analyzer);
            QueryParser queryParser = new MultiFieldQueryParser(Version.LUCENE_36, new String[] { "title", "content" },analyzer);
            // 利用queryParser解析传递过来的检索关键字，完成Query对象的封装
            Query query2 = queryParser.parse(keyword);
            BooleanQuery query=new BooleanQuery();
            if(iso != null && !"".equals(iso)) {
                Query query1 = new TermQuery(new Term("isover", iso.toString()));
                query.add(query1, BooleanClause.Occur.MUST);
            }
            if(tagid != null && !"".equals(tagid)) {
                Query query3 = new TermQuery(new Term("tagid", tagid.toString()));
                query.add(query3, BooleanClause.Occur.MUST);
            }
            query.add(query2, BooleanClause.Occur.MUST);
            //splitWord(keyword, true); // 显示拆分结果
            // 执行检索操作
            TopDocs topDocs = indexSearcher.search(query, Integer.MAX_VALUE, new Sort(new SortField[]{SortField.FIELD_SCORE}));
            System.out.println("一共查到:" + topDocs.totalHits + "记录");
            ScoreDoc[] scoreDoc = topDocs.scoreDocs;
            // 像百度，谷歌检索出来的关键字如果有，除了显示在列表中之外还会高亮显示。Lucenen也支持高亮功能，正常应该是<font color='red'><font color='red'>这里用【】替代，使效果更加明显
            SimpleHTMLFormatter simpleHtmlFormatter = new SimpleHTMLFormatter("", "");
            // 具体怎么实现的不用管，直接拿来用就好了。
            Highlighter highlighter = new Highlighter(simpleHtmlFormatter,new QueryScorer(query));

            total = scoreDoc.length;
            int start = startPos<1?1:startPos;
            int end = (startPos + pageSize) > total ? total : (startPos + pageSize);

            for (int i = start-1; i < end; i++) {
                // 内部编号 ,和数据库表中的唯一标识列一样
                int doc = scoreDoc[i].doc;
                // 根据文档id找到文档
                Document mydoc = indexSearcher.doc(doc);

                String id = mydoc.get("id");
                String title = mydoc.get("title");
                String content = mydoc.get("content");
                String userid = mydoc.get("userid");
                String views = mydoc.get("views");
                String answers = mydoc.get("answers");
                String date = mydoc.get("date");
                String isover = mydoc.get("isover");
                String username = mydoc.get("username");
               /* TokenStream tokenStream = null;
                if (title != null && !title.equals("")) {
                    tokenStream = analyzer.tokenStream("title",new StringReader(title));
                    title = highlighter.getBestFragment(tokenStream, title);
                }
                if (content != null && !content.equals("")) {
                    tokenStream = analyzer.tokenStream("content",new StringReader(content));
                    // 传递的长度表示检索之后匹配长度，这个会导致返回的内容不全
                    //highlighter.setTextFragmenter(new SimpleFragmenter(content.length()));
                    content = highlighter.getBestFragment(tokenStream, content);
                }
                // 需要注意的是 如果使用了高亮显示的操作，查询的字段中没有需要高亮显示的内容 highlighter会返回一个null回来。*/
                Question q = new Question();
                q.setId(id);
                q.setTitle(title == null ? mydoc.get("title") : title);
                q.setContent(content == null ? mydoc.get("content") : content);
                q.setUserid(userid);
                q.setViews(Integer.parseInt(views));
                q.setAnswers(Integer.parseInt(answers));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                try {
                    q.setDate(sdf.parse(date));
                } catch (java.text.ParseException e) {
                    e.printStackTrace();
                }
                q.setIsover(Integer.parseInt(isover));
                q.setUsername(username);
                qs.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (indexSearcher != null) {
                try {
                    indexSearcher.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
            if (indexReader != null) {
                try {
                    indexReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        //System.out.println("根据关键字" + keyword + "检索到的结果如下：");
        /*for (Question q : qs) {
            System.out.println(q);
        }*/
        long endTime = System.currentTimeMillis();
        System.out.println("全文索引文件成功，总共花费" + (endTime - startTime) + "毫秒。");
        System.out.println("*****************查询索引结束**********************");

        map.put("total", total);
        map.put("questions", qs);

        return map;

    }

    /**
     * 更新索引
     */
    public static void updateIndexFile(Question q) {
        long startTime = System.currentTimeMillis();
        System.out.println("*****************更新索引开始**********************");
        IndexWriter indexWriter = null;
        Directory directory = null;
        try {
            directory = FSDirectory.open(indexFile);
            IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_36, analyzer);
            indexWriter = new IndexWriter(directory, indexWriterConfig);
            /**
             * Lucene并没有提供更新，这里的更新操作其实是如下两个操作的合集 先删除之后再添加
             */
            Document doc = new Document();
            doc.add(new Field("id", q.getId().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("title", q.getTitle().toString(),Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("content", q.getContent().toString(),Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("userid", q.getUserid().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("views", q.getViews().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("answers", q.getAnswers().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("date", q.getDate().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("isover", q.getIsover().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("username", q.getUsername().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            for(int j = 0; j < q.getTags().size(); j++) {
                doc.add(new Field("tagid", q.getTags().get(j).getId().toString(), Field.Store.YES, Field.Index.NOT_ANALYZED));
            }
            indexWriter.updateDocument(new Term("id", q.getId()), doc);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (indexWriter != null) {
                    indexWriter.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("更新索引文件成功，总共花费" + (endTime - startTime) + "毫秒。");
        System.out.println("*****************更新索引结束**********************");
    }

    /**
     * 删除索引
     */
    public static void deleteIndexFile(String id) {
        long startTime = System.currentTimeMillis();
        System.out.println("*****************删除索引开始**********************");
        IndexWriter indexWriter = null;
        Directory directory = null;
        try {
            directory = FSDirectory.open(indexFile);
            IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_36, analyzer);
            indexWriter = new IndexWriter(directory, indexWriterConfig);
            /**
             * 参数是一个选项，可以是一个Query，也可以是一个term，term是一个精确查找的值
             * 此时删除的文档并不会被完全删除，而是存储在一个回收站中的，可以恢复
             * 注意Term构造器的意思，第一个参数为Field，第二个参数为Field的值
             */
            indexWriter.deleteDocuments(new Term("id", id));

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (indexWriter != null) {
                    indexWriter.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("删除索引文件成功，总共花费" + (endTime - startTime) + "毫秒。");
        System.out.println("*****************删除索引结束**********************");
    }

    /**
     * 新增索引文件
     */
    public static void addIndexFile(Question q) {
        long startTime = System.currentTimeMillis();
        System.out.println("*****************新增索引开始**********************");
        Directory directory = null;
        IndexWriter indexWriter = null;
        try {
            // 创建哪个版本的IndexWriterConfig，根据参数可知lucene是向下兼容的，选择对应的版本就好
            IndexWriterConfig indexWriterConfig = new IndexWriterConfig(Version.LUCENE_36, analyzer);
            // 创建磁盘目录对象
            directory = FSDirectory.open(indexFile);
            indexWriter = new IndexWriter(directory, indexWriterConfig);
            // indexWriter添加索引
            Document doc = new Document();
            doc.add(new Field("id", q.getId().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("title", q.getTitle().toString(),Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("content", q.getContent().toString(),Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("userid", q.getUserid().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("views", q.getViews().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("answers", q.getAnswers().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("date", q.getDate().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("isover", q.getIsover().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("username", q.getUsername().toString(),Field.Store.YES, Field.Index.NOT_ANALYZED));
            for(int j = 0; j < q.getTags().size(); j++) {
                doc.add(new Field("tagid", q.getTags().get(j).getId().toString(), Field.Store.YES, Field.Index.NOT_ANALYZED));
            }
            // 添加到索引中去
            indexWriter.addDocument(doc);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (indexWriter != null) {
                try {
                    indexWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (directory != null) {
                try {
                    directory.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        long endTime = System.currentTimeMillis();
        System.out.println("新增索引文件成功，总共花费" + (endTime - startTime) + "毫秒。");
        System.out.println("*****************新增索引结束**********************");
    }

}
