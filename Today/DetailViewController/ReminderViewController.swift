import UIKit

// Bu sınıf, hatırlatıcı ayrıntılarının listesini düzenler ve listeyi hatırlatıcı ayrıntıları verileriyle birlikte sağlar.

class ReminderViewController: UICollectionViewController {
    // Veri kaynakları geneldir. Int ve Row genel parametrelerini belirterek, derleyiciye, veri kaynağınızın bölüm numaraları için Int örneklerini ve liste satırları için önceki bölümde tanımladığınız özel numaralandırma olan Row örneklerini kullandığı talimatını verirsiniz.
    
    // ReminderViewController.swift'te DataSource ve Snapshot takma adlarını Int yerine Bölüm kullanacak şekilde değiştirin. Section !!
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    // Reminder görünümü denetleyicisi bu hatırlatıcının ayrıntılarını görüntüler. Bunu bir değişken haline getirirsiniz çünkü gelecekteki bir eğitimde hatırlatıcıyı düzenleme yeteneği eklersiniz.
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

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
        /*
         Koleksiyon görünümleri varsayılan olarak bölüm başlıklarını içermez. Koleksiyon görünümünün yapılandırmasını başlıkları içerecek şekilde
         güncelleyeceksiniz.
         
         başlatıcıda liste yapılandırmasının başlık modunu .firstItemInSection olarak değiştirin.
         
         Deney
         Koleksiyon görünümlerinde başlıkları görüntülemenin diğer yollarını öğrenmek için UICollectionView'ı gözden geçirin.
         */
        listConfiguration.headerMode = .firstItemInSection
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
        // iOS 16, gezinme çubuğunuzun davranışını ve içerik yoğunluğunu özelleştirmenize izin veren gezinme stillerini destekler.
        // Uygulama iOS 16 veya sonraki sürümlerde çalıştığında gezinme çubuğunun stilini .navigator olarak ayarlayın.
        //.navigator stili, başlığı yatay olarak ortaya yerleştirir ve sol tarafta bir geri düğmesi içerir.
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        /* UIViewController'ın alt sınıfları, düzenleme moduna girip çıkmak için kullanacağınız bir editButtonItem özelliğine sahiptir.
         viewDidLoad()'da, editButtonItem'i gezinme öğesinin rightBarButtonItem özelliğine atayın. */
        // Bir Düzenle düğmesine dokunmak, başlığını otomatik olarak "Düzenle" ve "Bitti" arasında değiştirir.
        navigationItem.rightBarButtonItem = editButtonItem
        
