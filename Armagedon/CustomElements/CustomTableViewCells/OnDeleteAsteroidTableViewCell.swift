import UIKit

class OnDeleteAsteroidTableViewCell: UITableViewCell {
    private let asteroidNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubview() {
        contentView.addSubview(asteroidNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            asteroidNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            asteroidNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            asteroidNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            asteroidNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with nearObjectData: NearEarthObjects) {
        switch nearObjectData.isPotentiallyHazardousAsteroid {
        case true:
            backgroundColor = .red
            asteroidNameLabel.textColor = .white
            backgroundColor = UIColor(red: 255 / 255, green: 54 / 255, blue: 77 / 255, alpha: 1)
            
        case false:
           backgroundColor = UIColor(red: 154 / 255, green: 230 / 255, blue: 148 / 255, alpha: 1)
        }
        
        asteroidNameLabel.text = nearObjectData.name.changeAsteroidNameFormat
    }
}
