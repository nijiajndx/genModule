<#macro select id="" name="" key="" class="" blank=true default="" placeholder="">
<select
        <#if id !== "">
                id="${id}"
        </#if>
        <#if name !== "">
            name="${name}"
        </#if>
        <#if class !== "">
                class="${class}"
        </#if>
        <#if placeholder !== "">
                placeholder="${placeholder}"
        </#if>
>
    sads
    <#if blank !== "">
        <option></option>
    </#if>
    <#if key !== "">
        <#list sdata[key] as item>
            <option value="${item.id}" <#if default == item.id>selected</#if>>${item.text}</option>
        </#list>
    </#if>
</select>
</#macro>