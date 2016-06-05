<#macro buttonWrap offset="3" width="9" class="" align="center">
<div class="form-group">
    <div class="col-sm-offset-${offset} col-sm-${width}" style="text-align:${align}">
        <#nested />
    </div>
</div>
</#macro>