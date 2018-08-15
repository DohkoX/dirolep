<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title>迪乐尼后台管理系统</title>
    <link rel="stylesheet" href="/layui-v2.2.6/layui/css/layui.css"/>
    <style>
        .layui-table tbody tr:hover,.layui-table-hover {
            background-color: transparent;
        }
    </style>
</head>
<body>
<div class="layui-container" style="margin-top: 30px;margin-left: 20px !important;margin-right: 20px !important;width: 95%">
    <div class="layui-row">
        <button class="layui-btn" onclick="back()">
            <i class="layui-icon">&#xe65c;&nbsp;返回列表</i>
        </button>
    </div>

    <div class="layui-row">
        <div class="layui-col-md6">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>会员信息</legend>
            </fieldset>
        </div>
        <div class="layui-col-md4" style="float: right">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>会员消费历史记录</legend>
            </fieldset>
        </div>
    </div>

    <div class="layui-row">
        <div class="layui-col-md6">
            <table class="layui-table" lay-even lay-skin="nob">
                <colgroup>
                    <col width="150">
                    <col>
                </colgroup>
                <thead>
                    <tr>
                        <td>会员姓名</td>
                        <td id="realName"></td>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>电话</td>
                    <td id="phone"></td>
                </tr>
                <tr>
                    <td>会员卡类别</td>
                    <td id="levelName"></td>
                </tr>
                <tr>
                    <td>会员卡号</td>
                    <td id="cardNum"></td>
                </tr>
                <tr>
                    <td>办卡时间</td>
                    <td id="makeCardTime"></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td id="statusName"></td>
                </tr>
                <tr>
                    <td>已消费次数</td>
                    <td id="xfNum"></td>
                </tr>
                <tr>
                    <td>剩余次数</td>
                    <td id="shengyuNum"></td>
                </tr>
                <tr>
                    <td>停用日期</td>
                    <td id="endDate"></td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td id="remark"></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="layui-col-md4" style="float: right">
            <table lay-even lay-skin="line" id="personSpending" lay-filter="personSpending"></table>
        </div>
    </div>
</div>

<script src="/layui-v2.2.6/layui/layui.js" charset="utf-8"></script>
<script src="/jquery-3.3.1.min.js"></script>

<script>
    $(document).ready(function(){
        $.ajax({
            type: 'GET'
            ,url: '/person/findPersonById?id=' + ${personId?c}
            ,async: false
            ,dataType: 'json'
            ,success: function (data) {
                $('#realName').html(data.data.realName);
                $('#phone').html(data.data.phone);
                $('#levelName').html(data.data.levelName);
                $('#cardNum').html(data.data.cardNum);
                $('#makeCardTime').html(data.data.makeCardTime);
                $('#statusName').html(data.data.statusName);
                $('#remark').html(data.data.remark);
                $('#xfNum').html(data.data.xfNum);
                $('#shengyuNum').html(data.data.shengyuNum);
                $('#endDate').html(data.data.endDate);
            }
        });
    });

    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#personSpending'
            ,url: '/personSpending/findByPersonId?timestamp=' + new Date().getTime()
            ,where: {personId: ${personId?c} }
            ,cols: [[
                {field: 'personName', title: '会员姓名' }
                ,{field: 'xfNum', title: '划掉次数' }
                ,{field: 'xfTime', title: '消费时间' }
            ]]
        });
    });

    function back() {
        window.location.href = '/page/person_manage?page=' + ${page?c} + '&limit=' + ${limit?c};
    }
</script>

</body>
</html>