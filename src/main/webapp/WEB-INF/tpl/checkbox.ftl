<#macro checkbox id="" name="" class="form-control" style="width:100%;"  data=[] key="" label="字段名" default=[] >
<div class="form-group">
    <div class="col-sm-offset-3 col-sm-9">
        <div class="checkbox">
            <#if data?size ==0>
               <#assign d = (codeLists[key]) />
            <#else>
                <#assign  d= data/>
            </#if>
                <#list d as item>
                    <label>
                        <#if default?size gt 0>
                            <#assign f=false/>
                            <#list default as v>
                                <#if v == item.id>
                                    <#assign  f = true/>
                                </#if>
                            </#list>
                            <#if f>
                                <input type="checkbox" id="${id!name}" name="${name}" value="${item.id}" checked>${item.text}
                            <#else>
                                <input type="checkbox" id="${id!name}" name="${name}" value="${item.id}">${item.text}
                            </#if>
                        <#else>
                            <input type="checkbox" id="${id!name}" name="${name}" value="${item.id}">${item.text}
                        </#if>
                    </label>
                </#list>
        </div>
    </div>
</div>
</#macro>