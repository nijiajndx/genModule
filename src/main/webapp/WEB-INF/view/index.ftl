<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genModule</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/ligerUI/skins/Aqua/css/ligerui-all.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/ligerUI/skins/Gray/css/all.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/bootstrap/css/bootstrap.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>

    <script type="text/javascript" src="${cxt}/thirdParty/jquery/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/ligerUI/js/ligerui.all.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="${cxt}/js/indexdata.js"></script>
    <script type="text/javascript">
        var tab = null;
        var accordion = null;
        var tree = null;
        var tabItems = [];
        $(function () {

            //布局
            $("#layout1").ligerLayout({
                leftWidth: 190,
                height: '100%',
                heightDiff: -34,
                space: 4,
                onHeightChanged: f_heightChanged
            });

            var height = $(".l-layout-center").height();

            //Tab
            $("#framecenter").ligerTab({
                height: height,
                showSwitchInTab: true,
                showSwitch: true,
                onAfterAddTabItem: function (tabdata) {
                    tabItems.push(tabdata);
                    saveTabStatus();
                },
                onAfterRemoveTabItem: function (tabid) {
                    for (var i = 0; i < tabItems.length; i++) {
                        var o = tabItems[i];
                        if (o.tabid == tabid) {
                            tabItems.splice(i, 1);
                            saveTabStatus();
                            break;
                        }
                    }
                },
                onReload: function (tabdata) {
                    var tabid = tabdata.tabid;
                    addFrameSkinLink(tabid);
                }
            });

            //面板
            $("#accordion1").ligerAccordion({
                height: height - 24, speed: null
            });

            $(".l-link").hover(function () {
                $(this).addClass("l-link-over");
            }, function () {
                $(this).removeClass("l-link-over");
            });
            //树
            $("#tree1").ligerTree({
                data: indexdata,
                checkbox: false,
                slide: false,
                nodeWidth: 120,
                attribute: ['nodename', 'url'],
                render: function (a) {
                    if (!a.isnew) return a.text;
                    return '<a href="' + a.url + '" target="_blank">' + a.text + '</a>';
                },
                onSelect: function (node) {
                    if (!node.data.url) return;
                    if (node.data.isnew) {
                        return;
                    }
                    var tabid = $(node.target).attr("tabid");
                    if (!tabid) {
                        tabid = new Date().getTime();
                        $(node.target).attr("tabid", tabid)
                    }
                    f_addTab(tabid, node.data.text, node.data.url);
                }
            });

            tab = liger.get("framecenter");
            accordion = liger.get("accordion1");
            tree = liger.get("tree1");
            $("#pageloading").hide();

            css_init();
            pages_init();
        });
        function f_heightChanged(options) {
            if (tab)
                tab.addHeight(options.diff);
            if (accordion && options.middleHeight - 24 > 0)
                accordion.setHeight(options.middleHeight - 24);
        }
        function f_addTab(tabid, text, url) {
            tab.addTabItem({
                tabid: tabid,
                text: text,
                url: url,
                callback: function () {
                    addFrameSkinLink(tabid);
                }
            });
        }
        function addFrameSkinLink(tabid) {
            var prevHref = getLinkPrevHref(tabid) || "";
            var skin = getQueryString("skin");
            if (!skin) return;
            skin = skin.toLowerCase();
            attachLinkToFrame(tabid, prevHref + skin_links[skin]);
        }
        var skin_links = {
            "aqua": "lib/ligerUI/skins/Aqua/css/ligerui-all.css",
            "gray": "lib/ligerUI/skins/Gray/css/all.css",
            "silvery": "lib/ligerUI/skins/Silvery/css/style.css",
            "gray2014": "lib/ligerUI/skins/gray2014/css/all.css"
        };
        function pages_init() {
            var tabJson = $.cookie('liger-home-tab');
            if (tabJson) {
                var tabitems = JSON2.parse(tabJson);
                for (var i = 0; tabitems && tabitems[i]; i++) {
                    f_addTab(tabitems[i].tabid, tabitems[i].text, tabitems[i].url);
                }
            }
        }
        function saveTabStatus() {
            $.cookie('liger-home-tab', JSON2.stringify(tabItems));
        }
        function css_init() {
            var css = $("#mylink").get(0), skin = getQueryString("skin");

            if (!css || !skin) return;
            skin = skin.toLowerCase();
            $('body').addClass("body-" + skin);
            $(css).attr("href", skin_links[skin]);
        }
        function getQueryString(name) {
            var now_url = document.location.search.slice(1), q_array = now_url.split('&');
            for (var i = 0; i < q_array.length; i++) {
                var v_array = q_array[i].split('=');
                if (v_array[0] == name) {
                    return v_array[1];
                }
            }
            return false;
        }
        function attachLinkToFrame(iframeId, filename) {
            if (!window.frames[iframeId]) return;
            var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
            var fileref = window.frames[iframeId].document.createElement("link");
            if (!fileref) return;
            fileref.setAttribute("rel", "stylesheet");
            fileref.setAttribute("type", "text/css");
            fileref.setAttribute("href", filename);
            head.appendChild(fileref);
        }
        function getLinkPrevHref(iframeId) {
            if (!window.frames[iframeId]) return;
            var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
            var links = $("link:first", head);
            for (var i = 0; links[i]; i++) {
                var href = $(links[i]).attr("href");
                if (href && href.toLowerCase().indexOf("ligerui") > 0) {
                    return href.substring(0, href.toLowerCase().indexOf("lib"));
                }
            }
        }
    </script>
