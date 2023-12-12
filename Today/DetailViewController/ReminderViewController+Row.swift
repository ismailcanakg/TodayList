//
//  ReminderViewController+Row.swift
//  Today
//
//  Created by İsmail Can Akgün on 12.12.2023.
//

import UIKit

extension ReminderViewController {
    // Ayrıntı görünümünde dört ayrı hatırlatma detayı göstereceksiniz: başlık, tarih, saat ve notlar.
    //Daha sonra ayrıntı listesindeki öğeleri temsil etmek için Row örneklerini kullanacaksınız. UIKit listelerine veri ve stil sağlayan farklı veri kaynakları, öğelerin Hashable'a uygun olmasını gerektirir. Fark edilebilir veri kaynağı, anlık görüntüler arasında hangi öğelerin değiştiğini belirlemek için karma değerlerini kullanır.
    enum Row: Hashable {
        case date
        case notes
        case time
        case title
        
        // Her durum için uygun bir SF Sembolü adı döndüren imageName adlı hesaplanmış bir özellik ekleyin.
        var imageName: String? {
            switch self {
            case .date: return "calender.circle"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }
        // Önceki bölümde, bir koleksiyon görünümünü liste olarak yapılandırmak için bir yapılandırma nesnesi kullandınız. Benzer şekilde, SF Sembolü görüntülerinin stilini yapılandırmak için bir sembol yapılandırma nesnesi kullanabilirsiniz.
        // UIImage.Symbol'ınızda, sembol resminize uygulamak için metin ağırlığı, yazı tipi, nokta boyutu ve ölçek dahil olmak üzere stil girişlerini ekleyebilirsiniz. Sistem, görüntünün hangi varyantının kullanılacağını ve görüntünün nasıl biçimleneceğini belirlemek için bu ayrıntıları kullanır.
        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        // Her hatırlatıcının başlığını vurgulamak için başlık yazı tipini kullanacaksınız.
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}
