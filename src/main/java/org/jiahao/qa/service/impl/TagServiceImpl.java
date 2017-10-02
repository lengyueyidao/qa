package org.jiahao.qa.service.impl;

import org.jiahao.qa.dao.TagMapper;
import org.jiahao.qa.pojo.Tag;
import org.jiahao.qa.service.TagService;
import org.jiahao.qa.util.Page;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Alvin on 2016/10/4.
 */
@Service("tagService")
public class TagServiceImpl implements TagService {

    @Resource
    private TagMapper tagMapper;

    public int addTag(Tag  tag) {
        return tagMapper.insert(tag);
    }

    public int updateTag(Tag tag) {
        return tagMapper.updateByPrimaryKey(tag);
    }

    public int deleteTag(String id) {
        return tagMapper.deleteByPrimaryKey(id);
    }

    public List<Tag> getTags(Integer startPos, Integer pageSize, String q) {
        return tagMapper.selectTagList(startPos, pageSize, q);
    }

    public List<Tag> getTagsByQuestionId(String questionid) {
        return tagMapper.selectTagsByQuestionId(questionid);
    }

    public int getTagCount(String q) {
        return tagMapper.selectTagCount(q);
    }

    public int isExistTag(String name) {

        int r = 0;
        try {
            Tag tag = tagMapper.selectByName(name);
            if(tag != null) {
                r = 1;
            }
        }catch (Exception e) {
            e.printStackTrace();
            r = 0;
        }

        return r;
    }
}
