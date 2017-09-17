package com.csx.workflow.model;

import java.io.Serializable;
import java.util.List;

/**
 *分页需要的数据
 */
public class Page implements Serializable {
    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }



    @Override
    public String toString() {
        return "Page{" +
                "page=" + page +
                ", total=" + total +
                ", rows=" + rows +
                '}';
    }

    //当前页
    private Integer page;
    //总记录数
    public  Long getTotal() {
        return total;
    }public void setTotal(Long total) {
        this.total = total;
    }private Long total;

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }
    //每页的内容
    private List rows;
    //总页数
    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }
    //总页数
    private Integer totalPage;
}





