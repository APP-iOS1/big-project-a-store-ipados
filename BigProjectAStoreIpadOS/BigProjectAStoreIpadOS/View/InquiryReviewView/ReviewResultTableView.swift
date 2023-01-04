//
//  ReviewResultTableView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2023/01/02.
//

import SwiftUI
import FirebaseAuth
// 주문번호
//상품명
//구매자 평점
//리뷰내용
//등록자
//리뷰 등록일
struct ReviewResultTableView: View {

    
    //@Binding var searchResultCnt: Int
    
    @EnvironmentObject var storeNetworkManager: StoreNetworkManager
    
    // 표에서 선택 지원
    @State private var selectedOrder = Set<ReviewInfo.ID>()
    
    
    // 정렬 지원 - 일단은 리뷰 등록 순서대로 정렬
    @State private var sortOrder = [KeyPathComparator(\ReviewInfo.rate)]
    
    var body: some View {
        VStack {
            HStack {
                Text("목록 (총 \(storeNetworkManager.eachItemReviews.count)개)")
                    .font(.title2)
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(Color(hue: 1.0, saturation: 0.006, brightness: 0.912))
            .padding(.bottom, 20)
            //            ForEach(storeNetworkManager.eachItemReviews, id: \.itemId) { i in
            //                Text("i : \(i.postDescription)")
            //
            //            }
            
//
//            Table(storeNetworkManager.currentStoreItemArray) {
//
//
//                Table(storeNetworkManager.eachItemReviews) {
//                    //상품명
//                    //TableColumn("상품명", value: .postDescription)
//                    TableColumn("구매자 평점") { review in
//                        Text("(review.rate)")
//                    }
//                    TableColumn("리뷰 내용", value: \.postDescription)
//                    TableColumn("리뷰 등록일", value: \.postDate)
//                    TableColumn("등록자", value: \.reviewerId)
//
//                }
//
//            } rows:{
//
//                TableRow("상품명", value: : \.itemName)
//
//            }
//
            Table(storeNetworkManager.eachItemReviews, selection: $selectedOrder, sortOrder: $sortOrder) {
                //상품명
                TableColumn("상품명", value: \.itemName)
                TableColumn("구매자 평점", value: \.rate) { review in
                    Text("\(review.rate)")
                }
                
//                TableColumn("구매자 평점") { review in
//                    Text("\(review.rate)")
//                }
                TableColumn("리뷰 내용", value: \.postDescription)
                TableColumn("리뷰 등록일", value: \.postDate)
                TableColumn("등록자", value: \.reviewerId)
                
            }
            .onChange(of: sortOrder) {
                storeNetworkManager.eachItemReviews.sort(using: $0)
            }
            
        }
        .onAppear {
            Task {
                await storeNetworkManager.requestItemInfo(with: Auth.auth().currentUser?.uid)
                //print("this is item \(item.self)") //못 가져옴
                
                let itemIDList: [String] = await storeNetworkManager.requestItemIdList(with: Auth.auth().currentUser?.uid)
                
                print("array 확인 : \(storeNetworkManager.currentStoreItemArray)")
                //[ItemInfo()]
                print("test1: \(storeNetworkManager.currentStoreItemArray[0])")
                print("test2: \(storeNetworkManager.currentStoreItemArray[0].itemName)")
                
                storeNetworkManager.eachItemReviews.removeAll()
                
                for (index,itemID) in itemIDList.enumerated() {
                    await storeNetworkManager.requestItemReviews(with: Auth.auth().currentUser?.uid, fromItemId: itemID)
                    let itemName = storeNetworkManager.currentStoreItemArray[index].itemName
                    storeNetworkManager.eachItemReviews[index].itemName = itemName
                    
                    print("for문 내부 eachItemReview: \(storeNetworkManager.eachItemReviews)")
                    print("for문 내부ItemArray: \(storeNetworkManager.currentStoreItemArray)")
                    //storeNetworkManager.currentStoreItemArray[index]
                    
                }
                
                //                try await storeNetworkManager.requestItemReviews(with: Auth.auth().currentUser?.uid, fromItemId: item.s)
            }
        }
    }
}

struct ReviewResultTableView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewResultTableView()
    }
}
