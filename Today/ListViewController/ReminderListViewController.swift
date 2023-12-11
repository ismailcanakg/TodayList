//
//  ViewController.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
//// Diffable veri kaynağı için bir tür takma adı ekleyin.
//// Tür takma adları, daha anlamlı bir isme sahip mevcut bir türe atıfta bulunmak için yararlıdır.
//    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
//    
//// Diffable bir veri kaynağı anlık görüntüsü için bir tür takma adı ekleyin.
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // Bir DataSource'un paketini örtülü olarak açan bir dataSource özelliği ekleyin.
    /* Uyarı
    Örtük olarak sarılmamış isteğe bağlıları yalnızca isteğe bağlının bir değere sahip olacağını bildiğinizde kullanın.
     Aksi takdirde, uygulamayı hemen sonlandıran bir çalışma zamanı hatasını tetikleme riskiniz vardır. İsteğe bağlı
     olanın bir değere sahip olduğunu garanti etmek için bir sonraki adımda veri kaynağını başlatacaksınız.
     */
    
    var dataSource: DataSource!
    // Ardından, koleksiyon görünümünü diffable veri kaynağı başlatıcısına geçirerek diffable veri kaynağını koleksiyon görünümüne bağlayacaksınız.
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // viewDidLoad() yönteminde yeni bir liste düzeni oluşturun.
       // Görünüm denetleyicisi görünüm hiyerarşisini belleğe yükledikten sonra sistem viewDidLoad() öğesini çağırır.
        let listLayout = listLayout()
        
        // Liste düzenini koleksiyon görünümü düzenine atayın.
        collectionView.collectionViewLayout = listLayout
        
        /*
         Reminder.swift, sondaki kapatmayı kaldırın ve yeni işlevinizi işleyici parametresi olarak iletin.
         Reminder.swift tüm veri kaynağı davranışını çıkarmak, daha düzenli Swift dosyalarıyla sonuçlanır. Görünüm denetleyicisi davranışları bir dosyada, veri kaynağı davranışları başka bir
         dosyadadır.
         */
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        // Yeni bir hücre kaydı oluşturun.
        // Hücre kaydı, bir hücrenin içeriğinin ve görünümünün nasıl yapılandırılacağını belirtir.
        
//        let cellRegistration = UICollectionView.CellRegistration {
//            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
//            
//            // Öğeye karşılık gelen hatırlatıcıyı alın.
//            let reminder = Reminder.sampleData[indexPath.item]
//            
//            // Hücrenin varsayılan içerik yapılandırmasını alın.
//            // defaultContentConfiguration() önceden tanımlanmış sistem stiliyle bir içerik yapılandırması oluşturur.
//            var contentConfiguration = cell.defaultContentConfiguration()
//            
//            // İçerik yapılandırma metnine hatırlatıcı.başlık atayın
//            // Liste, yapılandırma metnini bir hücrenin birincil metni olarak görüntüler.
//            
//            contentConfiguration.text = reminder.title
//            
//            // İçerik yapılandırmasını hücreye atayın.
//            cell.contentConfiguration = contentConfiguration
//        }
        
        // Yeni bir veri kaynağı oluşturun.
        //Başlatıcıda, bir koleksiyon görünümü için bir hücreyi yapılandıran ve döndüren bir kapatma iletirsiniz.
        //Kapatma, hücrenin koleksiyon görünümündeki konumuna giden bir dizin yolunu ve bir öğe tanımlayıcısını kabul eder.
        dataSource = DataSource(collectionView: collectionView) {
                 (collectionView: UICollectionView,
                  indexPath: IndexPath,
                  itemIdentifier: String) in
            // Not
            // Derleyici, kapatma bir sonraki adımda bir hücre döndürene kadar bir hata üretir.
            
            /*
             Hücre kaydını kullanarak bir hücreyi sıraya koyun ve döndürün.
             Her öğe için yeni bir hücre oluşturabilirsiniz, ancak başlatma maliyeti uygulamanızın performansını düşürür.
             Hücreleri yeniden kullanmak, uygulamanızın çok sayıda öğeyle bile iyi performans göstermesini sağlar.
             */
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: itemIdentifier)
            
            /*
             Hücre kaydını kullanarak bir hücreyi sıraya koyun ve döndürün.
             Her öğe için yeni bir hücre oluşturabilirsiniz, ancak başlatma maliyeti uygulamanızın performansını düşürür.
             Hücreleri yeniden kullanmak, uygulamanızın çok sayıda öğeyle bile iyi performans göstermesini sağlar.
             */
             }
        
        // viewLoad() yeni bir anlık görüntü değişkeni oluşturun.
        var snapshot = Snapshot()
        
        // Anlık görüntüye bölümleri ekleyin.
        // Şimdilik, tek bir bölüm ekliyorsunuz.
        snapshot.appendSections([0])
        
        // Yalnızca hatırlatıcı başlıklarını içeren yeni bir dizi oluşturun ve başlıkları anlık görüntüye öğe olarak ekleyin.
//        var reminderTitles = [String]()
//        for reminder in Reminder.sampleData {
//            reminderTitles.append(reminder.title)
//        }
//        snapshot.appendItems(reminderTitles)
        
        /*
         Önceki ödeme eklediğiniz kodu kısaltın.

         Bu versiyonda, map(_:) yalnızca anlık görüntüde öğe olarak doldurulan hatırlatıcı başlıklarını içeren yeni bir
         dizi döndürür
         */
        snapshot.appendItems(Reminder.sampleData.map { $0.title})
        
        /*
         Anlık görüntüyü veri kaynağına uygulayın.
         Anlık görüntüyü uygulamak, kullanıcı arayüzündeki değişiklikleri yansıtır.
         */
        dataSource.apply(snapshot)
        
        // Veri kaynağını koleksiyon görünümüne atayın.
        collectionView.dataSource = dataSource
        
        // Örnek hatırlatıcıların listesini doldurmak için uygulamayı oluşturun ve çalıştırın.

        /*
         Deney
         ------------
         Simülatör, fiziksel bir cihazı taklit etmek için birçok davranış içerir. Simülatör menü çubuğunda Cihaz'ı seçin ve
         cihazı döndürüp Ana Ekrana gitmeyi deneyin. Ayrıca, bir telefon görüşmesi sırasında veya yazılım klavyesi
         göründüğünde uygulamanızın nasıl davrandığı gibi özellikleri de test edebilirsiniz.
         */
    }

    // ReminderListViewController.swift'te, gruplandırılmış görünüme sahip yeni bir liste yapılandırma değişkeni oluşturan listLayout() adında yeni bir işlev oluşturun.
    //UICollectionLayoutListConfigurationliste düzeninde bir bölüm oluşturur.
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
           var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        // Ayırıcıları devre dışı bırakın ve arka plan rengini temizle.
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        // Liste yapılandırmasıyla yeni bir kompozisyon düzeni döndürün.
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
       }
}

/*
 Bu öğreticide, kompozisyon düzeni ve içerik yapılandırmalarını kullanarak kullanıcı arayüzü düzenine yeniden kullanılabilir
 yaklaşımlarla liste görünümünü prototiplediniz. Diffable bir veri kaynağı oluşturdunuz ve görünümün verilerinin ilk
 durumunu tanımladınız. Ardından, bu yaklaşımların birlikte nasıl çalıştığını tekrar gözden geçirecek ve koleksiyon
 görünümlerinizi ve verilerini hızlı bir şekilde oluşturmanızı ve yönetmenizi nasıl sağladığını keşfedeceksiniz.
 */
