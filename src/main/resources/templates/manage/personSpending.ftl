<link rel="stylesheet" href="/layui-v2.2.6/layui/css/layui.css"/>
<div  class="layui-container" style="margin-top: 10px;margin-left: 20px !important;margin-right: 20px !important;width: 95%">
    <div class="layui-row">
        <div class="layui-col-md12">
            <a style="color: #128574">消费历史记录</a>
            <hr class="layui-bg-green">
        </div>
    </div>

    <div class="layui-row">
        <table id="personSpending" lay-filter="personSpending"></table>
    </div>
</div>
<script src="/layui-v2.2.6/layui/layui.js" charset="utf-8"></script>
<script src="/jquery-3.3.1.min.js"></script>

<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#personSpending'
            ,url: '/personSpending/findByPersonId?timestamp=' + new Date().getTime()
            ,where: {personId: ${personId?c} }
            ,width: 444
            ,cols: [[
                {field: 'personName', title: '会员姓名', width:120}
                ,{field: 'xfNum', title: '划掉次数', width:120}
                ,{field: 'xfTime', title: '消费时间', width: 200}
            ]]
        });
    });

</script>