//
//  ReminderViewController.swift
//  Today
//
//  Created by İsmail Can Akgün on 12.12.2023.
//

import UIKit

// Bu sınıf, hatırlatıcı ayrıntılarının listesini düzenler ve listeyi hatırlatıcı ayrıntıları verileriyle birlikte sağlar.
class ReminderViewController: UICollectionViewController {
    // Reminder görünümü denetleyicisi bu hatırlatıcının ayrıntılarını görüntüler. Bunu bir değişken haline getirirsiniz çünkü gelecekteki bir eğitimde hatırlatıcıyı düzenleme yeteneği eklersiniz.
    var reminder: Reminder
    
    /* Not
     Derleyici, hatırlatıcı görünüm denetleyicisinin başlatıcısı olmadığı için bir hata oluşturur. Swift'te, sınıflar ve yapılar, bir örnek oluşturulduğunda
     depolanan tüm özelliklere bir başlangıç değeri atamalıdır.
     
     Bir hatırlatıcıyı kabul eden ve özelliği başlatan bir başlatıcı oluşturun. */
    init(reminder: Reminder) {
        self.reminder = reminder
        /* Not
         Derleyici gerekli başlatıcı init(coder:) hakkında yeni bir hata üretir. Bu başlatıcıyı daha sonra bu bölüme ekleyeceksiniz.

         .insetGrouped görünümünü kullanarak bir liste yapılandırması oluşturun ve sonucu listConfiguration adlı bir değişkene atayın.
         Birkaç özel istisna dışında, görünüm ve stilin çoğu için varsayılan yapılandırmayı kullanırsınız.*/
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // Liste hücreleri arasındaki satırları kaldırmak için liste yapılandırmasındaki ayırıcıları devre dışı bırakın.
        listConfiguration.showsSeparators = false
        // Sistemin öğeleri bir koleksiyon görünümünde nasıl düzenlediğini açıklamalısınız. UIKit, basit listeler, gruplandırılmış listeler ve ızgaralar gibi yaygın uygulamalar için mizanpajları tanımlayan kompozisyon düzeni sınıfları sağlar. Bir hatırlatıcının ayrıntılarını basit bir listede göstereceksiniz.
        //Bir liste kompozisyon düzeni, yalnızca bir liste için gereken düzen bilgilerini içerir.
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        // Sınıf Kalıtımı ve Başlatma'dan, bir Swift alt sınıfının başlatma sırasında üst sınıfının belirlenmiş başlatıcılarından birini çağırması gerektiğini hatırlayın.
        super.init(collectionViewLayout: listLayout)
    }
    /*
     Arayüz Oluşturucu, oluşturduğunuz görünüm denetleyicilerinin arşivlerini saklar. Bir görünüm denetleyicisi, sistemin böyle bir arşivi kullanarak
     başlatabilmesi için bir init(coder:) başlatıcıya ihtiyaç duyar. Görünüm denetleyicisinin kodu çözülemezse ve oluşturulamıyorsa başlatma başarısız olur.
     Başarısız bir başlatıcı kullanarak bir nesne oluştururken, sonuç, başarılı olması durumunda başlatılan nesneyi veya başlatma başarısız olursa sıfırı içeren
     bir isteğe bağlıdır.

     NSCoding gerektirdiği başarısız başlatıcıyı oluşturun.

     init(coder:)'ı dahil ederek gereksinimi karşılamış olursunuz. Today'de yalnızca kodda hatırlatıcı görünümü denetleyicileri oluşturduğunuz için uygulama bu
     başlatıcıyı hiçbir zaman kullanmaz
     */
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    func text(for row: Row) -> String {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes ?? ""
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
}
