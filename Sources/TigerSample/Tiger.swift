import SwiftBlend2D

public struct TigerPath {
    public var blPath = BLPath()
    public var blStrokeOptions = BLStrokeOptions()

    public var fillColor = BLRgba32()
    public var strokeColor = BLRgba32()

    public var fillRule: BLFillRule = .nonZero
    public var fill = false
    public var stroke = false
}

public class Tiger {
    public var paths: [TigerPath] = []
    
    public init() {
        initialize(commands: TigerData.commands, points: TigerData.points)
    }
    
    private func initialize(commands: [UnicodeScalar], points: [Double]) {
        var c = 0
        var p = 0
        
        let h = Double(TigerData.height)
        
        while c < commands.count {
            var tp = TigerPath()
            
            // Fill params.
            switch commands[c] {
            case "N":
                tp.fill = false
            case "F":
                tp.fill = true
                tp.fillRule = .nonZero
            case "E":
                tp.fill = true
                tp.fillRule = .evenOdd
            default:
                break
            }
            c += 1
            
            // Stroke params.
            switch commands[c] {
            case "N":
                tp.stroke = false
            case "S":
                tp.stroke = true
            default:
                break
            }
            c += 1
            
            switch commands[c] {
            case "B":
                tp.blStrokeOptions.setCaps(.butt)
            case "R":
                tp.blStrokeOptions.setCaps(.round)
            case "S":
                tp.blStrokeOptions.setCaps(.square)
            default:
                break
            }
            c += 1
            
            switch commands[c] {
            case "M":
                tp.blStrokeOptions.join = .miterBevel
            case "R":
                tp.blStrokeOptions.join = .round
            case "B":
                tp.blStrokeOptions.join = .bevel
            default:
                break
            }
            c += 1
            
            tp.blStrokeOptions.miterLimit = points[p]
            p += 1
            tp.blStrokeOptions.width = points[p]
            p += 1
            
            // Stroke & Fill style.
            tp.strokeColor = BLRgba32(r: UInt32(points[p + 0] * 255.0),
                                      g: UInt32(points[p + 1] * 255.0),
                                      b: UInt32(points[p + 2] * 255.0),
                                      a: 255)
            
            tp.fillColor = BLRgba32(r: UInt32(points[p + 3] * 255.0),
                                    g: UInt32(points[p + 4] * 255.0),
                                    b: UInt32(points[p + 5] * 255.0),
                                    a: 255)
            p += 6
            
            // Path.
            let count = Int(points[p])
            p += 1
            
            for _ in 0..<count {
                switch commands[c] {
                case "M":
                    tp.blPath.moveTo(x: points[p], y: h - points[p + 1])
                    p += 2
                case "L":
                    tp.blPath.lineTo(x: points[p], y: h - points[p + 1])
                    p += 2
                case "C":
                    tp.blPath.cubicTo(x1: points[p], y1: h - points[p + 1],
                                      x2: points[p + 2], y2: h - points[p + 3],
                                      x3: points[p + 4], y3: h - points[p + 5])
                    p += 6
                case "E":
                    tp.blPath.close()
                    
                default:
                    break
                }
                
                c += 1
            }
            
            tp.blPath.shrink()
            
            paths.append(tp)
        }
    }
}
