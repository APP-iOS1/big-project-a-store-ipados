//
//  InquiryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct InquiryView: View {
    @StateObject var inquiryNetworkManager: InquiryNetworkManager = InquiryNetworkManager()
    
    @State private var pickerSelection : Int = 0
    //    @State private var sortOrder = [KeyPathComparator(\CustomerServiceInfo.serviceDate)]
    @State var searchUserText : String = ""
    @State private var selectedInquiry: CustomerServiceInfo.ID?
    @State private var path: [CustomerServiceInfo] = []
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    
    var body: some View {
        TestView()
//        NavigationStack {
//            VStack {
//                Section{
//                    HStack{
//                        Text("문의 기간")
//                        Spacer()
//                        HStack{
//                            DatePicker  ("", selection: $startDate, displayedComponents: [.date])
//                                .frame(width: 150)
//                            Text("     ~")
//                            DatePicker("", selection: $endDate, displayedComponents: [.date])
//                                .frame(width: 150)
//                        }
//                        Spacer()
//                    }
//                }.padding()
//
//                Text("문의내역")
////                Text("\(selectedInquiry)")
////                Section{
////                    Table(inquiryNetworkManager.customerService, selection: $selectedInquiry) {
////                        TableColumn("주문 번호") //, value: \.orderId)
////                        TableColumn("제품 코드") //, value: \.itemId)
////                        TableColumn("제품 명") //, value: \.itemName)
////                        TableColumn("질문자 ID") //, value: \.customerId)
////                        //                        TableColumn("문의 접수 일", value: \.serviceDate)
////                        TableColumn("답변 완료 여부")
////                        //                        { inquiry in Image(systemName: inquiry.isAnswered ? "checkmark" : "xmark").foregroundColor(inquiry.isAnswered ? Color.green : Color.red)
////                        //                                .navigationDestination(for: CustomerServiceInfo.self) {inquiry in
////                        //                                    InquiryDetailView(inquiry: inquiry)
////                        //                                }
////                        //                        }
////                    }
////                    .onChange(of: selectedInquiry) { newElement in
////                        if let newElement,
////                           let inquiry = inquiryNetworkManager.customerService.first(where: { $0.id == newElement }) {
////                            path.append(inquiry)
////                        }
////                    }
////                    //                }.searchable(text: $searchUserText, prompt: "검색")
////                    //                }
////                    //                .onAppear {
////                    //                    inquiryNetworkManager.requestCustomerServiceList()
////                    //
////                    //filter를 날짜로 한번하고 그 이후 필터 진행
////                    //                let dateFilteredData = inquiryNetworkManager.customerService
////                    //
////                    //                if !searchUserText.isEmpty && pickerSelection == 0 {
////                    //                    results = dateFilteredData.filter {
////                    //                        $0.productName .contains(searchUserText)
////                    //                    }
////                    //                }
////                    //                results = dateFilteredData
////                    //                }
//                } // VStack
//            } // NavigationStack
        }
    }
    
    struct InquiryView_Previews: PreviewProvider {
        static var previews: some View {
            InquiryView()
                .environmentObject(NavigationStateManager())
        }
    }
