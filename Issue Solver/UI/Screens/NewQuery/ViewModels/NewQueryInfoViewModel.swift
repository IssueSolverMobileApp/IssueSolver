//
//  NewRequestInfoViewModel.swift
//  Issue Solver
//
//  Created by ValehAmirov on 04.07.24.
//

import Foundation

class NewQueryInfoViewModel: ObservableObject {
    
    @Published var infoSubTitleText: String  = "Zəhmət olmasa, sorğunuzu aşağıdakı tələblərə uyğun şəkildə paylaşın:"
    
    @Published var infoIconText: String = """
                                            •
                                            •
                                            •
                                          """
    
    @Published var infoText: String =                                        """
                    Nəzakətli bir dil istifadə edin.
                    Dəqiq yerləri qeyd edin.
                    Problemin nə qədər müddətdir davam etdiyini bildirin.
                    """
    @Published var warningSubTitleText: String = "Zəhmət olmasa, sorğunuzda aşağıdakı məlumatları daxil etməyin:"
    
    @Published var warningIconText: String = """
                                               •
                                             
                                               •
                                             
                                               •
                                             """
    
    @Published var warningText: String = """
                    Şəxsi əlaqə məlumatları (telefon nömrəsi, e-poçt ünvanı, ev ünvanı və s.)
                    Başqalarını müəyyən edən məlumatlar (ad, soyad, FİN və s.)
                    Başqalarını ittiham edən ifadələr
                    """
}
