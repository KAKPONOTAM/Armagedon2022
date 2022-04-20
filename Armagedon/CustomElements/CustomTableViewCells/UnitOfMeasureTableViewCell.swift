import UIKit
protocol UnitOfMeasureTableViewCellDelegate: AnyObject {
    func changeDistanceFormat(distanceFormat: DistanceFormat, selectedIndex: Int)
}

class UnitOfMeasureTableViewCell: UITableViewCell {
    weak var delegate: UnitOfMeasureTableViewCellDelegate?
    private var settings: SettingsButtonsStatements?
    
    private let unitOfMeasureDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Settings.unitOfMeasure.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var unitOfMeasureSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: DistanceFormat.kilometers.distanceFormat, at: DistanceFormat.kilometers.rawValue, animated: true)
        segment.insertSegment(withTitle: DistanceFormat.lunar.distanceFormat, at: DistanceFormat.lunar.rawValue, animated: true)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(unitOfMeasureSegmentedControlValueChanged), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        backgroundColor = .systemGray5
        
        guard let settings = SettingsManager.shared.receiveSettingsButtonsStatement() else { return }
        
        unitOfMeasureSegmentedControl.selectedSegmentIndex = settings.selectedIndex
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func unitOfMeasureSegmentedControlValueChanged() {
        let selectedIndex = unitOfMeasureSegmentedControl.selectedSegmentIndex
        let format = DistanceFormat.getFormat(atIndex: selectedIndex)
        delegate?.changeDistanceFormat(distanceFormat: format, selectedIndex: selectedIndex)
    }
    
    private func addSubview() {
        contentView.addSubview(unitOfMeasureDescriptionLabel)
        contentView.addSubview(unitOfMeasureSegmentedControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            unitOfMeasureDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            unitOfMeasureDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            unitOfMeasureDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2 / 3.5),
            unitOfMeasureDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            unitOfMeasureSegmentedControl.topAnchor.constraint(equalTo: unitOfMeasureDescriptionLabel.topAnchor),
            unitOfMeasureSegmentedControl.leadingAnchor.constraint(equalTo: unitOfMeasureDescriptionLabel.trailingAnchor),
            unitOfMeasureSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            unitOfMeasureSegmentedControl.bottomAnchor.constraint(equalTo: unitOfMeasureDescriptionLabel.bottomAnchor)
        ])
    }
}
