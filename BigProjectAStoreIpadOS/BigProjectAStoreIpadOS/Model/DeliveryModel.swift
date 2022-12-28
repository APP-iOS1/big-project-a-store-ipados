//
//  DeliveryModel.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI

struct DeliveryModel: Identifiable, Hashable{
    var id = UUID()
    
    var orderState: String  // 주문 상태
    var orderNumber: String // 주문 번호(id)
    var productNumber: String // 상품 번호(id)
    var productName: String // 상품 이름
    var shippingDate: String // 발송 날짜
    var shipmentCompany: String // 택배사
    var trackingNumber: String // 송장번호
}

var sampleDeliveryData: [DeliveryModel] = [
    DeliveryModel(orderState: "배송중", orderNumber: "0001", productNumber: "psdfsdfsdfsdf1", productName: "키보드", shippingDate: "2022-12-27", shipmentCompany: "우체국 택배", trackingNumber: "2353463523468"),
    DeliveryModel(orderState: "배송준비", orderNumber: "0002", productNumber: "p2", productName: "마우스", shippingDate: "2022-12-27", shipmentCompany: "대한통운", trackingNumber: "253647623"),
    DeliveryModel(orderState: "배송준비", orderNumber: "0003", productNumber: "p3", productName: "컴퓨터", shippingDate: "2022-12-27", shipmentCompany: "FedEx", trackingNumber: "2356645522"),
    DeliveryModel(orderState: "배송준비", orderNumber: "0004", productNumber: "p8", productName: "노트북", shippingDate: "2022-12-27", shipmentCompany: "로젠택배", trackingNumber: "28953245456"),
    DeliveryModel(orderState: "배송중", orderNumber: "0005", productNumber: "p9", productName: "맥북", shippingDate: "2022-12-27", shipmentCompany: "DHL", trackingNumber: "2765487659")
//    DeliveryModel(orderState: "배송중", orderNumber: "0006", productNumber: "p11", productName: "애플워치", shippingDate: "2022-12-27", shipmentCompany: "한진택배", trackingNumber: "3929478029"),
//    DeliveryModel(orderState: "배송완료", orderNumber: "0007", productNumber: "p12", productName: "아이패드", shippingDate: "2022-12-20", shipmentCompany: "롯데택배", trackingNumber: "4829308754"),
//    DeliveryModel(orderState: "배송완료", orderNumber: "0008", productNumber: "p13", productName: "갤럭시 탭", shippingDate: "2022-12-21", shipmentCompany: "우체국 택배", trackingNumber: "205948473819")
]
