//
//  ReviewResultTableView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2023/01/02.
//

import SwiftUI
// 주문번호
//상품명
//구매자 평점
//리뷰내용
//등록자
//리뷰 등록일
struct ReviewResultTableView: View {
    //목록 테이블에 필요한 내용
    @State private var searchResultsDummy = [
        CustomerReview(reviewCreatedDate: "2022-12-31", registrant: "홍길동", registrantID: "hong123", orderNumber: "1dfsf", orderProduct: "맥북", orderProductID: "gdfis", reviewContent: "마음에 들어요!", rate: 5),
        CustomerReview(reviewCreatedDate: "2022-01-01", registrant: "진도준", registrantID: "jin123", orderNumber: "2dfsf", orderProduct: "아이패드", orderProductID: "dfwid", reviewContent: "상자가 찌그러짐", rate: 4),
        CustomerReview(reviewCreatedDate: "2022-01-03", registrant: "진양철", registrantID: "yang123", orderNumber: "3dfsf", orderProduct: "에어팟", orderProductID: "sdwid", reviewContent: "스크래치가 조금 있었음", rate: 2)
    
    ]
    
    // 표에서 선택 지원
    @State private var selectedOrder = Set<CustomerReview.ID>()
    
    // 정렬 지원 - 일단은 리뷰 등록 순서대로 정렬
    @State private var sortOrder = [KeyPathComparator(\CustomerReview.reviewCreatedDate)]
    
    
    var body: some View {
        VStack {
            Table (searchResultsDummy, selection: $selectedOrder, sortOrder: $sortOrder) {
                TableColumn("주문 번호", value: \.orderNumber)
                TableColumn("상품명", value: \.orderProduct)
                TableColumn("구매자 평점") { review in
                    Text("\(review.rate)")
                }
                TableColumn("리뷰 내용", value: \.reviewContent)
                TableColumn("리뷰 등록일", value: \.reviewCreatedDate)
                TableColumn("등록자", value: \.registrantID)
            }
        }
    }
}

struct ReviewResultTableView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewResultTableView()
    }
}
