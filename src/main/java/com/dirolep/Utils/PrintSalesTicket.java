package com.dirolep.Utils;

import com.dirolep.DTO.BaseTicket;
import java.awt.print.*;

/**
 * 打印票据工具类
 * Created by Administrator on 2018\5\1 0001.
 */
public class PrintSalesTicket {

    public static void PrintSale(BaseTicket ticket) throws PrinterException {
        // 通俗理解就是书、文档
        Book book = new Book();
        // 设置成竖打
        PageFormat pf = new PageFormat();
        pf.setOrientation(PageFormat.PORTRAIT);

        // 通过Paper设置页面的空白边距和可打印区域。必须与实际打印纸张大小相符。
        Paper paper = new Paper();
        paper.setSize(58, 30000);// 纸张大小
        paper.setImageableArea(0, 0, 58, 30000);// A4(595 X
        // 842)设置打印区域，其实0，0应该是72，72，因为A4纸的默认X,Y边距是72
        pf.setPaper(paper);
        book.append(ticket, pf);

        // 获取打印服务对象
        PrinterJob job = PrinterJob.getPrinterJob();
        // 设置打印类
        job.setPageable(book);

        job.print();

    }


}
