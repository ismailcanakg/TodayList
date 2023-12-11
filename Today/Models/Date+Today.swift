//
//  Date+Today.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

// Modeller grubunda Date+Today.swift adında yeni bir Swift dosyası oluşturun. Date'e bir uzantı ekleyin.

import Foundation

extension Date {
    // dayAndTimeText adında hesaplanmış bir dize özelliği oluşturun.
    var dayAndTimeText: String {
        /*
         Olumsuz
         Siz dayAndTimeText için bir dize değeri döndürene kadar derleyici bir hata üretir.

         Swift Date değeri hem tarihi hem de saati içerir.
         
         Saatin dize temsilini oluşturmak için formatted(date:time:) yöntemini çağırın ve sonucu timeText adlı bir sabite atayın.

         Sistem, varsayılan bir stil kullanarak geçerli yerel ayar için tarih ve saatin dize gösterimini biçimlendirir. Tarih stili için .omid ifadesinin geçirilmesi, yalnızca zaman bileşeninden
         oluşan bir dize oluşturur.
         */
        let timeText = formatted(date: .omitted, time: .shortened)
        
        /*
         Uygulamanız, geçerli takvim günü için planlanan hatırlatıcılar için bir hatırlatıcının tarihini "Bugün saat 15:00" olarak görüntüleyerek aciliyet duygusu verecektir. Hatırlatıcının tarihi
         geçerli takvim gününden başka bir şeyse, "22 Ekim saat 15:00" gibi bir dize kullanacaksınız.
         
         Bu tarihin geçerli takvim gününde olup olmadığını test eden bir if-else ifadesi ekleyin.
         */
        if Locale.current.calendar.isDateInToday(self) {
            /*
             Ardından, dünyanın dört bir yanındaki kullanıcılarınız için dizenin "Bugün at" bölümünü yerelleştireceksiniz. Uygulamanıza, her dize ve çevirisi için bir giriş içeren bir çeviri tablosu
             ekleyeceksiniz.
             
             Biçimlendirilmiş bir zaman dizesi oluşturmak için NSLocalizedString(_:comment:) işlevini çağırın ve sonucu timeFormat adlı bir sabite atayın.

             Yorum parametresi, çevirmene, yerelleştirilmiş dizenin kullanıcıya sunumu hakkında bağlam sağlar.
             */

            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            
            // Zaman metnine timeFormat uygulayarak bir dize oluşturun ve sonucu döndürün.
            return String(format: timeFormat, timeText)
        } else {
            /*
             Daha sonra, sağlanan tarih geçerli takvim tarihinde olmadığında biçimlendirilmiş bir dize oluşturmak için Foundation çerçevesindeki formatted(date:time:) komutunu kullanacaksınız.

             Tarihin dize temsilini oluşturmak için formatted(_:) yöntemini çağırın ve sonucu dateText adlı bir sabite atayın.

             formatted(_:) yöntemi, kullanıcının geçerli yerel ayarına uygun bir tarih temsili oluşturmak için özel bir tarih formatı stili kullanır.
             */
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            
            // Tarih ve saati görüntülemek üzere biçimlendirilmiş bir dize oluşturmak için NSLocalizedString(_:comment:) işlevini çağırın ve sonucu dateAndTimeFormat adlı bir sabite atayın.
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            
            /*
             Tarih ve saat metnine dateAndTimeFormat uygulayarak bir dize oluşturun ve sonucu döndürün.

             Hesaplanan mülkünüz artık yerel ayarlara duyarlı bir biçimde tarih ve saati temsil ediyor.
             */
            return String(format: dateAndTimeFormat, dateText, timeText)
            // NOT: Biçimlendirilmiş dizenin döndürülmesi derleyici hatasını düzeltir.
        }
        /*
         Yalnızca tarihin biçimlendirilmiş ve yerelleştirilmiş dize temsilini döndüren dayText adında başka bir hesaplanmış özellik oluşturun. Ardından aşağıdaki adımlarda özel tarih biçimi içeren bir
         çözüme bakın.
         
         Bu tarihin geçerli takvim gününde olması durumunda statik bir dize döndüren dayText adında hesaplanmış bir dize özelliği oluşturun.
         */
        
        var dayText: String {
            if Locale.current.calendar.isDateInToday(self) {
                return NSLocalizedString("String", comment: "Today due date description")
            }/*
              Not
              ------
              Derleyici, bir sonraki düzenlemede bir dize gerçekleşene kadar bir hata üretir.

              Bu tarih geçerli günde değilse, tarihin dize temsilini oluşturmak ve sonucu döndürmek için formatted(_:) yöntemini çağırın.

              Bu biçimlendirilmiş yöntemle, yalnızca ay, gün ve haftayı içeren özel bir tarihi hala kabul eder.*/
            else {
                return formatted(.dateTime.month().day().weekday(.wide))
            }
        }
        
    }
}
