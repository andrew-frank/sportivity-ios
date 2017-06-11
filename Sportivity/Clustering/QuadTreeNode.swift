//
//  QuadTreeNode.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import MapKit

struct QuadTreeNodeConstants {
    static let maxPointCapacity = 8
}

private typealias C = QuadTreeNodeConstants

class QuadTreeNode {
    
    enum NodeType {
        case leaf
        case `internal`(children: Children)
    }
    
    // TODO
    struct Children: Sequence {
        let northWest: QuadTreeNode
        let northEast: QuadTreeNode
        let southWest: QuadTreeNode
        let southEast: QuadTreeNode
        
        init(parentNode: QuadTreeNode) {
            let mapRect = parentNode.rect
            northWest = QuadTreeNode(rect: MKMapRect(minX: mapRect.minX, minY: mapRect.minY, maxX: mapRect.midX, maxY: mapRect.midY))
            northEast = QuadTreeNode(rect: MKMapRect(minX: mapRect.midX, minY: mapRect.minY, maxX: mapRect.maxX, maxY: mapRect.midY))
            southWest = QuadTreeNode(rect: MKMapRect(minX: mapRect.minX, minY: mapRect.midY, maxX: mapRect.midX, maxY: mapRect.maxY))
            southEast = QuadTreeNode(rect: MKMapRect(minX: mapRect.midX, minY: mapRect.midY, maxX: mapRect.maxX, maxY: mapRect.maxY))
        }
        
        struct ChildrenIterator: IteratorProtocol {
            private var index = 0
            private let children: Children
            
            init(children: Children) {
                self.children = children
            }
            
            mutating func next() -> QuadTreeNode? {
                defer { index += 1 }
                switch index {
                case 0: return children.northWest
                case 1: return children.northEast
                case 2: return children.southWest
                case 3: return children.southEast
                default: return nil
                }
            }
        }
        
        public func makeIterator() -> ChildrenIterator {
            return ChildrenIterator(children: self)
        }
    }
    
    var annotations = [MKAnnotation]()
    let rect: MKMapRect
    var type: NodeType = .leaf
    
    init(rect: MKMapRect) {
        self.rect = rect
    }
    
    // MARK: - Public methods
    
    @discardableResult
    func add(_ annotation: MKAnnotation) -> Bool {
        guard rect.contains(annotation.coordinate) else { return false }
        
        switch type {
        case .leaf:
            annotations.append(annotation)
            if annotations.count == C.maxPointCapacity {
                subdivide()
            }
        case .internal(let children):
            for child in children where child.add(annotation) {
                return true
            }
            
            fatalError("none of child nodes added the annotation")
        }
        return true
    }
    
    @discardableResult
    func remove(_ annotation: MKAnnotation) -> Bool {
        guard rect.contains(annotation.coordinate) else { return false }
        
        _ = annotations.map { $0.coordinate }.index(of: annotation.coordinate).map { annotations.remove(at: $0) }
        switch type {
        case .leaf: break
        case .internal(let children):
            for child in children where child.remove(annotation) {
                return true
            }
            
            fatalError("none of child nodes removed the annotation")
        }
        return true
    }
    
    func annotations(in rect: MKMapRect) -> [MKAnnotation] {
        guard self.rect.intersects(rect) else { return [] }
        
        var result = [MKAnnotation]()
        for annotation in annotations where rect.contains(annotation.coordinate) {
            result.append(annotation)
        }
        
        switch type {
        case .leaf: break
        case .internal(let children):
            for childNode in children {
                result.append(contentsOf: childNode.annotations(in: rect))
            }
        }
        
        return result
    }
    
}

private extension QuadTreeNode {
    func subdivide() {
        switch type {
        case .leaf:
            type = .internal(children: Children(parentNode: self))
        case .internal:
            fatalError("This node is already divided")
        }
    }
}
