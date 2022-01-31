//
//  SketchTestViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/31/21.
//

import UIKit

class MainClubViewController: UIViewController {
    var swingsCollectionView: UICollectionView?
    var notesCollectionView: UICollectionView?

    func layoutCollectionView() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("currentSwingType", currentSwingType.rawValue)
        DispatchQueue.main.async {
            self.swingsCollectionView?.reloadData()
            self.notesCollectionView?.reloadData()
        }
        
        maxSwingContainer.updateYardage()
        tfSwingContainer.updateYardage()
        fullSwingContainer.updateYardage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutAllSubviews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    // MARK: - Setup Views NEW

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        return scrollView

    }()

    func setUpSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(yardagesLargeRectView)
        yardagesLargeRectView.addSubview(yardagesRectTitle)
        scrollView.addSubview(notesLargeRectView)
        notesLargeRectView.addSubview(notesRectTitle)

        yardagesLargeRectView.addSubview(tfSwingContainer.mainContainer)
        yardagesLargeRectView.addSubview(fullSwingContainer.mainContainer)
        yardagesLargeRectView.addSubview(maxSwingContainer.mainContainer)

        tfSwingContainer.layoutViews()

        fullSwingContainer.layoutViews()

        maxSwingContainer.layoutViews()
    }

    func layoutAllSubviews() {
        let setUpDimensions = view.bounds
        let padRectsFromSides: CGFloat = 10
        let padLabel: CGFloat = 4
        yardagesLargeRectView.frame = CGRect(x: padRectsFromSides,
                                             y: padRectsFromSides * 2,
                                             width: setUpDimensions.width - (2 * padRectsFromSides),
                                             height: 201)
        yardagesLargeRectView.dropShadow()
        yardagesRectTitle.frame = CGRect(x: padLabel,
                                         y: 2 * padRectsFromSides,
                                         width: setUpDimensions.width - 50,
                                         height: 50)

        addGestureRecognizers()

        notesLargeRectView.frame = CGRect(x: padRectsFromSides,
                                          y: yardagesLargeRectView.bottom + padRectsFromSides * 2,
                                          width: setUpDimensions.width - (2 * padRectsFromSides),
                                          height: 275)

        notesLargeRectView.dropShadow()
        notesRectTitle.frame = CGRect(x: padLabel,
                                      y: 2 * padRectsFromSides,
                                      width: setUpDimensions.width - 50,
                                      height: 50)

        swingsLargeRectView.frame = CGRect(x: padRectsFromSides,
                                           y: notesLargeRectView.bottom + padRectsFromSides * 2,
                                           width: setUpDimensions.width - (2 * padRectsFromSides),
                                           height: 150)
        swingsLargeRectView.dropShadow()

        swingsRectTitle.frame = CGRect(x: padLabel,
                                       y: 2 * padRectsFromSides,
                                       width: setUpDimensions.width - 50,
                                       height: 50)

        // MARK: Swing Types with Yardages

        tfSwingContainer.setupFrames(padFromSides: padRectsFromSides, leftNeighbor: nil, rightNeighbor: nil, topNeighbor: yardagesRectTitle)

        fullSwingContainer.setupFrames(padFromSides: padRectsFromSides, leftNeighbor: tfSwingContainer.mainContainer, rightNeighbor: nil, topNeighbor: yardagesRectTitle)

        maxSwingContainer.setupFrames(padFromSides: padRectsFromSides, leftNeighbor: fullSwingContainer.mainContainer, topNeighbor: yardagesRectTitle)

        // MARK: - SETUP AND MAKE NOTES COLLECTIONVIEW

        let notesLayout = UICollectionViewFlowLayout()
        notesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        notesLayout.itemSize = CGSize(width: notesLargeRectView.width - (notesLargeRectView.width / 5),
                                      height: notesLargeRectView.height - notesRectTitle.frame.maxY - padRectsFromSides - (5 * 2))
        notesLayout.scrollDirection = .horizontal
        let notesCollectionViewFrame = CGRect(x: padRectsFromSides,
                                              y: notesRectTitle.bottom + 5,
                                              width: (notesLargeRectView.width - padRectsFromSides * 2) * 0.75,
                                              height: notesLargeRectView.height - notesRectTitle.frame.maxY - padRectsFromSides)

        notesCollectionView = UICollectionView(frame: notesCollectionViewFrame, collectionViewLayout: notesLayout)

        if let notesCollectionView = notesCollectionView {
            print("MADE IT ")

            notesCollectionView.showsHorizontalScrollIndicator = false
            notesCollectionView.frame = CGRect(x: notesLargeRectView.frame.minX,
                                               y: notesRectTitle.bottom + 5,
                                               width: notesLargeRectView.frame.width - 20,
                                               height: notesLargeRectView.height - notesRectTitle.frame.maxY - padRectsFromSides)
            notesCollectionView.backgroundColor = .systemBackground

            notesCollectionView.delegate = self
            notesCollectionView.dataSource = self

            notesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NotesCell")

            notesLargeRectView.addSubview(notesCollectionView)
            notesCollectionView.addSubview(firstNoteRect)

        } else {
            print("DID NOT MAKE IT ")
        }

        let thisheight = notesLargeRectView.frame.maxY + 20
        scrollView.frame = CGRect(x: 0, y: 0, width: setUpDimensions.width, height: setUpDimensions.height)
        scrollView.contentSize = CGSize(width: setUpDimensions.width, height: thisheight)

        let tappedSwings = UITapGestureRecognizer(target: self, action: #selector(didTapSwingsButton))
        swingsLargeRectView.addGestureRecognizer(tappedSwings)
    }

    // MARK: - UIViews NEW

    // MARK: Large Rect Views

    let yardagesLargeRectView = LargeRect()
    let notesLargeRectView = LargeRect()
    let swingsLargeRectView = LargeRect()

    let maxSwingContainer = SwingTypeBox(type: .maxSwing)
    let fullSwingContainer = SwingTypeBox(type: .fullSwing)
    let tfSwingContainer = SwingTypeBox(type: .threeFourths)

    // MARK: Large Rect Titles

    let swingsRectTitle = RectTitle("Swings")
    let yardagesRectTitle = RectTitle("Yardages")
    let notesRectTitle = RectTitle("Notes")

    let firstSwingRect = customView()
    let firstNoteRect = customView()

    // MARK: - Button Actions

    @objc private func didTapYardagesButton() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.88)
        print("Yardages Was Tapped")
        yardagesLargeRectView.showAnimation {
        }
        // Create new view controller that will be used to edit club distance
        let clubVC = storyboard?.instantiateViewController(identifier: "SwingsViewController") as! SwingsViewController

        clubVC.title = "\(currentClub.name.capitalized) Swings"
        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(clubVC, animated: true)
    }

    @objc private func didTapTFSwing() {
        print("TF Was Tapped")
        currentSwingType = .threeFourths
        didTapSwingsButton()
    }

    @objc private func didTapFullSwing() {
        print("Full Was Tapped")
        currentSwingType = .fullSwing
        didTapSwingsButton()
    }

    @objc private func didTapMaxSwing() {
        print("Full Was Tapped")
        currentSwingType = .maxSwing
        didTapSwingsButton()
    }

    @objc private func didTapSwingsButton() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.88)
        print("Swings Was Tapped")
        swingsLargeRectView.showAnimation {
        }
        // Create new view controller that will be used to edit club distance
        let swingsVC = storyboard?.instantiateViewController(identifier: "SwingsViewController") as! SwingsViewController

        swingsVC.title = "\(currentClub.name.capitalized) Swings"
        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(swingsVC, animated: true)
    }

    @objc private func didTapNotesButton() {
        print("Notes Was Tapped")
        notesLargeRectView.showAnimation {
        }
        let notesVC = storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController

        notesVC.comingFrom = "club"

        navigationController?.pushViewController(notesVC, animated: true)
    }

    func addGestureRecognizers() {
        let tappedYardages = UITapGestureRecognizer(target: self, action: #selector(didTapYardagesButton))
        yardagesLargeRectView.addGestureRecognizer(tappedYardages)

        let tappedTF = UITapGestureRecognizer(target: self, action: #selector(didTapTFSwing))
        tfSwingContainer.mainContainer.addGestureRecognizer(tappedTF)

        let tappedFull = UITapGestureRecognizer(target: self, action: #selector(didTapFullSwing))
        fullSwingContainer.mainContainer.addGestureRecognizer(tappedFull)

        let tappedMax = UITapGestureRecognizer(target: self, action: #selector(didTapMaxSwing))
        maxSwingContainer.mainContainer.addGestureRecognizer(tappedMax)

        let tappedNotes = UITapGestureRecognizer(target: self, action: #selector(didTapNotesButton))
        notesLargeRectView.addGestureRecognizer(tappedNotes)
    }
}