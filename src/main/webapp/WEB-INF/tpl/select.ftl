<#macro select id="" name="" key="" class="" style="width:100%;"  blank=true default="" placeholder="" label="字段名">
<div class="form-group">
    <label for="${id!name}" class="col-sm-3 control-label">${label}</label>
    <div class="col-sm-9">
        <select<#rt/>
            <#include "/tpl/prop.ftl"/>
        >
            <#if blank != "">
                <option></option>
            </#if>
            <#if key != "">
                <#list codeLists[key] as item>
                    <option value="${item.id}" <#if default == item.id>selected</#if>>${item.text}</option>
                </#list>
            </#if>
        </select>
    </div>
</div>
</#macro>