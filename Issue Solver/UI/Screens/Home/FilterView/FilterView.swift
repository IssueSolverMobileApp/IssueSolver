//
//  FilterView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var vm = FilterViewModel()
    
    
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                rightButtonView
            }
        }
        .onAppear {
            vm.selectedOrganization = homeViewModel.selectedFilters?.organization ?? OrganizationModel(id: UUID(), name: "Qurum")
            vm.selectedCategory = homeViewModel.selectedFilters?.category ?? QueryCategoryModel(categoryID: 0, name: "Kateqoriya")
            vm.selectedStatus = homeViewModel.selectedFilters?.status ?? StatusModel(id: UUID(), name: "Status")
            vm.selectedDate = homeViewModel.selectedFilters?.days ?? DateModel(id: UUID(), name: "Tarix")
        }
    }
    
    /// - Back Button View
    var backButtonView: some View {
            CustomButton(style: .back, title: "") {
                router.dismissView()
            }
        }
    
    /// - Clear Filter Button View
    var rightButtonView: some View {
            CustomButton(style: .rounded, title: "Təmizlə", color: .clear, foregroundStyle: .primaryBlue) {
                resetFilters()
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
            })
            {
                ForEach(vm.organizations, id: \.self) { organization in
                    Text(organization.name ?? "")
                        .tag(organization.id)
                }
            }
            
            CustomPickerView(selection: $vm.selectedCategory, title: "Problemin kateqoriyası", textColor: vm.selectedCategory.name == "Kateqoriya" ? .gray : .black, isRightTextEditor: $vm.isRightTextEditor, onPickerTapped: {

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
            CustomButton(style: .rounded, title: "Tətbiq et", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                let selectedFilter = SelectedFilters(
                    organization: vm.selectedOrganization,
                    category: vm.selectedCategory,
                    status: vm.selectedStatus,
                    days: vm.selectedDate)
                
                homeViewModel.selectedFilters = selectedFilter
                homeViewModel.getMoreQuery()
                router.dismissView()
            }
            .disabled(vm.selectedStatus.name == "Status" && vm.selectedDate.name == "Tarix" &&  vm.selectedCategory.name == "Kateqoriya" &&  vm.selectedOrganization.name == "Qurum")
    }
    
    func resetFilters() {
        vm.selectedOrganization = OrganizationModel(id: UUID(), name: "Qurum")
        vm.selectedCategory = QueryCategoryModel(categoryID: 0, name: "Kateqoriya")
        vm.selectedStatus = StatusModel(id: UUID(), name: "Status")
        vm.selectedDate = DateModel(id: UUID(), name: "Tarix")
        
        homeViewModel.selectedFilters = nil
        homeViewModel.getMoreQuery()
    }
    
    var canContinue: Bool {
        return !(vm.selectedStatus.name == "Status" && vm.selectedDate.name == "Tarix" && vm.selectedCategory.name == "Kateqoriya" && vm.selectedOrganization.name == "Qurum")
    }
}

