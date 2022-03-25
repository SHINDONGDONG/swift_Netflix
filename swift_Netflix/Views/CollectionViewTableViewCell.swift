//
//  CollectionViewTableViewCell.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/11.
//

import UIKit

//protocol로 데이터를 프리뷰에 넘겨준다
protocol CollectionViewTableViewCellDelegate:AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    //MARK: Properties
    static let indentfier = "CollectionViewTableViewCell"
    
    weak var delegate:CollectionViewTableViewCellDelegate?
    
    private var title: [Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout을 선언하구 스크롤 다이렉션을 호리젠탈로 옆으로 할 수 있게만듬
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        //collectionview를 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //콜렉션뷰에 레지스터를 등록해준다. collectionviewcell을

        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    

    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
    configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //collectionview도 마찬가지로 크기가 지정되어있어야 표현이가능함.
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    
    
    //MARK: Configures
    func configure() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //데이터를 넣는작업이다.
    public func configures(with titles: [Title]) {
        self.title = titles
        //비동기작업
        DispatchQueue.main.async { [weak self] in
            //비동기작업이 될때 마다 리로드해준다.
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        
        DataPersistenceManager.shared.downloadTitleWith(model: title[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


@available(iOS 15.0, *)
extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        //선택한 title을 빼온다
        let title = title[indexPath.row]
        //영화의 title혹은 name을 titlename에 담아주고
        guard let titleName = title.title ?? title.name else {return}
        
        //youtube api의 쿼리로 넘겨준다.                  //실시간 비동기로 표현해야함.
        APICaller.shared.getMovei(with: titleName + " trailer") { [weak self] results in
            switch results {
                //넘어간 쿼리중 맞는 영화가 있으면
            case .success(let videoElement):
                //타이틀의 인덱스를 가져와서
                let title = self?.title[indexPath.row]
                //title모델의 overview를 가져온다.
                guard let titleOverView = title?.overview else { return }
                //자기자신을 리턴하는 상수
                guard let strongSelf = self else { return }
                //뷰모델에 현재 인덱스에 대한 titlename과 유튜브에 관한 엘리먼트, 타이틀 오버뷰를 가져온다.
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverView: titleOverView)
                //이것을 델리게이트로 넘겨준다.
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //collectionview지정이 없을땐 기본 uicollecionviewcell로 리턴해주라.
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
                return UICollectionViewCell()
            }

        //model에 poster_path를 당마주고
        guard let model = title[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        //titleCollectionviewcell의 configure 메서드에 넣어준다.
        cell.configure(with: model)
        
        return cell
    }
    
    //UIActionTap을 사용하여 다운로드 하는 방법
    //contextMenuConfigureationForItemAt으로 불러온다.
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        //config에 uicontextMenuConfigureation을 담아준다.
        let config = UIContextMenuConfiguration(
            //identifier,previewProvider, 등 현재 기능들은 nil로 해주고 그안에
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                //let downloadaction버튼을 만들어 uiaction을 만들어준다.
                let downloadAction = UIAction(title: "다운로드", subtitle: "ダウンロード", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                //이후 uimenu를 리터냏주고 그안에 칠드런이 downloadaction이 들어가있다.
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        return config
    }
    
}
