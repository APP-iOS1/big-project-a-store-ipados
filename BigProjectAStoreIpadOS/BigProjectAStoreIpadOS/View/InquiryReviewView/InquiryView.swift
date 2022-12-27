//
//  InquiryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct InquiryView: View {
    
    
    @State private var response: String = ""
    @State private var date = Date()
    @State private var isDealt:Bool = false
    
    enum inquiryState: String, CaseIterable, Identifiable {
        case inProgress, completed, all
        var id: Self { self }
    }
    
    @State private var selectedState: inquiryState = .inProgress

    
    var body: some View {
        
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("문의 접수일")){
                        VStack{
                            DatePicker("부터", selection: $date, displayedComponents: [.date])
                            DatePicker("까지", selection: $date, displayedComponents: [.date])
                        }
                    }
                    
                    Section(header: Text("문의 답변 여부")){
                        List {
                          Picker("답변 여부", selection: $isDealt) {
                              Text("미답변").tag(inquiryState.inProgress)
                              Text("답변완료").tag(inquiryState.completed)
                              Text("전체").tag(inquiryState.all)
                          }
                        }
                    }
                    
                    Section(header: Text("문의 내역")){
                        List{
                            Text("문의 제목")
                            Text("문의 제목")
                            Text("문의 제목")
                        }
                    }
                    Section(header: Text("답변내용")) {
                        TextEditor(text: $response)
                            .frame(height:200)
                        
                    }
                }
            }
        }
    }
}

struct InquiryView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryView()
    }
}
