package org.jiahao.qa.service;

import org.jiahao.qa.pojo.Tag;

import java.util.List;

/**
 * Created by Alvin on 2016/10/4.
 */
public interface TagService {

    /**
     * 添加标签
     * @param tag
     * @return
     */
    int addTag(Tag tag);

    /**
     * 修改标签
     * @param tag
     * @return
     */
    int updateTag(Tag tag);

    /**
     * 删除标签
     * @param id
     * @return
     */
    int deleteTag(String id);

    /**
     * 查询标签列表（包含了标签对应的问题数）分页
     * @param startPage
     * @param pageSize
     * @param q 查询
     * @return
     */
    List<Tag> getTags(Integer startPage, Integer pageSize, String q);

    /**
     * 根绝问题id获取对应标签
     * @param questionid
     * @return
     */
    List<Tag> getTagsByQuestionId(String questionid);

    /**
     * 获取标签总数
     * @param q
     * @return
     */
    int getTagCount(String q);

    /**
     * 判断是否存在对应name的标签
     * @param name
     * @return
     */
    int isExistTag(String name);
}
