//
//  DetailsVCTableViewDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-03-02.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

enum DetailsVCTableViewRows: String, CaseIterable {
    case zodiacSign = "Zodiac Sign"
    case chineseBirthday = "Chinese Birthday"
    case chineseYear = "Chinese Year"
    case birthday = "Gregorian Birthday"
    case solarTerm = "Solar Term"
    case stemBranch = "Stem-branch"
    case season = "Season"
    case lunarMonth = "Lunar Month"
    case fixedElement = "Fixed Element"
}

class DetailsVCTableViewDataSource: NSObject, UITableViewDataSource {

    let person: Person

    init(person: Person) {
        self.person = person
        super.init()
    }

    let cellIdentifier = "DetailsTableRowID"

    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )
        configureText(for: cell, at: indexPath.section)
        configureCellBackground(for: cell, at: indexPath.row)
        return cell
    }

    fileprivate func configureCellBackground(for cell: UITableViewCell, at row: Int) {
        let background: UIColor
        if #available(iOS 13, *) {
            background = .secondarySystemGroupedBackground
        } else {
            background = .white
        }
        cell.backgroundColor = background
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = getRow(at: section)
        return section.rawValue
    }

    fileprivate func configureText(for cell: UITableViewCell, at section: Int) {
        let section = getRow(at: section)
        cell.selectionStyle = .none
        let birthday = person.birthdate
        let zodiacName = person.zodiacName

        switch section {
        case .chineseBirthday:
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
            cell.textLabel?.text = updateChineseBirthday(birthday)
        case .chineseYear:
            cell.textLabel?.text = updateAhYear(birthday)
        case .birthday:
            cell.textLabel?.text = updateBirthday(birthday)
        case .zodiacSign:
            cell.textLabel?.text = updateZodiac(zodiacName)
        case .solarTerm:
            cell.textLabel?.text = updateSolarTerm(birthday)
        case .stemBranch:
            cell.textLabel?.text = updateStemBranch(birthday)
        case .season:
            cell.textLabel?.text = updateSeason(birthday)
        case .lunarMonth:
            cell.textLabel?.text = updateLunarMonth(birthday)
        case .fixedElement:
            cell.textLabel?.text = updateFixedTerm(birthday)
        }
    }

    fileprivate func getRow(at row: Int) -> DetailsVCTableViewRows {
        let allCases = DetailsVCTableViewRows.allCases
        let section = allCases[row]
        return section
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailsVCTableViewRows.allCases.count
    }

    fileprivate func updateZodiac(_ zodiacSign: String) -> String {
        return zodiacSign
    }

    fileprivate func updateBirthday(_ birthday: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: birthday)
    }

    func updateChineseBirthday(_ birthday: Date) -> String {
        return birthday.formatChineseCalendarDate()
    }

    func updateStemBranch(_ birthday: Date) -> String {
        return birthday.getStemBranch()
    }

    func updateAhYear(_ birthday: Date) -> String {
        if birthday.getYellowEmperorYear() > 1 {
            return "\(birthday.getYellowEmperorYear()) AH"
        } else {
            return "\(birthday.getYellowEmperorYear()) BH"
        }
    }

    func updateLunarMonth(_ birthday: Date) -> String {
        return birthday.getLunarMonth()
    }

    func updateSeason(_ birthday: Date) -> String {
        return birthday.getSeason()
    }

    func updateSolarTerm(_ birthday: Date) -> String {
        return birthday.getSolarTerm()
    }

    func updateFixedTerm(_ birthday: Date) -> String {
        return birthday.getFixedElement()
    }
}
