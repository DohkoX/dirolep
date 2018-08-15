package com.dirolep.DTO;

import java.awt.*;
import java.awt.print.PageFormat;
import java.awt.print.PrinterException;

/**
 * 打印消费票据的布局类
 * Created by Administrator on 2018\5\1 0001.
 */
public class SalesTicket extends BaseTicket {



    @Override
    public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
        Component c = null;
        // 转换成Graphics2D 拿到画笔
        Graphics2D g2 = (Graphics2D) graphics;
        // 设置打印颜色为黑色
        g2.setColor(Color.black);

        // 打印起点坐标
        double x = pageFormat.getImageableX();
        double y = pageFormat.getImageableY();

        // 设置打印字体（字体名称、样式和点大小）（字体名称可以是物理或者逻辑名称）
        font = new Font("宋体", Font.PLAIN, 14);
        g2.setFont(font);// 设置字体
        float heigth = font.getSize2D();// 字体高度
        // 标题
        g2.drawString("迪乐尼婴童游泳馆", (float) x, (float) y + heigth);

        float line = 2 * heigth;
        font = new Font("宋体", Font.PLAIN, 8);
        g2.setFont(font);// 设置字体
        heigth = font.getSize2D();// 字体高度

        // 显示单据号
        line += heigth;
        g2.drawString("单据号：" + danjuhao, (float) x, (float) y + line);
        // 显示地址
        line += heigth;
        g2.drawString("门店地址：" + adress, (float) x, (float) y + line);
        // 显示电话
        line += heigth;
        g2.drawString("联系电话:" + phoneNum, (float) x, (float) y + line);
        line += heigth;
        g2.drawString("卡类:" + cardCaregory, (float) x, (float) y + line);
        // 显示消费情况
        line += heigth;
        g2.drawString("消费项目" + consumptionCaregory, (float) x, (float) y + line);
        line += heigth;
        g2.drawString("扣除（次）：" + xfNum.toString(), (float) x + 25, (float) y + line);
        line += heigth;
        g2.drawString("剩余（次）：" + shengyuNum, (float) x + 25, (float) y + line);
        // 会员信息
        line += heigth;
        g2.drawString("会员卡号：" + cardNum, (float) x, (float) y + line);
        line += heigth;
        g2.drawString("会员姓名：:" + personRealName, (float) x, (float) y + line);
        line += heigth;
        g2.drawString("消费时间:" + xfDate, (float) x, (float) y + line);
        line += heigth;
        g2.drawString("开卡日期:" + makeCardDate, (float) x, (float) y + line);

        line += heigth;
        g2.drawString("敬请保留本小票", (float) x + 20, (float) y + line);

        switch (pageIndex) {
            case 0:
                return PAGE_EXISTS;
            default:
                return NO_SUCH_PAGE;

        }
    }
}
