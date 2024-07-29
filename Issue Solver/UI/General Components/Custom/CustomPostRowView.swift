//
//  CustomPostRowView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomPostRowView: View {
    
    var queryItem: QueryDataModel

    @State private var statusBacgroundColor: Color? = nil
    @State private var statusForegroundColor: Color? = nil
    @State private var isDeleteClickable: Bool = true
    @State private var showingAlert = false
    
    /// if we need to use PostView into some detailView isDetailView variable must be true else false
    var isDetailView: Bool = true
    var ifNeedDeleteButton: Bool
    
    let commentHandler: () -> Void
    let likeHandler: (Bool) -> Void
    let deleteQuery: () -> Void
    
    init(queryItem: QueryDataModel, isDetailView: Bool,ifNeedDeleteButton: Bool, commentHandler: @escaping () -> Void,likeHandler: @escaping(Bool) -> Void, deleteQuery: @escaping() -> Void
    ) {
        self.queryItem = queryItem
        self.isDetailView = isDetailView
        self.ifNeedDeleteButton = ifNeedDeleteButton
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
                    .jakartaFont(.rowTitle)
                    .foregroundStyle(.primaryBlue)
                    .lineLimit(2)
                Spacer()
//                if let statusBacgroundColor, let statusForegroundColor {
                    HStack {
                        Image(.blueDotIcon)
                            .foregroundStyle(statusForegroundColor ?? .black)
                        Text(queryItem.status ?? "")
                            .jakartaFont(.subheading)
                            .foregroundStyle(statusForegroundColor ?? .black )
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(statusBacgroundColor)
                    .clipShape(.rect(cornerRadius: 100))
//                }
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
                    .jakartaFont(.subheading)
                    .foregroundStyle(.black)
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
                    Image(.trashIcon)
                        .padding(.trailing, 6)
                })
                .alert("Sorğular yalnız \"gözləmədə\" statusunda silinə bilər", isPresented: $showingAlert) {
                    Button("Oldu", role: .cancel) {
                        showingAlert = false
                    }
                }
            }
        }
    }
    
     func setOptionsAccordingToStatus() {
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
            isDeleteClickable = false
        case "Həll edildi" :
            statusBacgroundColor = .outLineContainerGreen
            statusForegroundColor = .primaryGreen
            isDeleteClickable = false
        case "Arxivdədir" :
            statusBacgroundColor = .outLineContainerGray
            statusForegroundColor = .disabledGray
            isDeleteClickable = false
        case .none:
            statusBacgroundColor = nil
            statusForegroundColor = nil
            isDeleteClickable = false
        case .some(_):
            statusBacgroundColor = nil
            statusForegroundColor = nil
            isDeleteClickable = false
        }
    }
}
