//
//  CustomPostRowView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomPostRowView: View {
    
    @Binding var queryItem: QueryDataModel
    
    @State private var statusBacgroundColor: Color = .primaryBlue.opacity(0.28)
    @State private var statusForegroundColor: Color = .primaryBluePressed
    @State private var isDeleteClickable: Bool = true
    
    /// if we need to use PostView into some detailView isDetailView variable must be true else false
    var isDetailView: Bool = true
    
    let commentHandler: () -> Void
    let likeHandler: (Bool) -> Void
    let deleteQuery: () -> Void

    init(queryItem: Binding<QueryDataModel>, isDetailView: Bool, commentHandler: @escaping () -> Void, likeHandler: @escaping(Bool) -> Void, deleteQuery: @escaping() -> Void
) {
        self._queryItem = queryItem
        self.isDetailView = isDetailView
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
        .padding(16)
        .background(.white)
        .clipShape(.rect(cornerRadius: Constants.cornerRadius))
        .onAppear {
            setOptionsAccordingToStatus()
        }
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
                        .foregroundStyle(statusForegroundColor)
                    Text(queryItem.status ?? "")
                        .jakartaFont(.subheading)
                        .foregroundStyle(statusForegroundColor)
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
                            Text(Date().dateFormatter(queryItem.createDate, .all))
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
            
            Button(action: {
                deleteQuery()
            }, label: {
                Image(isDeleteClickable ? .trashIconDisabled : .trashIcon)
                    .padding()
            })
            .disabled(isDeleteClickable)
            
        }
    }
    
    private func setOptionsAccordingToStatus() {
        switch queryItem.status {
        case "Gözləmədə" :
            statusBacgroundColor = .primaryBlue.opacity(0.28)
            statusForegroundColor = .primaryBluePressed
            isDeleteClickable = false
        case "Baxılır" :
            statusBacgroundColor = .outLineContainerOrange
            statusForegroundColor = .primaryOrange
            isDeleteClickable = true
        case "Əssasızdır" :
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
            statusBacgroundColor = .surfaceBackground
            statusForegroundColor = .primaryBluePressed
            isDeleteClickable = false
        case .some(_):
            statusBacgroundColor = .surfaceBackground
            statusForegroundColor = .primaryBluePressed
            isDeleteClickable = false
        }
    }
}
