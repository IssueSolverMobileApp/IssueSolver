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
                ScrollView {
                    titleView
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
            CustomPickerView(selection: $vm.selectedOrganization, title: "Problemin yönləndiriləcəyi qurum",textColor: vm.selectedOrganization.name == "Qurum" ? .gray : .black, isRightTextEditor: $vm.isRightTextEditor, onPickerTapped: {
                vm.getOrganizations()
            })
            {
                ForEach(vm.organizations, id: \.self) { organization in
                    Text(organization.name ?? "")
                        .tag(organization.id)
                }
            }
            
            CustomPickerView(selection: $vm.selectedCategory, title: "Problemin kateqoriyası", textColor: vm.selectedCategory.name == "Kateqoriya" ? .gray : .black, isRightTextEditor: $vm.isRightTextEditor, onPickerTapped: {
                vm.getCategories()
            }) {
                ForEach(vm.categories, id: \.self) { category in
                    Text(category.name ?? "")
                        .tag(category.categoryID)
                }
            }
            
            CustomPickerView(selection: $vm.selectedStatus, title: "Problemin statusu",textColor: vm.selectedStatus.name == "Status" ? .gray : .black, isRightTextEditor: $vm.isRightTextEditor) {
                ForEach(vm.statuses, id: \.self) { status in
                    Text(status.name ?? "")
                        .tag(status)
                }
            }
            
            CustomPickerView(selection: $vm.selectedDate, title: "Problemin baş verdiyi tarix",textColor: vm.selectedDate.name == "Tarix" ? .gray : .black,  isRightTextEditor: $vm.isRightTextEditor) {
                ForEach(vm.date, id: \.self) { date in
                    Text(date.name ?? "")
                        .tag(date)
                }
            }
            
        }
    }
    
    var buttonView: some View {
        VStack(spacing: 16) {
            CustomButton(style: .rounded, title: "Tətbiq et", color: .primaryBlue) {
                vm.applyFilter()
                selectedFilters = [
                    (vm.selectedOrganization == .none || vm.selectedOrganization.name == "Qurum") ? "" : vm.selectedOrganization.name ?? "",
                    (vm.selectedCategory == .none || vm.selectedCategory.name == "Kateqoriya") ? "" : vm.selectedCategory.name ?? "",
                    (vm.selectedStatus == .none || vm.selectedStatus.name == "Status") ? "" : vm.selectedStatus.nameWithoutSpaces,
                    (vm.selectedDate == .none || vm.selectedDate.name == "Tarix") ? "" : vm.selectedDate.name ?? ""
                ]
                router.dismissView()
                
            }
            CustomButton(style: .rounded, title: "Sıfırla", color: .white, foregroundStyle: .primaryBlue) {
                homeViewModel.selectedFilters = ["", "", "", ""]
                router.dismissView()
            }
        }
    }
}

