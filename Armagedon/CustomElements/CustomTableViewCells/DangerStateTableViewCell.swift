import UIKit
protocol DangerStateTableViewCellDelegate: AnyObject {
    func changeToOnlyDangerousAsteroid(isDangerous: Bool)
}

class DangerStateTableViewCell: UITableViewCell {
    weak var delegate: DangerStateTableViewCellDelegate?
    private var settings: SettingsButtonsStatements?
    
    private let dangerStateDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Settings.isDangerous.title
        return label
    }()
    
    private lazy var dangerSwitcher: UISwitch = {
        let dangerSwitcher = UISwitch()
        dangerSwitcher.translatesAutoresizingMaskIntoConstraints = false
        dangerSwitcher.isOn = settings?.isDangerous ?? false
        dangerSwitcher.addTarget(self, action: #selector(dangerSwitchValueChanged), for: .allEvents)
        return dangerSwitcher
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        self.backgroundColor = .systemGray5
        guard let settings = SettingsManager.shared.receiveSettingsButtonsStatement() else { return }
        
        dangerSwitcher.isOn = settings.isDangerous
}

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func dangerSwitchValueChanged() {
        delegate?.changeToOnlyDangerousAsteroid(isDangerous: dangerSwitcher.isOn)
    }
    
    private func addSubview() {
        contentView.addSubview(dangerStateDescription)
        contentView.addSubview(dangerSwitcher)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dangerStateDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dangerStateDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dangerStateDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3 / 4),
            dangerStateDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            dangerSwitcher.topAnchor.constraint(equalTo: dangerStateDescription.topAnchor),
            dangerSwitcher.leadingAnchor.constraint(equalTo: dangerStateDescription.trailingAnchor ,constant: 10),
            dangerSwitcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dangerSwitcher.bottomAnchor.constraint(equalTo: dangerStateDescription.bottomAnchor)
        ])
    }
}
