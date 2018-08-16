<!DOCTYPE html><html><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>迪乐尼婴童游泳馆后台管理系统</title>
    <link rel="stylesheet" href="/layui-v2.2.6/layui/css/layui.css">
    <style>
        .layui-layout-admin .layui-header {
            height: 100px!important;
        }
        .layui-layout-admin .layui-logo {
            width: 100%;
            position: relative;
            left: 50px;
            text-align: left;
            vertical-align: middle;
        }
        .layui-side {
            top: 100px !important;
            width: 250px !important;
        }
        .layui-side-scroll {
            width: 250px !important;
        }
        .layui-nav-tree {
            width: 250px !important;
        }
        .layui-icon {
            font-size: 20px !important;
        }
        .layui-body {
            top: 100px!important;
            left: 250px !important;
        }
        .layui-footer {
            left: 250px !important;
        }
    </style>
</head>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><img src="/img/dirolep_logo.png" height="80" style="margin-top: 10px"><img src="/img/logo_font.png" height="80"></div>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;"><i class="layui-icon">&#xe629;&nbsp;&nbsp;&nbsp;会员管理</i></a>
                    <dl class="layui-nav-child">
                        <dd><a href="/page/search_person_print" target="layui-body">打印消费单</a></dd>
                        <dd><a href="/page/person_manage" target="layui-body">会员管理</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon">&#xe614;&nbsp;&nbsp;&nbsp;基础数据管理</i></a>
                    <dl class="layui-nav-child">
                        <dd><a href="/page/add_level" target="layui-body">会员级别</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
    <#-- 内容主体区域 -->
        <iframe name="layui-body" id="layui-body" frameborder="0" width=100% height=98%></iframe>
    </div>
    <div class="layui-footer">
        Powered by XY © 2018 XY All Rights Reserved
    </div>
</div>

<script src="/layui-v2.2.6/layui/layui.js"></script>
<script src="/jquery-3.3.1.min.js"></script>

<script>
    layui.use('element', function(){
        var element = layui.element;
    });
</script>
</body>
</html>