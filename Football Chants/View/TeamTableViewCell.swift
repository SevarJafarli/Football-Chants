import UIKit

protocol TeamTableViewCellDelegate: AnyObject {
    func didTapPlayback(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    static let cellId = "TeamTableViewCell"
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    //MARK: - UI
    private lazy var containerView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackVw = UIStackView()
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        stackVw.spacing = 4
        stackVw.axis = .vertical
        return stackVw
    }()
    
    private lazy var badgeImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()
    
    private lazy var playbackBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        return btn
        
    }()
    
    private func commonLabel(fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor = .white) -> UILabel {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: fontSize,weight: fontWeight)
        lbl.textColor = textColor
        return lbl
    }
    private lazy var nameLabel: UILabel = {
        return commonLabel(fontSize: 18, fontWeight: .bold)
    }()
    
    private lazy var foundedLabel: UILabel = {
        return commonLabel(fontSize: 14, fontWeight: .light)
        
    }()
    
    private lazy var jobLabel: UILabel = {
        return commonLabel(fontSize: 14, fontWeight: .light)
        
        
    }()
    
    private lazy var infoLabel: UILabel = {
        return commonLabel(fontSize: 16, fontWeight: .medium)
        
    }()
    
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        self.delegate = nil
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    
    //MARK: - Configure Subviews
    
    func configure(with item: Team, delegate: TeamTableViewCellDelegate) {
        self.team = item
        self.delegate = delegate
        
        playbackBtn.addTarget(self, action: #selector(didTapPlayback), for: .touchUpInside)
        containerView.backgroundColor = item.id.background
        badgeImgVw.image = item.id.badge
        playbackBtn.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        
        nameLabel.text = item.name
        foundedLabel.text = item.founded
        jobLabel.text = "Current \(item.manager.job.rawValue): \(item.manager.name)"
        infoLabel.text = item.info
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(contentStackView)
        containerView.addSubview(badgeImgVw)
        containerView.addSubview(playbackBtn)
        
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(foundedLabel)
        contentStackView.addArrangedSubview(jobLabel)
        contentStackView.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImgVw.heightAnchor.constraint(equalToConstant: 50),
            badgeImgVw.widthAnchor.constraint(equalToConstant: 50),
            badgeImgVw.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            badgeImgVw.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: badgeImgVw.trailingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: playbackBtn.leadingAnchor, constant: -8),
            
            playbackBtn.heightAnchor.constraint(equalToConstant: 44),
            playbackBtn.widthAnchor.constraint(equalToConstant: 44),
            playbackBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            playbackBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    // on playback button tap
    @objc func didTapPlayback() {
        if let team = team {
            delegate?.didTapPlayback(for: team)
        }
    }
}
