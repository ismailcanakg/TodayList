//
//  Reminer.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

import Foundation

struct Reminder: Identifiable /* Reminder.swift'te, Tanımlanabilir protokole uygunluğu beyan edin. */ {
    // UUID().uuidString varsayılan değerine sahip id adlı bir String özelliği ekleyin.
    // Foundation'daki UUID yapısı evrensel olarak benzersiz değerler üretir.
    var id: String = UUID().uuidString
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplate: Bool = false
}

// Reminder.swift, hatırlatıcı dizilerine bir kapsam ekler.
// Ayrıca genel bir türü koşullu olarak genişletmek için bir Where cümleciği de kullanabilirsiniz; Array burada Element == Reminder uzantısı gibi.
extension [Reminder] {
    /*
     Belirli bir hatırlatıcının dizinini döndüren bir işlev oluşturacaksınız.

     Bir kimlik bağımsız değişkenini kabul eden ve Self.Index'i döndüren indexOfReminder adında bir işlev oluşturun.

     Array.Index, Int için bir tür takma adıdır.
     */
    func indexOfReminder(withId id: Reminder.ID) -> Self.Index {
  
        /*
         Not
         Bir seçim dizin döndürmesi için derleyici bir hata oluşturur.

         Tanımlayıcıyla eşleşen bir öğenin ilk dizinini, adlı bir sabite atayan bir koruma ifadesi yazın.
         */
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        // Eşleşen dizini döndür.
        return index
    }
}


#if DEBUG 
/*
Örnek hatırlatıcı verilerinizi depolamak için dosyanın alt kısmına bir uzantı ekleyin ve uzantıyı #if DEBUG bloğunun içine yerleştirin.

#if DEBUG bayrağı, uygulamayı yayınlanmak üzere oluşturduğunuzda ekteki kodun derlenmesini önleyen bir derleme yönergesidir. Bu bayrağı, hata ayıklama yapılarında kodu test etmek veya bir sonraki adımda yapacağınız gibi örnek test verileri sağlamak için kullanabilirsiniz.
*/
extension Reminder {
    static var sampleData = [
        Reminder(
            title: "Günün her saati seni seviyorum",
            dueDate: Date().addingTimeInterval(800.0),
            notes: "Seni seviyorum demeyi unutma"),
        Reminder(
            title: "13.00- 13.30 yemek saati",
            dueDate: Date().addingTimeInterval(14000.0),
            notes: "Yemek yemeyi unutma", isComplate: true),
        Reminder(
            title: "Pick up new contacts",
            dueDate: Date().addingTimeInterval(24000.0),
            notes: "Optomertrist closes at 6:00PM"),
        Reminder(
            title: "Add notes to retrospective",
            dueDate: Date().addingTimeInterval(3200.0),
            notes: "Collaborate with project manager", isComplate: true),
        Reminder(
            title: "Interview new project manager candidate",
            dueDate: Date().addingTimeInterval(60000.0),
            notes: "Review portfolio"),
        Reminder(
            title: "Mock up onboarding experience",
            dueDate: Date().addingTimeInterval(72000.0),
            notes: "Think different"),
        Reminder(
            title: "Review usage analytics",
            dueDate: Date().addingTimeInterval(83000.0),
            notes: "Discuss trends with management"),
        Reminder(
            title: "Confirm group reservation",
            dueDate: Date().addingTimeInterval(92500.0),
            notes: "Ask about space heaters"),
        Reminder(
            title: "Add beta testers to TestFlight",
            dueDate: Date().addingTimeInterval(101000.0),
            notes: "v0.9 out on Friday")
    ]
}
#endif
