//
//  ViewController.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
// Diffable veri kaynağı için bir tür takma adı ekleyin.
//Tür takma adları, daha anlamlı bir isme sahip mevcut bir türe atıfta bulunmak için yararlıdır.
//    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
//    
// Diffable bir veri kaynağı anlık görüntüsü için bir tür takma adı ekleyin.
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // Bir DataSource'un paketini örtülü olarak açan bir dataSource özelliği ekleyin.
    /* Uyarı
    Örtük olarak sarılmamış isteğe bağlıları yalnızca isteğe bağlının bir değere sahip olacağını bildiğinizde kullanın.
     Aksi takdirde, uygulamayı hemen sonlandıran bir çalışma zamanı hatasını tetikleme riskiniz vardır. İsteğe bağlı
     olanın bir değere sahip olduğunu garanti etmek için bir sonraki adımda veri kaynağını başlatacaksınız.
     */
    
    var dataSource: DataSource!
    
    // Daha sonra görünüm denetleyicisine yeni bir hatırlatıcı özelliği ekleyeceksiniz. Anlık görüntüleri ve koleksiyon görünümü hücrelerini yapılandırmak için bu özelliği kullanacaksınız.
    // Bir dizi Hatırlatıcı örneğini depolayan bir hatırlatıcı özelliği ekleyin. Diziyi örnek verilerle başlatın.
    var reminders: [Reminder] = Reminder.sampleData
    
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
                  /* Veri kaynağının hücre sağlayıcısını, hatırlatıcıları tanımlamak için id özelliğini kullanacak şekilde yapılandıracaksınız.
                   
                   ReminderListViewController.swift'te, veri kaynağının başlatıcısındaki itemIdentifier türünü Reminder.ID olarak değiştirin.

                   Reminder.ID, Tanımlanabilir protokolün ilişkili türüdür. Hatırlatıcı durumunda String için bir tür takma adıdır.*/
                  itemIdentifier: Reminder.ID) in
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
        
        // Anımsatıcılar dizisini kullanarak anlık görüntüyü yapılandırın. Tanımlayıcı dizisini oluşturmak için title yerine id özelliğine eşleyin.
        snapshot.appendItems(Reminder.sampleData.map { $0.id})
        
        /*
         Anlık görüntüyü veri kaynağına uygulayın.
         Anlık görüntüyü uygulamak, kullanıcı arayüzündeki değişiklikleri yansıtır.
         */
        dataSource.apply(snapshot)
        
        // Reminder.swift viewLoad() yeni yöntemi çağırın.
        updateSnapshot()
        
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
    // ------------------------------------------------------
    // CollectionView(_:shouldSelectItemAt:) işlevini geçersiz kılın ve false değerini döndürün.
    // Kullanıcının dokunduğu öğeyi seçili olarak göstermiyorsunuz, bu nedenle false değerini döndürün. Bunun yerine söz konusu liste öğesinin ayrıntı görünümüne geçiş yapacaksınız.
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // Bu dizin yolu ile ilişkili hatırlatıcının tanımlayıcısını alın ve sabit adlandırılmış bir id atayın.
        // Bir indexPath'in item öğesinin bir Int olduğunu hatırlayın, böylece onu uygun hatırlatıcıyı almak için bir dizi dizini olarak kullanabilirsiniz.
        let id = reminders[indexPath.item].id
        // pushDetailViewForReminder(withId:) yöntemini çağırın.
        // Bu yöntem, gezinme yığınına bir ayrıntı görünümü denetleyicisi ekleyerek bir ayrıntı görünümünün ekrana girmesine neden olur. Ayrıntı görünümü, sağlanan tanımlayıcı için hatırlatıcı ayrıntılarını görüntüler. Ve bir Geri düğmesi, gezinme çubuğunda öndeki öğe olarak otomatik olarak görünür.
        pushDetailViewForReminder(widthId: id)
            return false
        }
    
    // ReminderListViewController.swift'te, hatırlatıcı tanımlayıcıyı kabul eden bir pushDetailViewForReminder(withId:) işlevi oluşturun.
    func pushDetailViewForReminder(widthId id: Reminder.ID) {
        // Modelin hatırlatıcı dizisinden tanımlayıcıyla eşleşen hatırlatıcıyı alın ve sabit bir adlandırılmış reminder atayın.
        let reminder = reminder(withId: id)
        // Önceki adımda aldığınız hatırlatıcıyı ayrıntı görünümü denetleyicisinin yeni bir örneğine enjekte edeceksiniz.
        // Yeni bir ayrıntı denetleyicisi oluşturun ve bunu sabit bir view atayın.
        let viewController = ReminderViewController(reminder: reminder)
        // navigationController yığınına itin.
        // Bir görünüm denetleyicisi halihazırda bir gezinme denetleyicisine katıştırılmışsa, gezinme denetleyicisine bir başvuru isteğe bağlı navigasyonController özelliğinde saklanır.
        navigationController?.pushViewController(viewController, animated: true)
    }
    
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
