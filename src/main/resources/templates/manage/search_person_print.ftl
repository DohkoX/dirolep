<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <#--优先使用 IE 最新版本和 Chrome-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <#--360 使用Google Chrome Frame-->
    <meta name="renderer" content="webkit">
    <meta name="description" content="搜索用户，打印小票">
    <title>迪乐尼后台管理系统</title>
    <link rel="stylesheet" href="/layui-v2.2.6/layui/css/layui.css"/>
    <style>
        .layui-layer-btn0 {
            border-color: #009688!important;
            background-color: #009688!important;
        }
    </style>
</head>
<body>
<div class="layui-container" style="margin-top: 30px;margin-left: 20px !important;margin-right: 20px !important;width: 95%">
    <div class="layui-row">
        <div class="layui-col-md12">
            <fieldset class="layui-elem-field layui-field-title">
                <legend id="weekReportDetailTitle">打印票据</legend>
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
                    <i class="layui-icon">&#xe615;&nbsp;查找</i>
                </button>
                <button class="layui-btn" data-type="refreshPersonTableBtn">
                    <i class="layui-icon">&#xe9aa;&nbsp;刷新</i>
                </button>
            </div>
        </div>
    </div>

    <div class="layui-row">
        <table id="personInfo" lay-filter="personInfo"></table>
    </div>
</div>

<script type="text/html" id="printSpendingTicket">
    <a class="layui-btn" lay-event="printSpendingTicket">计次并打印小票</a>
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
            ,url: '/person/findAll'
            ,cols: [[
                {field: 'id', title: 'ID', align: 'center', width:80}
                ,{field: 'realName', title: '会员姓名', align: 'center', width:120}
                ,{field: 'phone', title: '电话', align: 'center', width:120}
                ,{field: 'levelName', title: '会员级别', align: 'center', width: 120}
                ,{field: 'cardNum', title: '会员卡号', align: 'center', width: 120}
                ,{field: 'statusName', title: '会员状态', align: 'center', width: 120}
                ,{field: 'xfNum', title: '总共消费次数', align: 'center', width:120, style:'background-color: #91bdac;color: #ffffff', event: 'findPersonSpending'}
                ,{field: 'shengyuNum', title: '剩余可消费次数', align: 'center', width:150}
                ,{field: 'makeCardTime', title: '办卡时间', align: 'center', width: 150}
                ,{field: 'endDate', title: '停用时间', align: 'center', width: 150}
                ,{field: 'remark', title: '备注', align: 'center', width: 200}
                ,{title: '操作', align: 'center', toolbar: '#printSpendingTicket', width: 200, fixed: 'right'}
            ]]
            ,page: {
                limit: 10
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
            var personName = data.realName;

            /* 查询会员 */
            if(obj.event === 'findPersonSpending'){
                layer.open({
                    type: 2,
                    shade: false,
                    area: ['500px', '500px'],
                    maxmin: true,
                    content: '/page/personSpending?personId=' + data.id,
                    zIndex: layer.zIndex, //重点1
                    success: function(layero){
                        layer.setTop(layero); //重点2
                    }
                });
            }
            /* 打印小票 */
            else if(obj.event === 'printSpendingTicket'){
                layer.prompt({
                    formType: 0,
                    value: '1',
                    title: '请输入划掉的次数',
                    maxlength: 50
                }, function(value, index){
                    layer.close(index);
                    $.ajax({
                        url: '/personSpending/save'
                        ,type: 'POST'
                        ,dataType: 'json'
                        ,data: {
                            personId: personId
                            ,xfNum: value
                        }
                        ,success: function (data) {
                            var realNameOrPhoneOrCardNum = $('#realNameOrPhoneOrCardNum').val();
                            layer.msg(data.msg);
                            //执行重载
                            table.reload('personInfo', {
                                url: '/person/findPerson?timestamp=' + new Date().getTime()
                                ,where: { realNameOrPhoneOrCardNum: '' === realNameOrPhoneOrCardNum ? personName : realNameOrPhoneOrCardNum }
                            });
                        }
                        ,error: function (data) {
                            layer.msg(data.message);
                        }
                    });
                });
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
                    ,where: {realNameOrPhoneOrCardNum: realNameOrPhoneOrCardNum}
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
        };
        $('.personTableBtns .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

</script>
</body>
</html>