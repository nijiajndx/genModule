<#macro textarea id="" name="" class="form-control"  label="字段名" default="" placeholder="" type="text">
<div class="form-group" xmlns="http://www.w3.org/1999/html">
    <label for="${id!name}" class="col-sm-3 control-label">${label}</label>
    <div class="col-sm-9">
        <textarea type="${type}"
            <#include "/tpl/prop.ftl"/>
        ><#rt/><#if default!="">${default}<#rt/></#if></textarea>
    </div>
</div>
</#macro>