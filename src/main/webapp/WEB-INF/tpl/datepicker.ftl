<#macro datepicker id="" name="" class="form-control" style="width:100%;"  label="字段名" default="" placeholder="" clear=true>
    <div class="form-group">
        <label for="${id!name}" class="col-sm-3 control-label">${label}</label>
        <div class="col-sm-9">
            <div class="input-group date">
                <input type="text" autocomplete="off"
                    <#include "/tpl/prop.ftl"/>
                    <#if default!="">
                       val="${default}"<#rt/>
                    </#if>
                >
                <#if clear>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                </#if>
                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
            </div>
        </div>
    </div>
</#macro>