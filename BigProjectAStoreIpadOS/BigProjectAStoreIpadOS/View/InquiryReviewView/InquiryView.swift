//
//  InquiryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct Inquiry: Identifiable, Hashable {
    let id = UUID().uuidString
    let orderNumber: String
    let productId: String
    let productName: String
    let questionerId: String
    let questionerName: String
    let dateOfReception: String
    let isAnswered: Bool
    
    //연산 프로퍼티
    var isAnsweredInt : Int {
        isAnswered ? 0 : 1
    }
}

struct InquiryView: View {
    @State private var pickerSelection : Int = 0
    @State private var sortOrder = [KeyPathComparator(\Inquiry.dateOfReception)]
    @State var searchUserText : String = ""
    @State private var selectedInquiry: Inquiry.ID?
    @State private var path: [Inquiry] = []
    @State private var response: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var isDealt:Bool = false
    @State private var inquiries = [
        Inquiry(orderNumber: "1111", productId: "10101", productName: "iPad", questionerId: "hh333", questionerName: "추현호", dateOfReception: "1월 1일", isAnswered: false),
        Inquiry(orderNumber: "2222", productId: "10101", productName: "iPhon14 Pro", questionerId: "jh333", questionerName: "이주희", dateOfReception: "1월 2일", isAnswered: true),
        Inquiry(orderNumber: "3333", productId: "20202", productName: "iPhon12", questionerId: "hh555", questionerName: "최한호", dateOfReception: "1월 3일", isAnswered: false),
        Inquiry(orderNumber: "4444", productId: "30303", productName: "iPad", questionerId: "sh454", questionerName: "김수현", dateOfReception: "1월 4일", isAnswered: true),
        Inquiry(orderNumber: "5555", productId: "40404", productName: "iPad mini", questionerId: "sh121", questionerName: "정세훈", dateOfReception: "1월 5일", isAnswered: false)
    ]
    
    enum inquiryState: String, CaseIterable, Identifiable {
        case inProgress, completed, all
        var id: Self { self }
    }
    
    @State private var selectedState: inquiryState = .inProgress
    
    var results: [Inquiry] {
        //filter를 날짜로 한번하고 그 이후 필터 진행
        let dateFilteredData = inquiries
        
        if !searchUserText.isEmpty && pickerSelection == 0 {
            return dateFilteredData.filter {
                $0.productName .contains(searchUserText)
            }
        }
        return dateFilteredData
    }
    
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack {
                Section{
                    HStack{
                        Text("문의 기간")
                        Spacer()
                        HStack{
                            DatePicker  ("", selection: $startDate, displayedComponents: [.date])
                                .frame(width: 150)
                            Text("     ~")
                            DatePicker("", selection: $endDate, displayedComponents: [.date])
                                .frame(width: 150)
                        }
                        Spacer()
                    }
                }.padding()
                
                Section{
                    HStack {
                        Text("답변여부")
                        Spacer()
                        Picker("답변 여부", selection: $selectedState) {
                            Text("미답변").tag(inquiryState.inProgress)
                            Text("답변완료").tag(inquiryState.completed)
                            Text("전체").tag(inquiryState.all)
                        }
                        Spacer()
                    }
                }
                .padding()
                
                Text("문의내역")
                Section{
                    Table(inquiries, selection: $selectedInquiry) {
                        TableColumn("주문 번호", value: \.orderNumber)
                        TableColumn("제품 코드", value: \.productId)
                        TableColumn("제품 명", value: \.productName)
                        TableColumn("질문자 ID", value: \.questionerId)
                        TableColumn("질문자 이름", value: \.questionerName)
                        TableColumn("문의 접수 일", value: \.dateOfReception)
                        TableColumn("답변 완료 여부") { inquiry in Image(systemName: inquiry.isAnswered ? "checkmark" : "xmark").foregroundColor(inquiry.isAnswered ? Color.green : Color.red)
                        }
                    }.onChange(of: selectedInquiry) { newElement in
                        if let newElement,
                           let inquiry = inquiries.first(where: { $0.id == newElement }) {
                            path.append(inquiry)
                        }
                    }
                }.searchable(text: $searchUserText, prompt: "검색")
            }
        }.navigationDestination(for: Inquiry.self) {inquiry in
            InquiryDetailView(inquiry: inquiry)
        }
    }
}

struct InquiryView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryView()
            .environmentObject(NavigationStateManager())
    }
}
