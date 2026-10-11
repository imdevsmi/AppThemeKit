import UIKit

/// Ready-made theme settings screen. Present it with `navigationController?.pushViewController(...)`.
public final class ThemeSettingsViewController: UITableViewController {

    private enum Section: Int, CaseIterable {
        case appearance
        case accent
    }

    private let manager: ThemeManager
    private let reuseID = "AppThemeKit.cell"

    public init(manager: ThemeManager = .shared) {
        self.manager = manager
        super.init(style: .insetGrouped)
        title = NSLocalizedString("theme", bundle: .main, value: "Theme", comment: "Theme settings screen title")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) is not supported") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
    }

    // MARK: - Data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section)! {
        case .appearance: return NSLocalizedString("appearance", bundle: .main, value: "Appearance", comment: "")
        case .accent:     return NSLocalizedString("accent_color", bundle: .main, value: "Accent Color", comment: "")
        }
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .appearance: return AppearanceMode.allCases.count
        case .accent:     return manager.accents.count
        }
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)

        switch Section(rawValue: indexPath.section)! {
        case .appearance:
            let mode = AppearanceMode.allCases[indexPath.row]
            cell.textLabel?.text = mode.title
            cell.imageView?.image = nil
            cell.accessoryType = (mode == manager.appearance) ? .checkmark : .none

        case .accent:
            let accent = manager.accents[indexPath.row]
            cell.textLabel?.text = accent.name
            cell.imageView?.image = Self.circleImage(color: accent.color)
            cell.accessoryType = (accent.id == manager.accentID) ? .checkmark : .none
        }
        return cell
    }

    // MARK: - Delegate

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch Section(rawValue: indexPath.section)! {
        case .appearance:
            manager.appearance = AppearanceMode.allCases[indexPath.row]
        case .accent:
            manager.accentID = manager.accents[indexPath.row].id
        }
        tableView.reloadData()
    }

    // MARK: - Helpers

    private static func circleImage(color: UIColor, size: CGFloat = 24) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        let image = renderer.image { _ in
            color.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).fill()
        }
        return image.withRenderingMode(.alwaysOriginal)
    }
}
