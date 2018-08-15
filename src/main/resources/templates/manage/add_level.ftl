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
                <legend id="weekReportDetailTitle">添加会员类别</legend>
            </fieldset>
            <form class="layui-form layui-form-pane" id="levelForm">

            <#--private String levelName;  // 会员级别名称-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">会员级别</label>
                        <div class="layui-input-block">
                            <input type="text" name="levelName" class="layui-input" id="levelName" placeholder="必填" maxlength="40" autocomplete="on" lay-verify="required"/>
                        </div>
                    </div>
                </div>

            <#--private BigDecimal levelPrice; // 会员价格-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">会员价格</label>
                        <div class="layui-input-block">
                            <input type="text" name="levelPrice" class="layui-input" id="levelPrice" placeholder="必填" lay-verify="required|number"/>
                        </div>
                    </div>
                </div>

            <#--private BigDecimal effectiveCount; // 有效次数-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">有效次数</label>
                        <div class="layui-input-block">
                            <input type="text" name="effectiveCount" class="layui-input" id="effectiveCount" placeholder="可不填，必须填数字" lay-verify="effectiveCount"/>
                        </div>
                    </div>
                </div>

            <#--private BigDecimal effectiveDays;  // 有效天数-->
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">有效天数</label>
                        <div class="layui-input-block">
                            <input type="text" name="effectiveDays" class="layui-input" id="effectiveDays" placeholder="可不填，必须填数字"  lay-verify="effectiveDays"/>
                        </div>
                    </div>
                </div>

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

    $(document).ready(function(){
        $("#effectiveCount").blur(function(){   // 有效次数 输入框 失焦
            if($(this).val() !== ''){
                $("#effectiveDays").attr("disabled",true);
                $("#effectiveDays").attr("placeholder", '无法输入');
            }else {
                $("#effectiveDays").attr("disabled",false);
                $("#effectiveDays").attr("placeholder", '可不填，必须填数字');
            }
        });

        $("#effectiveDays").blur(function(){
            if($(this).val() !== ''){
                $("#effectiveCount").attr("disabled",true);
                $("#effectiveCount").attr("placeholder",'无法输入');
            }else {
                $("#effectiveCount").attr("disabled",false);
                $("#effectiveCount").attr("placeholder",'可不填，必须填数字');
            }
        })
    });

    layui.use('form', function(){
        var form = layui.form,layer = layui.layer;

    <#--但是，如果你的HTML是动态生成的，自动渲染就会失效因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();-->
//        form.render('select');


    <#--校验表单-->
        form.verify({
        <#--有效次数  空或者数字-->
            effectiveCount: function(value){
                var reg=/^$|^\d+$/;
                if(!reg.test(value) === true){
                    return '空或者数字';
                }
            }
            ,effectiveDays: function(value){
                var reg=/^$|^\d+$/;
                if(!reg.test(value) === true){
                    return '空或者数字';
                }
            }

        });

    <#--监听提交表单-->
        form.on('submit(confirm)', function(){
            $.ajax({
                type: 'POST',
                url: '/level/save',
                data: $('#levelForm').serialize(),
                dataType: 'json',
                success: function (data) {
                    layer.msg(data.msg,
                            {
                                anim: 0, time: 1500
                            }
                            ,function(){
                                window.location.href = '/page/add_level';
                            });
                },
                error: function (data) {
                    layer.msg(data.msg,
                            {
                                anim: 0, time: 1500
                            }
                            ,function(){
                                window.location.href = '/page/add_level';
                            });
                }
            });
        });
    });

    <#--点击取消-->
    function back(){
        history.go(-1);
    }

</script>
</body>
</html>