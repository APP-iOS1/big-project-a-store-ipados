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
    @State private var isShowingEditor: Bool = false
    
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
                          Picker("답변 여부", selection: $selectedState) {
                              Text("미답변").tag(inquiryState.inProgress)
                              Text("답변완료").tag(inquiryState.completed)
                              Text("전체").tag(inquiryState.all)
                          }
                        }
                    }
                    
                    Section(header: Text("문의 내역")){
                        DisclosureGroup(
                            content: {
                                Text("배송이 너무느려 언제와 답변 빨리 안하면 반품한다")
                                Button {
                                    isShowingEditor = true
                                } label: {
                                    Text("답변 작성")
                                }

                            },
                            label: {
                                Text("배송 언제 와요?")
                            }
                        )
                        DisclosureGroup(
                            content: {
                                Text("배송이 너무느려 언제와 답변 빨리 안하면 반품한다")
                            },
                            label: {
                                Text("언제오냐고")
                            }
                            
                        )
                        DisclosureGroup(
                            content: {
                                Text("배송이 너무느려 언제와 답변 빨리 안하면 반품한다")
                            },
                            label: {
                                Text("언제")
                            }
                            
                        )
                    }
                    Section(header: Text("답변 작성")) {
                        if isShowingEditor == true {
                            TextEditor(text: $response)
                                .frame(height:200)
                            
                            Button {
                                isShowingEditor = false
                            } label: {
                                Text("답변 등록")
                            }
                        }
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
