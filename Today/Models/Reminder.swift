//
//  Reminer.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

import Foundation

struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplate: Bool = false
}

#if DEBUG 
/*
Örnek hatırlatıcı verilerinizi depolamak için dosyanın alt kısmına bir uzantı ekleyin ve uzantıyı #if DEBUG bloğunun içine yerleştirin.

#if DEBUG bayrağı, uygulamayı yayınlanmak üzere oluşturduğunuzda ekteki kodun derlenmesini önleyen bir derleme yönergesidir. Bu bayrağı, hata ayıklama yapılarında kodu test etmek veya bir sonraki adımda yapacağınız gibi örnek test verileri sağlamak için kullanabilirsiniz.
*/
extension Reminder {
    static var sampleData = [
        Reminder(
            title: "Sumbit reimbursement report",
            dueDate: Date().addingTimeInterval(800.0),
            notes: "Don't forget about taxi receipts"),
        Reminder(
            title: "Code rewiew",
            dueDate: Date().addingTimeInterval(14000.0),
            notes: "Check tech specs in shared folder", isComplate: true),
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