        // updateSnapshot()'ı Control tuşuna basarak tıklayın, Yeniden Düzenleme > Yeniden Adlandır'ı seçin ve işlevin adını updateSnapshotForViewing olarak değiştirin.
        // Xcode, bir derleyici hatasını önlemek için çağrı sitesindeki işlev adını günceller.
        updateSnapshotForVeiwing()

    }
    /* Kullanıcı Düzenle veya Bitti düğmesine dokunduğunda sistem setEditing(_:animated:) işlevini çağırır. Görünüm ve düzenleme modları için ReminderViewController'ı güncellemek amacıyla bu yöntemi geçersiz kılacaksınız.
     
     setEditing(_:animated:) öğesini geçersiz kılın ve üst sınıfın uygulamasını çağırın. */
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Görünüm düzenleme moduna geçiyorsa, updateSnapshotForEditing() öğesini çağırın. Aksi takdirde updateSnapshotForViewing()'i çağırın.
        if editing {
            updateSnapshotForEditing()
        } else {
            updateSnapshotForVeiwing()
        }
    }

    // Bir hücreyi, dizin yolunu ve satırı kabul eden bir cellRegistrationHandler yöntemi oluşturun.
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // Ardından, görünüm ve düzenleme modlarını desteklemek için hücre yapılandırma kodunu yeniden düzenleyeceksiniz.
        // CellRegistrationHandler'da, bölümü dizin yolundan almak için bölüm(for:) yöntemini kullanın.
        let section = section(for: indexPath)
        // Hücreleri farklı bölüm ve satır birleşimlerine göre yapılandırmak için bir tanımlama grubu kullanarak bir switch ifadesi ekleyin. Switch ifadesi beklenmeyen bir satır veya bölümle eşleşmeye çalışırsa varsayılan durumda fatalError(_:file:line:) işlevini çağırın.
        // Bölüm ve satır değerlerini switch deyimi ile kullanabileceğiniz tek bir bileşik değerde gruplamak için bir demet kullanırsınız.
        switch (section, row) {
            // CellRegistrationHandler(cell:indexPath:row) öğesinde, bir başlık satırıyla eşleşen bir durum ekleyin ve başlık satırının ilişkili String değerini title adlı bir sabitte saklayın.
            // Bu durum her bölüm için başlığı yapılandırır.
        case (_, .header(let title)):
            // Not : Derleyici, bir sonraki adımda düzelteceğiniz bir hata oluşturur.
            // Hücrenin varsayılan yapılandırmasını alın ve bir değişkende saklayın.
            var contentConfiguration = cell.defaultContentConfiguration()
            // İçerik yapılandırmasının metin özelliğine başlık atayın.
            contentConfiguration.text = title
            // Yeni yapılandırmayı hücrenin contentConfiguration özelliğine atayın.
            cell.contentConfiguration = contentConfiguration
            // .view bölümündeki tüm satırlarla eşleşen bir durum ekleyin.
            // Alt çizgi karakteri (_), herhangi bir satır değeriyle eşleşen bir joker karakterdi
        case (.view, _):
            // Renk tonu rengiyle ilgili satır dışında mevcut hücre yapılandırma kodunu .viewküçük harf gövdesine taşıyın.
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
        default:
            fatalError("Unexpected combination of section and row")
        }
    
        // Hücrenin tintColor özelliğine .todayPrimaryTint değerini atayın
        cell.tintColor = .todayPrimaryTint
    }

    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        // ReminderViewController.swift'te, text(for:) dosyasına sıfır döndüren varsayılan bir büyük/küçük harf ekleyin.
        default: return nil
        }
    }
    
    // Snapshot, verilerin mevcut durumunu temsil eder. Düzenleme modu için anlık görüntüyü değiştirecek ve sonraki iki adımda uygulayacaksınız.
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        // Snapshot .title, .date ve .notes bölümlerini ekleyin.
        snapshot.appendSections([.title, .date, .notes])
        // updateSnapshotForEditing()'de her bölüme başlık öğeleri ekleyin.
        //name özelliği, başlıkta görüntüleyeceğiniz her durum için yerel ayara duyarlı bir dize hesaplar.
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        // Snapshot'ı veri kaynağına uygulayın.
        dataSource.apply(snapshot)
    }

    private func updateSnapshotForVeiwing() {
        var snapshot = Snapshot()
        // Denetleyici görünüm modundaysa, bir anlık görüntüyü yapılandırmak için bu yöntemi kullanacaksınız. Bu eğitimin ilerleyen bölümlerinde, düzenleme modu için bir anlık görüntü yapılandırmak üzere başka bir işlev oluşturacaksınız. .view için
        snapshot.appendSections([.view])
        // Görünüm modunun tek bir bölümü olduğundan, bir başbilgiye ihtiyacı yoktur.
        // updateSnapshotForViewing() işlevinde, anlık görüntü öğelerinin ilk öğesi olarak boş bir başlık öğesi ekleyin.
        snapshot.appendItems(
            [Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    // Bir dizin yolunu kabul eden ve bir Bölüm döndüren bir bölüm(for:) işlevi oluşturun.
    private func section(for indexPath: IndexPath) -> Section {
        // Bir bölüm numarası oluşturmak için dizin yolunu kullanın.
        //Görünüm modunda, tüm öğeler bölüm 0'da görüntülenir. Düzenleme modunda başlık, tarih ve notlar sırasıyla 1, 2 ve 3. bölümlere ayrılır.
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        // Bölüm örneğini oluşturmak için bölüm numarasını kullanın.
        // Ham değerle tanımlanan hızlı numaralandırmalar, sağlanan ham değer tanımlanan aralığın dışındaysa sıfır değerini döndüren başarısız bir başlatıcıya sahiptir.
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
        // Bölümü döndürmek derleyici hatasını düzeltir.
    }
}
