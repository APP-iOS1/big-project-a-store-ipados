//
//  ReviewView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/28.
//

import SwiftUI

struct ReviewView: View {
    //리뷰 작성일
    @State private var reviewWriteSelection: Int = 1
    @State private var reviewWriteStartDate = Date()
    @State private var reviewWriteEndDate = Date()
    
    //리뷰 구분
    @State private var reviewSeperateTotal: Bool = false
    @State private var reviewSeperateCommon: Bool = false
    @State private var reviewSeperateMonth: Bool = false
    
    //리뷰 타입
    @State private var reviewTypeTotal: Bool = false
    @State private var reviewTypePhoto: Bool = false
    @State private var reviewTypeVideo: Bool = false
    @State private var reviewTypeText: Bool = false
    
    //채널
    @State private var reviewChannelTotal: Bool = false
    @State private var reviewChannelSmartStore: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            //리뷰 작성일
            Group {
                HStack {
                    Text("리뷰 작성일")
                        .font(.title3)
                    Spacer()
                    VStack (alignment: .leading) {
                        Picker(selection: $reviewWriteSelection, label: Text("리뷰 작성일")) {
                            Text("오늘").tag(1)
                            Text("1주일").tag(2)
                            Text("1개월").tag(3)
                            Text("3개월").tag(4)
                            Text("6개월").tag(5)
                            Text("1년").tag(6)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 500)
                        HStack{
                            DatePicker("", selection: $reviewWriteStartDate, in: ...Date(), displayedComponents: .date)
                            Text("~")
                            DatePicker("", selection: $reviewWriteEndDate, in: ...Date(), displayedComponents: .date)
                        }.frame(width: 280)
                    }//vstack
                    Spacer()
                }
                .padding(.horizontal, 30)
                Divider()
            }
            // 리뷰 구분
            Group {
                HStack {
                    Text("리뷰 구분")
                        .font(.title3)
                    Spacer()
                    Toggle(isOn: $reviewSeperateTotal) {
                        Text("전체")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.trailing, 30)
                    
                    Toggle(isOn: $reviewSeperateCommon) {
                        Text("일반 리뷰")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.trailing, 30)
                    
                    Toggle(isOn: $reviewSeperateMonth) {
                        Text("한달사용리뷰")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())

                }
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                Divider()
            }
            //리뷰 타입
            Group {
                HStack {
                    Text("리뷰 타입")
                        .font(.title3)
                    Spacer()
                    Toggle(isOn: $reviewTypeTotal) {
                        Text("전체")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.trailing, 30)
                    
                    Toggle(isOn: $reviewTypePhoto) {
                        Text("포토리뷰")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.trailing, 30)
                    
                    Toggle(isOn: $reviewTypeVideo) {
                        Text("동영상리뷰")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.trailing, 30)
                    
                    Toggle(isOn: $reviewTypeText) {
                        Text("텍스트리뷰")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                Divider()
            }
            // 카테고리
            Group {
                HStack {
                    Text("카테고리")
                        .font(.title3)
                    Spacer()
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                Divider()
            }
            // 채널
            Group {
                HStack {
                    Text("채널")
                        .font(.title3)
                    Spacer()
                    Toggle(isOn: $reviewChannelTotal) {
                        Text("전체")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.trailing, 30)
                    
                    Toggle(isOn: $reviewChannelSmartStore) {
                        Text("스마트 스토어")
                            .font(.title3)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                Divider()
            }
            // 리뷰 조건
            Group {
                Text("리뷰 조건")
                    .font(.title2)
                Divider()
            }
        }//vstack
    }//body
}

//체크박스 스타일
struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