</head>
<body style="padding:0px;background:#EAEEF5;">
<div id="pageloading"></div>
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo">jQuery ligerUI 中文官方网站</div>
    <div class="l-topmenu-welcome">
        <a href="index.htm" class="l-link2">回首页</a>
        <span class="space">|</span>
        <a href="demo.aspx" class="l-link2">服务器版本</a>
        <span class="space">|</span>
        <a href="javascript:f_addTab('pay','捐赠','pay.htm')" class="l-link2" target="_blank">捐赠</a>
    </div>
</div>
<div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; ">
    <div position="left" title="主要菜单" id="accordion1">
        <div title="功能列表" class="l-scroll">
            <ul id="tree1" style="margin-top:3px;">
        </div>
        <div title="应用场景">
            <div style=" height:7px;"></div>
            <a class="l-link" href="http://www.ligerui.com/go.aspx?id=case" target="_blank">演示系统</a>
            <a class="l-link" href="javascript:f_addTab('listpage','列表页面','demos/case/listpage.htm')">列表页面</a>
            <a class="l-link" href="demos/dialog/win7.htm" target="_blank">模拟Window桌面</a>
            <a class="l-link" href="javascript:f_addTab('week','工作日志','demos/case/week.htm')">工作日志</a>
        </div>
        <div title="实验室">
            <div style=" height:7px;"></div>
            <a class="l-link" href="lab/generate/index.htm" target="_blank">表格表单设计器</a>
            <a class="l-link" href="lab/formdesign/index.htm" target="_blank">可视化表单设计</a>
        </div>
    </div>
    <div position="center" id="framecenter">
        <div tabid="home" title="我的主页" style="height:300px">
            <iframe frameborder="0" name="home" id="home" src="welcome.htm"></iframe>
        </div>
    </div>

</div>
<div style="height:32px; line-height:32px; text-align:center;">
    Copyright © 2011-2015 www.ligerui.com
    <a href="http://www.miitbeian.gov.cn/" target="_blank">粤ICP备09046932号-2</a>
</div>
<div style="display:none">
    <script src="http://s21.cnzz.com/stat.php?id=2970137&web_id=2970137" language="JavaScript"></script>
</div>
</body>
</html>
