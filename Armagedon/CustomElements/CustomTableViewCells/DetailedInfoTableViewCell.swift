import UIKit

class DetailedInfoTableViewCell: UITableViewCell {
    private let asteroidDetailDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addSubview() {
        contentView.addSubview(asteroidDetailDataLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            asteroidDetailDataLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            asteroidDetailDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            asteroidDetailDataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            asteroidDetailDataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with asteroidDetailData: NearEarthObjects, detailsType: DetailsDataTypes, index: Int) {
        asteroidDetailDataLabel.text = DetailsDataTypes.getRow(index: index).title + ": " + detailsType.getValue(from: asteroidDetailData)
        if asteroidDetailData.isPotentiallyHazardousAsteroid  {
            asteroidDetailDataLabel.changeInNeedRangeColor(fullText: asteroidDetailDataLabel.text ?? "", changeText: "опасен")
        }
    }
}

