//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

import UIKit

/*
 Koleksiyon görünümü veri kaynakları, verileri koleksiyon görünümünüzde yönetir. Ayrıca, koleksiyon görünümünün listenizdeki öğeleri görüntülemek için kullandığı hücreleri oluşturur ve yapılandırırlar.
 
 Reminder bir uzantı oluşturun.
 Bu uzantı, Reminder'ın hatırlatıcı listesine bir veri kaynağı olarak hareket etmesini sağlayan tüm davranışları içerecektir.
 */

extension ReminderListViewController {
    // Tür takma ad tanımlarınıReminderListViewController.swiftController+Data.swift taşıyın.
    // Bu türler, hatırlatıcı verileriniz için bölünebilir veri kaynağını ve anlık görüntüleri tanımlamanıza olanak tanır.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    /*
     Listeler, birden fazla veri türü için görüntüleyebilir. İlk hücre türünüzü aşağıdaki koleksiyonunuzla kaydedeceksiniz.

     Hücre, dizin yolu ve kimliği kabul eden cellRegistrationHandler adlı bir yöntem oluşturun.
     */
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        
        // Reminder.swift hücre kayıt kapanışından içeriği çıkarın ve bunları ReminderController+Data.swift yeni yönteminize ekleyin.
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        
        /*
         Hücreyi listeye kaydetmenin yanı sıra, görüntülenen bilgileri yapılandıracak ve hücre kayıt yöntemini kullanarak hücreyi biçimlendireceksiniz.
        
         ReminderController+Data.swift, hatırlatıcı bitiş tarihinin day içerik yapılandırmasının ikincil metnine atayın.
         */
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        
        // İkincil metnin yazı tipini .caption1 olarak değiştirin.
        // Hatırlatıcı başlığına daha fazla dikkat çekmek için tarih ve saati vurguluyorsunuz.
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
    }
}

/*
 Her hücrenin başlığının altında görüntülenen tarih bilgilerini görmek için uygulamayı oluşturun ve çalıştırın.
 ------------------
 UIKit uygulamalarında birçok sorumlulukları olduğundan, görünüm denetleyici dosyaları büyük olabilir. Görünüm denetleyicisi sorumluluklarını ayrı dosya ve uzantılar halinde yeniden düzenlemek,
 hataları bulmayı ve daha sonra yeni özellikler eklemeyi kolaylaştırır.
 */
