import UIKit

// MARK: - UIView ext
public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func makeSpace(inField: UITextField) {
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        inField.leftViewMode = .always
        inField.leftView = spacerView
        inField.rightViewMode = .always
        inField.rightView = spacerView
    }
    
}

// MARK: - UIColor ext
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}

// MARK: Setup custom colors
let customLightGray = UIColor.init(rgb: 0xF2F2F7)
let customPurple = UIColor.init(rgb: 0xA116CC)
let customBlue = UIColor.init(rgb: 0x296DFF)
let customGreen = UIColor.init(rgb: 0x1DB322)
let customIndigo = UIColor.init(rgb: 0x6236FF)
let customOrange = UIColor.init(rgb: 0xFF9F4F)
let customHeaderTable = UIColor.init(rgb: 0x8A8A8E)


let defaultInfoText = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n \n  1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n \n 2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n \n 3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться. \n \n 4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n \n 5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n \n 6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n \n Источник: psychbook.ru"
