<#macro datepicker id="" name="" class="form-control" style="width:100%;"  label="字段名" default="" placeholder="" >
<div class="form-group">
    <label for="${id!name}" class="col-sm-3 control-label">${label}</label>
    <div class="col-sm-9">
        <div class="input-group date">
            <input type="text"
                <#include "/tpl/prop.ftl"/>
                <#if default!="">
                   val="${default}"<#rt/>
                </#if>
            >
            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
    </div>
</div>
</#macro>