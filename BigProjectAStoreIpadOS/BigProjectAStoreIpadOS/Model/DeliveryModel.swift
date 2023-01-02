//
//  DeliveryModel.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI

struct DeliveryModel: Identifiable, Hashable{
    var id = UUID()
    
    var orderState: String  // 주문 상태 (0: 배송준비, 1: 배송완료, 2: 배송중)
    var orderNumber: String // 주문 번호(id)
    var productNumber: String // 상품 번호(id)
    var productName: String // 상품 이름
    var shippingDate: String // 발송 날짜
    var shipmentCompany: String // 택배사
    var trackingNumber: String // 송장번호
}

var sampleDeliveryData: [DeliveryModel] = [
    DeliveryModel(orderState: "0", orderNumber: "0046", productNumber: "p1", productName: "키보드", shippingDate: "발송 전", shipmentCompany: "우체국 택배", trackingNumber: "5264106429"),
    DeliveryModel(orderState: "0", orderNumber: "0045", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "2536476233"),
    DeliveryModel(orderState: "0", orderNumber: "0044", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "2460487362"),
    DeliveryModel(orderState: "0", orderNumber: "0043", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "0583829596"),
    DeliveryModel(orderState: "0", orderNumber: "0042", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "3785940934"),
    DeliveryModel(orderState: "0", orderNumber: "0041", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "8291049586"),
    DeliveryModel(orderState: "0", orderNumber: "0040", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "2079711029"),
    DeliveryModel(orderState: "0", orderNumber: "0039", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "9275047342"),
    DeliveryModel(orderState: "0", orderNumber: "0038", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "0927592759"),
    DeliveryModel(orderState: "0", orderNumber: "0037", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "7028319684"),
    DeliveryModel(orderState: "0", orderNumber: "0036", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "1693860284"),
    DeliveryModel(orderState: "0", orderNumber: "0035", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "0927294385"),
    DeliveryModel(orderState: "0", orderNumber: "0034", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "1282498750"),
    DeliveryModel(orderState: "0", orderNumber: "0033", productNumber: "p2", productName: "마우스", shippingDate: "발송 전", shipmentCompany: "대한통운", trackingNumber: "9478592845"),
    DeliveryModel(orderState: "0", orderNumber: "0032", productNumber: "p3", productName: "컴퓨터", shippingDate: "발송 전", shipmentCompany: "FedEx", trackingNumber: "2987637737"),
    DeliveryModel(orderState: "2", orderNumber: "0031", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-19", shipmentCompany: "로젠택배", trackingNumber: "7968037228"),
    DeliveryModel(orderState: "2", orderNumber: "0030", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-19", shipmentCompany: "DHL", trackingNumber: "2655477645"),
    DeliveryModel(orderState: "2", orderNumber: "0029", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-19", shipmentCompany: "한진택배", trackingNumber: "9283069343"),
    
    DeliveryModel(orderState: "2", orderNumber: "0028", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-16", shipmentCompany: "로젠택배", trackingNumber: "9217660420"),
    DeliveryModel(orderState: "2", orderNumber: "0027", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-16", shipmentCompany: "DHL", trackingNumber: "6679372004"),
    DeliveryModel(orderState: "2", orderNumber: "0026", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-16", shipmentCompany: "한진택배", trackingNumber: "8702719423"),
    DeliveryModel(orderState: "2", orderNumber: "0025", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-14", shipmentCompany: "로젠택배", trackingNumber: "7490249528"),
    DeliveryModel(orderState: "2", orderNumber: "0024", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-13", shipmentCompany: "DHL", trackingNumber: "0109283274"),
    DeliveryModel(orderState: "2", orderNumber: "0023", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-13", shipmentCompany: "한진택배", trackingNumber: "2249193049"),
    DeliveryModel(orderState: "2", orderNumber: "0022", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-13", shipmentCompany: "로젠택배", trackingNumber: "8075428609"),
    DeliveryModel(orderState: "2", orderNumber: "0021", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-13", shipmentCompany: "DHL", trackingNumber: "8765408912"),
    DeliveryModel(orderState: "2", orderNumber: "0020", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-13", shipmentCompany: "한진택배", trackingNumber: "1240399753"),
    DeliveryModel(orderState: "2", orderNumber: "0019", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-11", shipmentCompany: "로젠택배", trackingNumber: "3987201129"),
    DeliveryModel(orderState: "2", orderNumber: "0018", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-11", shipmentCompany: "DHL", trackingNumber: "2304928476"),
    DeliveryModel(orderState: "2", orderNumber: "0017", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-11", shipmentCompany: "한진택배", trackingNumber: "3896541728"),
    DeliveryModel(orderState: "2", orderNumber: "0016", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-11", shipmentCompany: "한진택배", trackingNumber: "3827163540"),
    DeliveryModel(orderState: "2", orderNumber: "0015", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-10", shipmentCompany: "로젠택배", trackingNumber: "3029484736"),
    DeliveryModel(orderState: "2", orderNumber: "0014", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-10", shipmentCompany: "DHL", trackingNumber: "1029384756"),
    DeliveryModel(orderState: "2", orderNumber: "0013", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-10", shipmentCompany: "한진택배", trackingNumber: "8079475639"),
    
    
    DeliveryModel(orderState: "1", orderNumber: "0012", productNumber: "p12", productName: "아이패드", shippingDate: "2022-12-09", shipmentCompany: "롯데택배", trackingNumber: "1467532049"),
    DeliveryModel(orderState: "1", orderNumber: "0011", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-06", shipmentCompany: "우체국 택배", trackingNumber: "3997682405"),
    DeliveryModel(orderState: "1", orderNumber: "0010", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-06", shipmentCompany: "우체국 택배", trackingNumber: "2049573029"),
    DeliveryModel(orderState: "1", orderNumber: "0009", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-05", shipmentCompany: "우체국 택배", trackingNumber: "7938455593"),
    DeliveryModel(orderState: "1", orderNumber: "0008", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-05", shipmentCompany: "우체국 택배", trackingNumber: "2039988177"),
    DeliveryModel(orderState: "1", orderNumber: "0007", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-05", shipmentCompany: "우체국 택배", trackingNumber: "6039584736"),
    DeliveryModel(orderState: "1", orderNumber: "0006", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-05", shipmentCompany: "우체국 택배", trackingNumber: "1464382093"),
    DeliveryModel(orderState: "1", orderNumber: "0005", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-05", shipmentCompany: "우체국 택배", trackingNumber: "5483762806"),
    DeliveryModel(orderState: "1", orderNumber: "0004", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-04", shipmentCompany: "우체국 택배", trackingNumber: "7759003928"),
    DeliveryModel(orderState: "1", orderNumber: "0003", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-03", shipmentCompany: "우체국 택배", trackingNumber: "2630992823"),
    DeliveryModel(orderState: "1", orderNumber: "0002", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-03", shipmentCompany: "우체국 택배", trackingNumber: "6161109138"),
    DeliveryModel(orderState: "1", orderNumber: "0001", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-02", shipmentCompany: "우체국 택배", trackingNumber: "5752895799")
    
]

