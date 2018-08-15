<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title>迪乐尼后台管理系统</title>
    <link rel="stylesheet" href="/layui-v2.2.6/layui/css/layui.css"/>

    <style>
        .layui-container {
            width: 95% !important;
            padding: 0 !important;
        }
        .layui-inline {
            width: 30% !important;
        }
        .layui-form-label-lg {
            width: 158px !important;
        }
        .layui-input-block-left {
            margin-left: 158px !important;
        }

        <#--webkit内核的浏览器-->
        input::-webkit-input-placeholder {
            /* placeholder颜色  */
            color: #cdcbcb;
            /* placeholder字体大小  */
            font-size: 12px;
        }
        textarea::-webkit-input-placeholder {
            /* placeholder颜色  */
            color: #cdcbcb;
            /* placeholder字体大小  */
            font-size: 12px;
        }
        <#--IE-->
        input:-ms-input-placeholder{
            /* placeholder颜色  */
            color: #cdcbcb;
            /* placeholder字体大小  */
            font-size: 12px;
        }
        textarea:-ms-input-placeholder{
            /* placeholder颜色  */
            color: #cdcbcb;
            /* placeholder字体大小  */
            font-size: 12px;
        }
        <#--输入框自动提示-->
        .ui-menu-item-wrapper:hover {
            border: none;
            background: #e6e6e6;
            color: #0C0C0C;
        }
        .ui-menu-item-wrapper {
            font: 14px;
            font-family: "Helvetica Neue", Helvetica, "PingFang SC", 微软雅黑, Tahoma, Arial, sans-serif;
            border: none;
            padding: 0 10px;
            line-height: 36px;
            background: none;
        }

    </style>
</head>
<body>
<div class="layui-container" style="margin-top: 30px;margin-left: 20px !important;margin-right: 20px !important;width: 95%">
    <div class="layui-row">
        <div class="layui-col-md12">
            <fieldset class="layui-elem-field layui-field-title">
                <legend id="weekReportDetailTitle">修改会员</legend>
            </fieldset>
            <form class="layui-form layui-form-pane" id="personForm">

                <input type="hidden" name="id" class="layui-input" id="id" value="${personId?c}" />

            <#--private String realName; // 真实姓名-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">真实姓名</label>
                        <div class="layui-input-block">
                            <input type="text" name="realName" class="layui-input" id="realName" placeholder="必填" maxlength="40" autocomplete="on" lay-verify="required"/>
                        </div>
                    </div>
                </div>

            <#--private String phone; // 电话-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">电话</label>
                        <div class="layui-input-block">
                            <input type="text" name="phone" class="layui-input" id="phone" placeholder="必填" maxlength="15" lay-verify="required"/>
                        </div>
                    </div>
                </div>

            <#--private Integer level; // 会员级别-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">会员级别</label>
                        <div class="layui-input-block">
                            <select name="level" id="level" lay-search="" lay-verify="required">
                                <option value="">直接选择或搜索选择</option>
                            </select>
                        </div>
                    </div>
                </div>

            <#-- private String cardNum;  // 会员卡号-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">会员卡号</label>
                        <div class="layui-input-block">
                            <input type="text" name="cardNum" class="layui-input" id="cardNum" placeholder="必填" maxlength="50" lay-verify="required|drdZyz"/>
                        </div>
                    </div>
                </div>

            <#--private Date makeCardTime;  // 办卡日期-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">办卡日期</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" name="makeCardTime" id="makeCardTime" placeholder="yyyy-MM-dd HH:mm" lay-verify="required" />
                        </div>
                    </div>
                </div>
            <#--private Integer status;  // 状态 0：有效 1：禁用    新增页面默认是0-->
                <input type="hidden" value="0" name="status">

            <#--private String remark;  // 备注-->
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block">
                        <textarea name="remark" class="layui-textarea" id="remark" placeholder="选填" maxlength="1500" lay-verify="remark"></textarea>
                    </div>
                </div>

                <div class="layui-row" style="text-align: center">
                    <div class="layui-col-md12">
                        <a class="layui-btn" lay-submit lay-filter="confirm">确定</a>
                        <a class="layui-btn layui-btn-warm" onclick="back()">取消</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="/layui-v2.2.6/layui/layui.js" charset="utf-8"></script>
<script src="/jquery-3.3.1.min.js"></script>

<script>
    $(function() {
        var realName, phone, level, cardNum, makeCardTime, remark;

        /* 查询会员 */
        $.ajax({
            type: 'GET'
            ,url: '/person/findPersonById'
            ,data: {
                id: ${personId?c}
            }
            ,async: false
            ,dataType: 'json'
            ,success: function (data) {
                realName = data.data.realName;
                phone = data.data.phone;
                level = data.data.level.id;
                cardNum = data.data.cardNum;
                makeCardTime = data.data.makeCardTime;
                remark = data.data.remark;

                $('#realName').val(realName);
                $('#phone').val(phone);
                $('#cardNum').val(cardNum);

            }
        });

    <#--会员级别下拉菜单-->
        $.ajax({
            type: 'GET'
            ,url: '/level/findAll'
            ,async: false
            ,dataType: 'json'
            ,success: function (data) {
                var levelSelect = '';
                for(var i = 0; i < data.data.length; i++){
                    if (level === data.data[i].id){
                        levelSelect += '<option value="'+data.data[i].id+'" selected>'+data.data[i].levelName+'</option>';
                    } else {
                        levelSelect += '<option value="'+data.data[i].id+'">'+data.data[i].levelName+'</option>';
                    }
                }
                $('#level').append(levelSelect);
            }
        });

        layui.use('laydate', function() {
            var laydate = layui.laydate;
            <#--办卡日期-->
            laydate.render({
                elem: '#makeCardTime'
                ,type: 'datetime'
                ,value: makeCardTime
                ,format: 'yyyy-MM-dd HH:mm'
            });
        });
    });

    layui.use('form', function(){
        var form = layui.form,layer = layui.layer;

    <#--但是，如果你的HTML是动态生成的，自动渲染就会失效因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();-->
        form.render('select');


    <#--校验表单-->
        form.verify({});

    <#--监听提交表单-->
        form.on('submit(confirm)', function(){
            $.ajax({
                type: 'POST',
                url: '/person/save',    // 保存会员信息
                data: $('#personForm').serialize(),
                dataType: 'json',
                success: function (data) {
                    layer.msg(data.msg,
                            {
                                anim: 0, time: 1500
                            }
                            ,function(){
                                window.location.href = '/page/person_manage?page=' + ${page?c} + '&limit=' + ${limit?c};
                            });
                },
                error: function (data) {
                    layer.msg(data.msg,
                            {
                                anim: 0, time: 1500
                            }
                            ,function(){
                                window.location.href = '/page/person_manage?page=' + ${page?c} + '&limit=' + ${limit?c};
                            });
                }
            });
        });
    });

    <#--点击取消-->
    function back(){
        window.location.href = '/page/person_manage?page=' + ${page?c} + '&limit=' + ${limit?c};
    }

</script>
</body>
</html>