package com.fmy.pojo;

/**
 * Created by njoe on 2016-06-03.
 */
public class Code {
    private String id;
    private String text;
    private int sort;

    public Code(String id, String text, int sort) {
        this.id = id;
        this.text = text;
        this.sort = sort;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }
}
