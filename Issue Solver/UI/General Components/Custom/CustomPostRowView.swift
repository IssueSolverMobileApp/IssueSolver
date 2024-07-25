//
//  CustomPostRowView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomPostRowView: View {
    
    @Binding var queryItem: QueryDataModel
//        didSet {
//            setOptionsAccordingToStatus()
//        }
//    }
    
    @State private var statusBacgroundColor: Color?
    @State private var statusForegroundColor: Color?
    @State private var isDeleteClickable: Bool = true
    
    @State private var showingAlert = false
    
    
    /// if we need to use PostView into some detailView isDetailView variable must be true else false
    var isDetailView: Bool = true
    var ifNeedDeleteButton: Bool
    
    let commentHandler: () -> Void
    let likeHandler: (Bool) -> Void
    let deleteQuery: () -> Void
    
    init(queryItem: Binding<QueryDataModel>, isDetailView: Bool,ifNeedDeleteButton: Bool, commentHandler: @escaping () -> Void, statusBacgroundColor: Color? = nil, statusForegroundColor: Color? = nil, likeHandler: @escaping(Bool) -> Void, deleteQuery: @escaping() -> Void
    ) {
        self._queryItem = queryItem
        self.isDetailView = isDetailView
        self.ifNeedDeleteButton = ifNeedDeleteButton
        self.statusBacgroundColor = statusBacgroundColor
        self.statusForegroundColor = statusForegroundColor
        self.commentHandler = commentHandler
        self.likeHandler = likeHandler
        self.deleteQuery = deleteQuery
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            
            topView
            customDivider
            centerView
            customDivider
            bottomView
        }
        .onAppear {
            setOptionsAccordingToStatus()
        }
        .padding(16)
        .background(.white)
        .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }
    
    var topView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(.profile)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                Text(queryItem.fullName ?? "")
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.primaryBlue)
                    .lineLimit(2)
                Spacer()
                HStack {
                    Image(.blueDotIcon)
                        .foregroundStyle(statusForegroundColor ?? .primaryBluePressed)
                    Text(queryItem.status ?? "")
                        .jakartaFont(.subheading)
                        .foregroundStyle(statusForegroundColor ?? .primaryBluePressed)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(statusBacgroundColor)
                .clipShape(.rect(cornerRadius: 100))
            }
            
            if isDetailView {
                Text(queryItem.organizationName ?? "")
                    .jakartaFont(.subheading)
            }
        }
    }
    
    var centerView: some View {
        VStack(alignment: .leading,spacing: 16) {
            
            ZStack {
                Text(queryItem.category?.name ?? "")
                    .jakartaFont(.subtitle2)
                    .foregroundStyle(.disabledGray)
            }
            .padding(.horizontal,10)
            .padding(.vertical, 8)
            .background(Color.surfaceBackground)
            .clipShape(.rect(cornerRadius: 100))
            
            //            text of Post
            if queryItem.description?.count ?? 0  >= 120 && !isDetailView {
                ZStack {
                    Text(queryItem.description?.prefix(120) ?? "")
                    + Text("...daha çox göstər").foregroundColor(.blue)
                }
                .lineSpacing(9)
                .foregroundStyle(.primaryGray)
                .jakartaFont(.subheading)
                
            } else {
                Text(queryItem.description ?? "")
                    .lineSpacing(9)
                    .foregroundStyle(.primaryGray)
                    .jakartaFont(.subheading)
                
                //                Location and Date
                if isDetailView {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            
                            Image(.locationIcon)
                            Text(queryItem.address ?? "")
                                .foregroundStyle(.primaryBlue)
                        }
                        HStack {
                            Image(.calendarIcon)
                            /// this method can correct string date for our custom date format
                            Text(queryItem.createDate ?? "")
                        }
                    }
                    .jakartaFont(.subtitle2)
                }
            }
        }
    }
    
    var customDivider: some View {
        Divider().overlay {
            Color.primaryBluePressed.opacity(0.28)
        }
    }
    //            Like, comment and option button
    var bottomView: some View {
        HStack {
            VStack(spacing: 5) {
                
                Button(action: {
                    likeHandler(queryItem.likeSuccess ?? false ? false : true)
                    queryItem.likeSuccess?.toggle()
                }, label: {
                    Image(queryItem.likeSuccess ?? false ? .likeIconFill : .likeIcon )
                })
                
                if isDetailView {
                    Text("\(queryItem.likeCount ?? 0)")
                        .jakartaFont(.custom(.medium, 10))
                }
            }
            .padding(.trailing, 24)
            VStack {
                Button(action: {
                    commentHandler()
                }, label: {
                    Image(.commentIcon)
                })
                if isDetailView {
                    Text("\(queryItem.commentCount ?? 0)")
                        .jakartaFont(.custom(.medium, 10))
                }
            }
            Spacer()
            /// Delete button
            if ifNeedDeleteButton {
                Button(action: {
                    if isDeleteClickable {
                        deleteQuery()
                    } else {
                        showingAlert = true
                    }
                }, label: {
                    Image(/*isDeleteClickable ? .trashIconDisabled :*/ .trashIcon)
                        .padding(.trailing, 6)
                })
//                .disabled(isDeleteClickable)
                .alert("Baxılır statusunda olan sorğunu silmək mümkün deyil", isPresented: $showingAlert) {
                    Button("Oldu", role: .cancel) {
                        showingAlert = false
                    }
                }
            }
        }
    }
    
    private func setOptionsAccordingToStatus() {
        switch queryItem.status {
        case "Gözləmədə" :
            statusBacgroundColor = .primaryBlue.opacity(0.28)
            statusForegroundColor = .primaryBluePressed
            isDeleteClickable = true
        case "Baxılır" :
            statusBacgroundColor = .outLineContainerOrange
            statusForegroundColor = .primaryOrange
            isDeleteClickable = false
        case "Əsassızdır" :
            statusBacgroundColor = .outLineContainerRed
            statusForegroundColor = .primaryRed
            isDeleteClickable = true
        case "Həll edildi" :
            statusBacgroundColor = .outLineContainerGreen
            statusForegroundColor = .primaryGreen
            isDeleteClickable = true
        case "Arxivdədir" :
            statusBacgroundColor = .outLineContainerGray
            statusForegroundColor = .disabledGray
            isDeleteClickable = true
        case .none:
            statusBacgroundColor = nil
            statusForegroundColor = nil
            isDeleteClickable = true
        case .some(_):
            statusBacgroundColor = nil
            statusForegroundColor = nil
            isDeleteClickable = true
        }
    }
}
//    func dateFormatter(_ text: String? ,_ format: DateFormType) -> String {
//        guard let text else { return String() }
//        print(text)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format.rawValue
//        let date = dateFormatter.date(from: text ?? Date()
////        let date = dateFormatter.date(from: text) ?? Date()
//        print(date)
//
//        let resultFormat = dateFormatter.string(from: date)
//        print(resultFormat)
//
//        return resultFormat
//    }
//}

//enum DateFormType: String {
//    case hour = "HH:mm"
//    case day = "dd.MM.YYYY"
//    case all = "dd.MM.YYYY, HH:mm"
//}
