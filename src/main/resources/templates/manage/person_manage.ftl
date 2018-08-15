<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title>迪乐尼后台管理系统</title>
    <link rel="stylesheet" href="/layui-v2.2.6/layui/css/layui.css"/>
    <style>
        .layui-layer-btn0 {
            border-color: #009688!important;
            background-color: #009688!important;
        }

        /* 表格复选框位置下调 */
        .layui-table-cell .layui-form-checkbox[lay-skin=primary] {
            top: 10px;
        }
    </style>
</head>
<body>
<div class="layui-container" style="margin-top: 30px;margin-left: 20px !important;margin-right: 20px !important;width: 95%">
    <div class="layui-row">
        <div class="layui-col-md12">
            <fieldset class="layui-elem-field layui-field-title">
                <legend id="weekReportDetailTitle">会员管理</legend>
            </fieldset>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md6">
            <form class="layui-form layui-form-pane" onsubmit="return false;">
                <div class="layui-form-item" style="float: right">
                    <div class="layui-inline">
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="realNameOrPhoneOrCardNum" id="realNameOrPhoneOrCardNum" placeholder="会员姓名 / 电话 / 卡号" lay-verify="required" onkeydown="globelQuery(event);" />
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="layui-col-md6">
            <div class="personTableBtns" style="float: left">
                <button class="layui-btn" data-type="searchPersonBtn">
                    <i class="layui-icon">&#xe615;&nbsp;查询</i>
                </button>
                <button class="layui-btn" data-type="refreshPersonTableBtn">
                    <i class="layui-icon">&#xe9aa;&nbsp;刷新</i>
                </button>
                <button class="layui-btn" data-type="addPersonBtn">
                    <i class="layui-icon">&#xe654;&nbsp;添加</i>
                </button>
            </div>
        </div>
    </div>

    <div class="layui-row">
        <table id="personInfo" lay-filter="personInfo"></table>
    </div>
</div>

<script type="text/html" id="personTablebar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script src="/layui-v2.2.6/layui/layui.js" charset="utf-8"></script>
<script src="/jquery-3.3.1.min.js"></script>

<script>

    /* 点击回车，触发搜索按钮 */
    function globelQuery(e) {
        if (!e)
            e = window.event;
        if ((e.keyCode || e.which) === 13) {
            $("#searchPersonBtn").click();
        }
    }

    layui.use('table', function(){
        var table = layui.table;

        /* 初始化表格 */
        table.render({
            elem: '#personInfo'
            ,url: '/person/findAll?timestamp=' + new Date().getTime()
            ,cols: [[
                {type:'checkbox'}
                ,{field: 'id', title: 'ID', align: 'center', width:80}
                ,{field: 'realName', title: '会员姓名', align: 'center', width:120}
                ,{field: 'phone', title: '电话', align: 'center', width:120}
                ,{field: 'levelName', title: '会员级别', align: 'center', width: 120}
                ,{field: 'cardNum', title: '会员卡号', align: 'center', width: 120}
                ,{field: 'statusName', title: '会员状态', align: 'center', width: 120}
                ,{field: 'xfNum', title: '总共消费次数', align: 'center', width:120, style:'background-color: #91bdac;color: #ffffff', event: 'findPersonSpending'}
                ,{field: 'shengyuNum', title: '剩余可消费次数', align: 'center', width:150}
                ,{field: 'makeCardTime', title: '办卡时间', align: 'center', width: 150}
                ,{field: 'endDate', title: '停用时间', align: 'center', width: 150}
                ,{title: '操作', align: 'center', toolbar: '#personTablebar', width: 200, fixed: 'right'}
            ]]
            ,page: {
                curr: ${(page?c)!'1'}
                ,limit: ${(limit?c)!'10'}
            }
            ,size: 'lg'
            ,id: 'personInfo'
            ,done: function(){
                $("[data-field='id']").css('display','none');
            }
        });

        /* 监听单元格点击事件 */
        table.on('tool(personInfo)', function(obj){
            var data = obj.data;
            var personId = data.id;

            /* 查询会员消费历史 */
            if(obj.event === 'findPersonSpending'){
                layer.open({
                    type: 2,
                    shade: false,
                    area: ['500px', '500px'],
                    maxmin: true,
                    content: '/page/personSpending?personId=' + personId + '&timestamp=' + new Date().getTime(),
                    zIndex: layer.zIndex, //重点1
                    success: function(layero){
                        layer.setTop(layero); //重点2
                    }
                });
            }
            /* 查询会员信息 */
            if(obj.event === 'detail'){
                var page = setPage();
                var limit = setLimit();
                window.location.href = '/page/person_info?personId=' + personId + '&page=' + page + '&limit=' + limit;
            }
            /* 删除会员信息 */
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        type: 'POST'
                        ,url: '/person/delete'
                        ,data: {ids: personId}
                        ,async: false
                        ,dataType: 'json'
                        ,success: function (data) {
                            obj.del();
                            layer.msg(data.msg,
                                    {
                                        anim: 0, time: 1500
                                    });
                        }
                    });
                    layer.close(index);
                });
            }
            /* 编辑会员信息 */
            if(obj.event === 'edit'){
                var page = setPage();
                var limit = setLimit();
                window.location.href = '/page/edit_person?personId=' + personId + '&page=' + page + '&limit=' + limit;
            }

        });


        var $ = layui.$, active = {
            /* 点击查询按钮 */
            searchPersonBtn: function () {
                var realNameOrPhoneOrCardNum = $('#realNameOrPhoneOrCardNum').val();
                table.reload('personInfo', {
                    url: '/person/findPerson?timestamp=' + new Date().getTime()
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                        ,limit: 10
                    }
                    ,where: { realNameOrPhoneOrCardNum: realNameOrPhoneOrCardNum }
                });
            }

            /* 点击刷新按钮 */
            ,refreshPersonTableBtn: function () {
                $('#realNameOrPhoneOrCardNum').val('');
                table.reload('personInfo', {
                    url: '/person/findAll?timestamp=' + new Date().getTime()
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                        ,limit: 10
                    }
                });
            }

            /* 点击添加按钮 */
            ,addPersonBtn: function () {
                var page = setPage();
                var limit = setLimit();
                window.location.href = '/page/add_person?page=' + page + '&limit=' + limit;
            }
        };
        $('.personTableBtns .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

    function setPage() {
        var page = $('.layui-laypage-curr').children('em:last-child').html();
        var reg = /^\+?[1-9][0-9]*$/;
        if (reg.test(page)) {
            return page;
        }else {
            return 1;
        }
    }
    function setLimit() {
        var limit = $('.layui-laypage-limits').children('select:last-child').val();
        var reg = /^\+?[1-9][0-9]*$/;
        if (reg.test(limit)) {
            return limit;
        }else {
            return 10;
        }
    }
</script>
</body>
</html>