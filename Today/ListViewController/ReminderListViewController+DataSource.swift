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
    
    /*
     Sonraki iki düzeltme, görünüm uzantısındaki tanımlayıcı türlerini güncelleyeceksiniz.

     ReminderListViewController+DataSource.swift'te, veri kaynağındaki ve anlık görüntü türü takma adlarındaki öğe tanımlayıcı türünü Reminder.ID olarak değiştirin.
     */
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    
    /*
     Listeler, birden fazla veri türü için görüntüleyebilir. İlk hücre türünüzü aşağıdaki koleksiyonunuzla kaydedeceksiniz.

     Hücre, dizin yolu ve kimliği kabul eden cellRegistrationHandler adlı bir yöntem oluşturun.
     
     CellRegistrationHandler parametre listesindeki tanımlayıcı türünü Reminder.ID olarak değiştirin.
     */
    func cellRegistrationHandler(cell:
                                 UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        
        // Reminder.swift hücre kayıt kapanışından içeriği çıkarın ve bunları ReminderController+Data.swift yeni yönteminize ekleyin.
        // Hatırlatıcıyı örnek veriler yerine yeni hatırlatıcılar dizisinden alın.
        // Sağlanan id hatırlatıcıyı almak için yeni yöntemi kullanmak üzere hücre kayıt işleyicisini güncelleyin.
        let reminder = reminder(withId: id)
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
        
        /*
         Not
         Görünüm değişimini döndürme derleyici hatasını düzeltir.

         Hücre kayıt işleyicisinde, hatırlatıcıyı ileterek yeni düğme yapılandırma yöntemini çağırın ve sonucu, doneButtonConfiguration adlı yeni bir değişkene atayın.
         */
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        
        // Bitti düğmesi yapılandırmasının tintColor özelliğine .todayListCellDoneButtonTint değerini atayın.
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        
        /*
         Deney
         Renkleri birkaç yolla oluşturabilirsiniz: kırmızı, yeşil ve mavi bileşenler sağlayarak; renk tonu, doygunluk ve parlaklık değerlerini sağlayarak; veya gri tonlamalı renkler için tek bir beyaz
         değeri sağlayarak. Diğer düğme renk tonu renkleri oluşturmak için bu UIColor başlatıcılarını kullanmayı deneyin. Yardıma ihtiyacınız varsa Renk oluşturma belgelerine bakın.

         Bir hücre aksesuarları dizisi oluşturun ve bunu hücrenin aksesuarlar özelliğine atayın.

         Dizi, yapılan düğmenin sıklığı ve her zaman açık açıklamanın gösterildiği özel bir görünüm içerir.
         */
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        // .listGroupCell() arka plan yapılandırmasını, arka plan Yapılandırması adlı bir değişkene atayın.
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        
        /*
         Başlangıç ​​projesi, kullanıcı arayüzü için bir dizi sakin, yumuşak renk içeren bir varlık kataloğu içerir. Ayrıca, bu renklere referans vermek için kullanacağınız UIColor'da statik değişkenlere sahip bir uzantı da içerir.

         .todayListCellBackground rengini arka plan yapılandırmasının arka plan rengi özelliğine atayın
         */
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        /*
         Yeni arka plan yapılandırmasını hücreninbackgroundConfiguration özelliğine atayın.

         Sağlanan arka plan rengini kullanmak, görünümün varsayılan arka plan rengini değiştirmekz. Bu patlamanın ardından bir bölümü düzelteceksiniz
         */
        cell.backgroundConfiguration = backgroundConfiguration
        
        /*
         Her hücrenin başlığının altında görüntülenen tarih bilgilerini görmek için uygulamayı oluşturun ve çalıştırın.
         ------------------
         UIKit uygulamalarında birçok sorumlulukları olduğundan, görünüm denetleyici dosyaları büyük olabilir. Görünüm denetleyicisi sorumluluklarını ayrı dosya ve uzantılar halinde yeniden düzenlemek,
         hataları bulmayı ve daha sonra yeni özellikler eklemeyi kolaylaştırır.
         */
    }
    // Daha sonra Array'e eklediğiniz indexOfReminder(withId:) yöntemini kullanan iki yöntem oluşturacaksınız. Hatırlatıcılara doğrudan erişmek yerine bu yöntemi kullanmak olası hataları azaltır ve kodunuzun bakımını kolaylaştırır.
    
    // ReminderController+Data.swift, bir hatırlatıcı tanımlayıcısını kabul eden ve hatırlatıcı dizisinden karşılık gelen hatırlatıcıyı döndüren bir yöntem oluşturun.
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    
    // Bir hatırlatıcıyı kabul eden ve karşılık gelen dizi öğesini hatırlatıcının içeriğiyle güncelleyen updateReminder(_:) adında bir yöntem oluşturun.
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    /*
     Ardından görünümün denetleyicisinde bir hatırlatıcıyı tamamlayan bir yöntem tanımlayacaksınız. Bu yöntem butona basıldığında çağırılacaktır.

     ReminderListViewController+DataSource.swift'te, Reminder.ID'yi kabul eden bir CompleteReminder(withId:) yöntemi oluşturun.

     Modelden bir hatırlatıcı almak için Reminder.ID'yi kullanacaksınız.
     */
    func completeReminder(widthId id: Reminder.ID) {
        // Hatırlatıcıyı (withId :) çağırarak hatırlatıcıyı alın.
        var reminder = reminder(withId: id)
        // Hatırlatıcının isComplete özelliğini değiştirin.
        reminder.isComplate.toggle()
        // Modeldeki hatırlatıcıyı güncellemek için updateReminder(_:) öğesini çağırın.
        updateReminder(reminder)
        // ReminderController+Data.swift, kod satırında hatırlatıcıyı güncelleyen bir kesme noktası ayarlayın.
    }
    
    // Bir hatırlatıcıyı kabul eden ve bir CustomViewConfiguration döndüren, doneButtonConfiguration adında yeni bir işlev oluşturun.
    private func doneButtonConfiguration(for reminder: Reminder)
    -> UICellAccessory.CustomViewConfiguration
    {
        /*
         Not
         Derleyici, fonksiyonun bir görünüm döngüsü dönene kadar bir hata oluşur.

         SembolAdı adlı bir sabite "circle.fill" veya "circle" atamak için üçlü koşul operatörünü kullanın.
         */
        let symbolName = reminder.isComplate ? "circle.fill" : "circle"
        
        /*
         Deney
         SF Sembolleri uygulamasını indirin. SF Sembolleri, Apple platformları için sistem yazı tipiyle sorunsuz bir şekilde entegre olmak üzere hazırlanmış bir ikonografi kitaplığıdır. Eksik ve eksik hatırlatıcıları temsil edecek alternatif görüntüler için belleğin içeriğinde arama yapın ve bunları Bugün'de kullanma hatası.

         .title1 metin stilini kullanarak yeni bir görüntü sembolü konfigürasyonu oluşturun ve sonucu, symConfiguration adlı bir sabite atayın.

         Sembollerin görüntülenmesine rağmen, metinle kaydettiğiniz yazı tipi hala gibi birçok özelliği barındırıyorlar.
         */
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        
        // Sembol yapılandırmasını kullanarak yeni bir görüntü oluşturun ve sonucu sabit bir adlandırılmış image atayın.
        let image = UIImage(systemName: symbolName, withConfiguration:  symbolConfiguration)
        
        /* Yeni bir ayarlama uyumu ve sonucu sabit olarak adlandırılmış bir düğme ataması.
        
           Şimdilik düğme, hatırlatıcının tamamlanma durumunun görsel bir temsili görevi görüyor. Gelecekteki bir eğitimde, bu kontrole, tüm özelliğin durumunu değiştiren bir eylem ekleyeceksiniz.
         
           ReminderListViewController+DataSource.swift'te, yeni ReminderDoneButton sınıfınızı kullanmak için düğme atamasını değiştirin.
        */
        let button = ReminderDoneButton()
        /*
         addTarget(_:action:for:) öğesini çağırarak düğmenin .touchUpInside olayını didPressDoneButton(_:) eylem yöntemine bağlayın.

         Derleme sırasında sistem, hedef ReminderListViewController'ın didPressDoneButton(_:) yöntemine sahip olup olmadığını kontrol eder.*/
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        // Hatırlatıcının tanımlayıcısını düğmenin id özelliğine atayın.
        button.id = reminder.id
        
        // Görüntüyü düğmenin normal durumuna atayın.
        // Bir UIButton nesnesini, normal durumdayken bir görüntüyü, vurgulandığında ise farklı bir görüntüyü görüntüleyecek şekilde yapılandırabilirsiniz.
        button.setImage(image, for: .normal)
        
        /*
         Hatırlatma hücresinin ön tarafına bir bitti düğme hücresi aksesuarı ekleyeceksiniz. Ayrıca bir liste hücresine onay işareti, yeniden sıralama, silme ve açıklama-gösterge hücresi aksesuarları
         ekleyebilirsiniz.
         
         Düğmeyi kullanarak özel bir görünüm yapılandırması oluşturun ve sonucu döndürün.
         Bu yapılandırma başlatıcı, hücre aksesuarının hücrenin içerik görünümünün dışında bir hücrenin ön veya arka kenarında görünüp görünmediğini tanımlamanıza olanak tanır.
         */
        return UICellAccessory.CustomViewConfiguration(customView: button,
                                                       placement: .leading(displayed: .always))
    }
    
    /*
     Deney
     Vurgulanan durumlarında farklı bir görüntü görüntülemek için hatırlatıcının bitti düğmelerini yapılandırın.
     ------------
     Sistemin tüm bölgelerdeki tarihleri ve saatleri doğru şekilde görüntülemesi için hatırlatıcı listesi hücrelerini biçimlendirip yapılandırdınız. Ve bir hatırlatıcının tamamlanıp tamamlanmadığını
     belirtmek için düğmeler eklediniz. Bir sonraki eğitimde, her yapılan düğme için eylemler sağlayacaksınız, böylece bir kullanıcı bir düğmeye dokunduğunda, uygulama hatırlatıcının tam durumunu
     değiştirir ve hücrenin görünümünü günceller.

     */
}

// Düğmelerin her hatırlatıcı için tamamlanma durumunu gösterdiğini görmek için uygulamayı oluşturun ve çalıştırın.
