<#macro input id="" name="" class="form-control" style="width:100%;"  label="字段名" default="" placeholder="" type="text">
<div class="form-group">
    <label for="${id!name}" class="col-sm-3 control-label">${label}</label>
    <div class="col-sm-9">
        <input type="${type}"
               <#include "/tpl/prop.ftl"/>
                <#if default!="">
                    val="${default}"<#rt/>
                </#if>
        >
    </div>
</div>
</#macro>