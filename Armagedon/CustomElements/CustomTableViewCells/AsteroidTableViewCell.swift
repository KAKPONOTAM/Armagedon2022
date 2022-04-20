import UIKit
protocol AsteroidTableViewCellDelegate: AnyObject {
    func destroyButtonTapped(index: Int)
}

class AsteroidTableViewCell: UITableViewCell {
    weak var delegate: AsteroidTableViewCellDelegate?
    private var gradientColorsArray: [CGColor] = []
    private var objectIndex: Int?
    
    private lazy var destroyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Уничтожить", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(destroyButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let asteroidImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .topLeft
        return imageView
    }()
    
    private let dinosaurImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "dino")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let asteroidNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let approachDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hazardAssessmentLabel: UILabel = {
        let label = UILabel()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.layer.sublayers?.forEach { sublayer  in
            if sublayer.name == "gradient" {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.setGradientBackground(colors: gradientColorsArray)
    }
    
    @objc private func destroyButtonTapped() {
        delegate?.destroyButtonTapped(index: objectIndex ?? 0)
    }
    
    private func addSubview() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(asteroidImageView)
        containerView.addSubview(asteroidNameLabel)
        containerView.addSubview(dinosaurImageView)
        
        contentView.addSubview(diameterLabel)
        contentView.addSubview(approachDateLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(hazardAssessmentLabel)
        contentView.addSubview(destroyButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 5 / 10)
        ])
        
        NSLayoutConstraint.activate([
            asteroidImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            asteroidImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            asteroidImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1 / 2),
            asteroidImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1 / 2)
        ])
        
        NSLayoutConstraint.activate([
            asteroidNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            asteroidNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            asteroidNameLabel.topAnchor.constraint(equalTo: asteroidImageView.bottomAnchor, constant: 20),
            asteroidNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 3 / 4)
        ])
        
        NSLayoutConstraint.activate([
            dinosaurImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1 / 8),
            dinosaurImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            dinosaurImageView.bottomAnchor.constraint(equalTo: asteroidNameLabel.bottomAnchor),
            dinosaurImageView.centerYAnchor.constraint(equalTo: asteroidNameLabel.centerYAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            diameterLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            diameterLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            diameterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            diameterLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1 / 6)
        ])
        
        NSLayoutConstraint.activate([
            approachDateLabel.topAnchor.constraint(equalTo: diameterLabel.bottomAnchor, constant: 5),
            approachDateLabel.leadingAnchor.constraint(equalTo: diameterLabel.leadingAnchor),
            approachDateLabel.trailingAnchor.constraint(equalTo: diameterLabel.trailingAnchor),
            approachDateLabel.heightAnchor.constraint(equalTo: diameterLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: approachDateLabel.bottomAnchor, constant: 5),
            distanceLabel.leadingAnchor.constraint(equalTo: approachDateLabel.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: approachDateLabel.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalTo: approachDateLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hazardAssessmentLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            hazardAssessmentLabel.leadingAnchor.constraint(equalTo: distanceLabel.leadingAnchor),
            hazardAssessmentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 2),
            hazardAssessmentLabel.heightAnchor.constraint(equalTo: distanceLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            destroyButton.topAnchor.constraint(equalTo: hazardAssessmentLabel.topAnchor, constant: 0),
            destroyButton.leadingAnchor.constraint(equalTo: hazardAssessmentLabel.trailingAnchor),
            destroyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            destroyButton.bottomAnchor.constraint(equalTo: hazardAssessmentLabel.bottomAnchor)
        ])
    }
    
    func configure(with asteroidData: NearEarthObjects, distanceFormat: DistanceFormat, index: Int) {
        objectIndex = index
        guard let firstObject = asteroidData.closeApproachData.first else { return }
        
        let approachData = Date.changeAsteroidApproachDateFormat(approachDate: firstObject.asteroidApproachCloseData)
        
        let diameter = asteroidData.asteroidEstimatedDiameter.meters.asteroidMaximalDiameter
        let dangerState = asteroidData.isPotentiallyHazardousAsteroid
        
        asteroidNameLabel.text = asteroidData.name.changeAsteroidNameFormat
        approachDateLabel.text = "Подлетает \(approachData)"
        diameterLabel.text = "Диаметр: \(Int(diameter)) м"
        
        let size = AsteroidSize.size(for: Int(diameter))
        asteroidImageView.image = size.asteroidImage
        
        switch distanceFormat {
        case .kilometers:
            guard let kilometersDistance = asteroidData.closeApproachData.first?.distanceToEarth.kilometers else { return }
            let distanceCorrectFormat = kilometersDistance.distanceToEarthChangeValueFormat(distance: kilometersDistance)
            distanceLabel.text = "на расстояние \(distanceCorrectFormat) \(distanceFormat.distanceFormat)"
            
        case .lunar:
            guard let lunarDistance = asteroidData.closeApproachData.first?.distanceToEarth.lunar else { return }
            let distanceCorrectFormat = lunarDistance.distanceToEarthChangeValueFormat(distance: lunarDistance)
            distanceLabel.text = "на расстояние \(distanceCorrectFormat) \(distanceFormat.distanceFormat)"
        }
        
        switch dangerState {
        case true:
            let firstGradientColor = CGColor(red: 244 / 255, green: 177 / 255, blue: 156 / 255, alpha: 1)
            let secondGradientColor = CGColor(red: 255 / 255, green: 54 / 255, blue: 77 / 255, alpha: 1)
            
            hazardAssessmentLabel.changeInNeedRangeColor(fullText: "Оценка: опасен", changeText: "опасен")
            gradientColorsArray = [firstGradientColor, secondGradientColor]
            
        case false:
            let firstGradientColor = CGColor(red: 208 / 255, green: 235 / 255, blue: 137 / 255, alpha: 1)
            let secondGradientColor = CGColor(red: 154 / 255, green: 230 / 255, blue: 148 / 255, alpha: 1)
            
            hazardAssessmentLabel.text = "Оценка: не опасен"
            gradientColorsArray = [firstGradientColor, secondGradientColor]
        }
    }
}
