<#macro radio id="" name="" data=[] key="" label="字段名" default="" >
<div class="form-group">
    <div class="col-sm-offset-3 col-sm-9">
        <div class="radio">
            <#if data?size ==0>
                <#assign d = (codeLists[key]) />
            <#else>
                <#assign  d= data/>
            </#if>
            <#list d as item>
                <label>
                    <#if default == item.id>
                        <input type="radio" id="${id!name}" name="${name}" value="${item.id}" checked/>${item.text}
                    <#else>
                        <input type="radio" id="${id!name}" name="${name}" value="${item.id}"/>${item.text}
                    </#if>
                </label>
            </#list>
        </div>
    </div>
</div>
</#macro>