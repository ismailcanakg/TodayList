import UIKit

// Bu sınıf, hatırlatıcı ayrıntılarının listesini düzenler ve listeyi hatırlatıcı ayrıntıları verileriyle birlikte sağlar.

class ReminderViewController: UICollectionViewController {
    // Veri kaynakları geneldir. Int ve Row genel parametrelerini belirterek, derleyiciye, veri kaynağınızın bölüm numaraları için Int örneklerini ve liste satırları için önceki bölümde tanımladığınız özel numaralandırma olan Row örneklerini kullandığı talimatını verirsiniz.
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    // Reminder görünümü denetleyicisi bu hatırlatıcının ayrıntılarını görüntüler. Bunu bir değişken haline getirirsiniz çünkü gelecekteki bir eğitimde hatırlatıcıyı düzenleme yeteneği eklersiniz.
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>

    var reminder: Reminder
    // dataSource adlı bir özellik ekleyin.
    private var dataSource: DataSource!

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
        başlatıcıyı hiçbir zaman kullanmaz*/
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
       /* Hücreyi koleksiyon görünümüne kaydetmek ve görünüm yüklendikten sonra veri kaynağını oluşturmak için görünüm denetleyicisinin yaşam döngüsüne müdahale
        edeceksiniz.
      
        Override viewDidLoad.
        
        Bir görünüm denetleyicisinin yaşam döngüsü yöntemini geçersiz kıldığınızda, önce üst sınıfa özel görevlerinizden önce kendi görevlerini yerine getirme şansı
        verirsiniz. */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bu bölümde daha önce yaptığınız işleyiciyi kullanarak yeni bir hücre kaydı oluşturun ve sonucu bir sabit namedcellRegistration'a atayın.
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        /*
         Uygulamanızdaki listeler, ekrana sığabilecekten çok daha fazla öğeyi potansiyel olarak tutabilir. Gereksiz hücre oluşturmadan kaçınmak için sistem,
         ekrandan çıktıktan sonra geri dönüştürülecek bir toplama hücresi kuyruğu tutar.
         
         Yeniden kullanılabilir bir hücreyi kuyruğa alan yeni bir veri kaynağı oluşturun ve sonucu data atayın. */
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")

        updateSnapshot()
    }

    // Bir hücreyi, dizin yolunu ve satırı kabul eden bir cellRegistrationHandler yöntemi oluşturun.
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // Bu yapılandırma, satırlara varsayılan stili atar.
        var contentConfiguration = cell.defaultContentConfiguration()
        //Satır için uygun metin ve yazı tipini yapılandırın.
        // text(for:) işlevini kullanarak verileri sağlayın ve önceki bölümde tanımladığınız satırların textStyle hesaplanan değişkenini kullanarak yazı tipi stilini sağlayın.
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        // Önceki bölümde tanımladığınız satırın görüntü hesaplanan değişkenini konfigürasyonun görüntü özelliğine atayın.
        contentConfiguration.image = row.image
        //Artık özelleştirmelerinizi varsayılan içeriğe ve yapılandırmanın stiline eklediğinize göre, özel yapılandırmayı koleksiyon görünümü hücresine uygulayın.
        // Yapılandırmayı hücrenin contentConfiguration özelliğine atayın.
        cell.contentConfiguration = contentConfiguration
        // Hücrenin tintColor özelliğine .todayPrimaryTint değerini atayın
        cell.tintColor = .todayPrimaryTint
    }

    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }

    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
        dataSource.apply(snapshot)
    }
}
