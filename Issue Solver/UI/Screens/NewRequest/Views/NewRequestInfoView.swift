//
//  NewRequestInfoView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 03.07.24.
//

import SwiftUI

struct NewRequestInfoView: View {
    
    
    var body: some View {
        VStack {
            titleView
            VStack(spacing: 48) {
                infoView
                warningView
            }
            Spacer()
        }
        //        .padding()
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    
    
    
    private var titleView: some View {
        CustomTitleView(title: "Məlumatlar və Xəbərdarlıqlar")
    }
    
    private var infoView: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Məlumatlar")
                    .jakartaFont(.custom(.regular, 28))
                Spacer()
            }
            VStack {
                HStack {
                    Text("Zəhmət olmasa, sorğunuzu aşağıdakı tələblərə uyğun şəkildə paylaşın:")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    //                        .jakartaFont(.custom(.regular, 17))
                }
                HStack(alignment: .top) {
                    Text("""
                        •
                        •
                        •
                        """
                    )
                    
                    .jakartaFont(.custom(.regular, 16))
                    
                    
                    Text(
                    """
                    Nəzakətli bir dil istifadə edin.
                    Dəqiq yerləri qeyd edin.
                    Problemin nə qədər müddətdir davam etdiyini bildirin.
                    """
                    )
                    Spacer()
                        .jakartaFont(.custom(.regular, 17))
                }
                
            }
        }
    }
    
    private var warningView: some View {
        
        VStack {
            HStack {
                Text("Xəbərdarlıqlar")
                    .jakartaFont(.custom(.regular, 28))
                Spacer()
            }
            VStack {
                HStack {
                    Text("Zəhmət olmasa, sorğunuzda aşağıdakı məlumatları daxil etməyin:")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    //                        .jakartaFont(.custom(.regular, 17))
                }
                HStack(alignment: .top) {
                    Text("""
                        •
                        
                        •
                        
                        •
                        """
                    )
                    
                    .jakartaFont(.custom(.regular, 17))
                    
                    
                    Text(
                    """
                    Şəxsi əlaqə məlumatları (telefon nömrəsi, e-poçt ünvanı, ev ünvanı və s.)
                    Başqalarını müəyyən edən məlumatlar (ad, soyad, FİN və s.)
                    Başqalarını ittiham edən ifadələr
                    """
                    )
                    Spacer()
                        .jakartaFont(.custom(.regular, 17))
                }
                
            }
        }
    }
}

#Preview {
    NewRequestInfoView()
}
