//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by İsmail Can Akgün on 12.12.2023.
//

import UIKit

extension ReminderListViewController {
    /*
     ReminderDoneButton'u kabul eden bir didPressDoneButton(_:) yöntemi oluşturun.

     @objc özelliği, bu yöntemin Objective-C kodu için kullanılabilir olmasını sağlar. Bir sonraki bölümde, yöntemi özel düğmenize eklemek için bir Objective-C API kullanacaksınız.
     */
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        // Gönderenin isteğe bağlı kimliğini, sabit isimli bir kimliğe dönüştürün.
        guard let id = sender.id else { return }
        // CompleteReminder(withId:) öğesini çağırın.
        completeReminder(widthId: id)
    }
}
