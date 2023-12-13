//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by İsmail Can Akgün on 13.12.2023.
//

import Foundation

// Bu dosya, koleksiyon görünümü bölümlerini temsil edecek kodu içerecektir.

extension ReminderViewController {
    // Veri kaynağı, verilerinizdeki değişiklikleri belirlemek için karma değerleri kullandığından, bölüm ve öğe tanımlayıcı türleri Hashable uygun olmalıdır.
    enum Section: Int, Hashable {
        // Veri kaynağı, kullanıcı bir hatırlatıcının ayrıntılarını görüntülediğinde "görüntüle" adlı tek bir bölümde bilgi sağlar. Kullanıcı bir hatırlatıcının ayrıntılarını düzenlediğinde üç ayrı bölümde veri sağlar ve her bölüm hatırlatıcının özelliklerinden birini düzenlemek için kontroller içerir.
        case view
        case title
        case date
        case notes
        
        // Her bölüm için başlık metnini hesaplayan bir ad özelliği oluşturun.
        var name: String {
            switch self {
            case .view: return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
