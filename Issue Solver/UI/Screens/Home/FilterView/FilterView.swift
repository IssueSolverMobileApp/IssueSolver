//
//  FilterView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var homeViewModel: HomeViewModel
    @StateObject var vm = FilterViewModel()
    @Binding var selectedFilters: [String]
    
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack(spacing: 16) {
                titleView
                
                ScrollView {
                    pickerView
                }
                buttonView
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        
        .onTapGesture {
            hideKeyboard()
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
        }
    }
    
    ///Back Button View
     var backButtonView: some View {
         CustomButton(style: .back, title: "") {
             router.dismissView()
         }
     }
    
    var titleView: some View {
        HStack {
            CustomTitleView(title: "Filter")
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 16) {
            CustomPickerView(selection: $vm.selectedOrganization, title: "Problemin yönləndiriləcəyi qurum", isRightTextEditor: $vm.isRightTextEditor, onPickerTapped: {
                vm.getOrganizations()
             })
               {
                ForEach(vm.organizations, id: \.self) { organization in
                    Text(organization.name ?? "")
                        .tag(organization.id)
                }
            }
            
            CustomPickerView(selection: $vm.selectedCategory, title: "Problemin kateqoeriyası", isRightTextEditor: $vm.isRightTextEditor, onPickerTapped: {
                vm.getCategories()
            }) {
                ForEach(vm.categories, id: \.self) { category in
                    Text(category.name ?? "")
                        .tag(category.categoryID)
                }
            }
            
            CustomPickerView(selection: $vm.selectedStatus, title: "Problemin statusu", isRightTextEditor: $vm.isRightTextEditor) {
                ForEach(vm.statuses, id: \.self) { status in
                    Text(status.name ?? "")
                        .tag(status)
                }
            }
            
            CustomPickerView(selection: $vm.selectedDate, title: "Problemin baş verdiyi tarix", isRightTextEditor: $vm.isRightTextEditor) {
                ForEach(vm.date, id: \.self) { date in
                    Text(date.name ?? "")
                        .tag(date)
                }
            }
            
        }
    }
    
    var buttonView: some View {
            CustomButton(style: .rounded, title: "Tətbiq et", color: .primaryBlue) {
                vm.applyFilter()
                selectedFilters = [
                    vm.selectedOrganization == .none ? "" : vm.selectedOrganization.name ?? "",
                    vm.selectedCategory == .none ? "" : vm.selectedCategory.name ?? "",
                    vm.selectedStatus == .none ? "" : vm.selectedStatus.nameWithoutSpaces,
                    vm.selectedDate == .none ? "" : vm.selectedDate.name ?? ""
                ]
                router.dismissView()

            }
        }
    }

