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
    
    //카테고리
    var highCategory: [String] = ["중분류", "PC", "PC 액세서리", "노트북", "노트북 액세서리", "태블릿 PC", "태블릿 PC 액세서리"]
    var lowCategory: [String] = ["하위 카테고리", "test2", "test3"]
    @State private var highCategorySelection: Int = 0
    @State private var lowCategorySelection: Int = 0
    
    //채널
    @State private var reviewChannelTotal: Bool = false
    @State private var reviewChannelSmartStore: Bool = false
    
    //리뷰조건
    @State private var customerRateTotal: Bool = false
    @State private var customerRateOne: Bool = false
    @State private var customerRateTwo: Bool = false
    @State private var customerRateThree: Bool = false
    @State private var customerRateFour: Bool = false
    @State private var customerRateFive: Bool = false
    
    @State private var replyOrNot: Int = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("리뷰 관리")
                    .font(.title)
                    .bold()
                    .padding(30)
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
                            }.frame(width: 260)
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
                        .padding(.trailing, 20)
                        
                        Toggle(isOn: $reviewSeperateCommon) {
                            Text("일반 리뷰")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding(.trailing, 20)
                        
                        Toggle(isOn: $reviewSeperateMonth) {
                            Text("한달사용 리뷰")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding (.trailing, 110)
                        Spacer()
                        
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
                            .padding(.trailing, 109)
                        Spacer()
                        Toggle(isOn: $reviewTypeTotal) {
                            Text("전체")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding(.trailing, 20)
                        
                        Toggle(isOn: $reviewTypePhoto) {
                            Text("포토 리뷰")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding(.trailing, 20)
                        
                        Toggle(isOn: $reviewTypeVideo) {
                            Text("동영상리뷰")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding(.trailing, 20)
                        
                        Toggle(isOn: $reviewTypeText) {
                            Text("텍스트 리뷰")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding(.trailing, 90)
                        Spacer()
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
                            .padding(.trailing, 100)
                        //Spacer()
                        Picker(selection: $highCategorySelection, label: Text("카테고리 상위")) {
                            ForEach(Array(highCategory.enumerated()), id: \.offset) { idx, item in
                                Text("\(item)").tag(idx)
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .padding(.leading, 80)
                        .font(.title2)
                        .pickerStyle(.automatic)
                        
                        Picker(selection: $lowCategorySelection, label: Text("카테고리 하위")) {
                            ForEach(Array(lowCategory.enumerated()), id: \.offset) { idx, item in
                                Text("\(item)").tag(idx)
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.top, 10)
//                        .padding(.trailing, )
                        .font(.title2)
                        .pickerStyle(.automatic)
                        Spacer()
                        
                    }
                    .padding(.leading, 30)
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
                        .padding(.trailing, 20)
                        
                        Toggle(isOn: $reviewChannelSmartStore) {
                            Text("스마트 스토어")
                                .font(.title3)
                        }
                        .toggleStyle(CheckboxStyle())
                        .padding(.trailing, 200)
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 16)
                    Divider()
                }
                // 리뷰 조건
                Group {
                    HStack {
                        Text("리뷰 조건")
                            .font(.title2)
                            
                        Spacer()
                        VStack (alignment: .leading) {
                            HStack {
                                Spacer()
                                Text("구매자 평점")
                                    .font(.title3)
                                    .padding(.leading, 70)
                                    .padding(.trailing, 10)
                                Toggle(isOn: $customerRateTotal) {
                                    Text("전체")
                                        .font(.title3)
                                }
                                .toggleStyle(CheckboxStyle())
                                .padding(.trailing, 15)
                                
                                Toggle(isOn: $customerRateOne) {
                                    Text("1점")
                                        .font(.title3)
                                }
                                .toggleStyle(CheckboxStyle())
                                .padding(.trailing, 15)
                                
                                Toggle(isOn: $customerRateTwo) {
                                    Text("2점")
                                        .font(.title3)
                                }
                                .toggleStyle(CheckboxStyle())
                                .padding(.trailing, 15)
                                
                                Toggle(isOn: $customerRateThree) {
                                    Text("3점")
                                        .font(.title3)
                                }
                                .toggleStyle(CheckboxStyle())
                                .padding(.trailing, 15)
                                
                                Toggle(isOn: $customerRateFour) {
                                    Text("4점")
                                        .font(.title3)
                                }
                                .toggleStyle(CheckboxStyle())
                                .padding(.trailing, 15)
                                
                                Toggle(isOn: $customerRateFive) {
                                    Text("5점")
                                        .font(.title3)
                                }
                                .toggleStyle(CheckboxStyle())
                                Spacer()
                            }
                            HStack {
                                
                                Text("답글여부")
                                    .font(.title3)
                                    .padding(.trailing, 14)
                                    .padding(.leading, 70)
                                Picker(selection: $replyOrNot, label: Text("답글여부")) {
                                    Text("답글여부 (상관없음)")
                                        .tag(1)
                                    Text("답글등록")
                                        .tag(2)
                                    Text("답글미등록")
                                        .tag(3)
                                    
                                }
                                .foregroundColor(.black)
                                .padding(.top, 10)
                                .font(.title2)
                                .pickerStyle(.automatic)
                                
                                
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 16)
                    Divider()
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("검색")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 170, height: 63)
                                .background(.black)
                                .cornerRadius(10)
                        }
                        .padding(.trailing, 50)
                        
                        Button {
                            
                        } label: {
                            Text("초기화")
                                .font(.title3)
                                .bold()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)
                                        .frame(width: 170, height: 63)
                                )
                        }
                        .padding(.leading, 40)
                        Spacer()

                    }.foregroundColor(.black)
                    
                    HStack {
                        Text("목록 (총 0개)")
                            .font(.title2)
                            .padding(.leading, 20)
                            .padding(.vertical, 10)
                        Spacer()
                    }
                    .background(Color(hue: 1.0, saturation: 0.006, brightness: 0.912))
                    Divider()
                        .padding(.bottom, 10)
                    
                }
            }//vstack
        }
        //.modifier(CloseUpDetailModifier())
        //scrollview
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
            .environmentObject(NavigationStateManager())
    }
}
