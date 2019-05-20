import CLibPNG

public extension PNGFile {
    static func fromRgba(_ pixels: [UInt32], width: Int, height: Int) -> PNGFile {
        return pixels.withUnsafeBufferPointer { pointer in
            return fromArgb(pointer, width: width, height: height)
        }
    }
    
    static func fromArgb(_ pixels: UnsafeBufferPointer<UInt32>, width: Int, height: Int) -> PNGFile {
        let rowLength = MemoryLayout<UInt32>.size * width
        var rows: [[png_byte]] = []
        
        for y in 0..<height {
            let start = y * width
            let end = start + width
            var row: [png_byte] = Array(repeating: 0, count: rowLength)
            
            row.withUnsafeMutableBytes { pointer in
                let p = pointer.bindMemory(to: UInt32.self)
                
                // Convert ARGB to RGBA
                for index in start..<end {
                    let pixel = pixels[index]

                    let shifted = (pixel << 8) | (pixel >> 24)
                    p[index - y * width] = shifted.byteSwapped
                }
            }
            
            rows.append(row)
        }
        
        return PNGFile(width: width,
                       height: height,
                       colorType: png_byte(PNG_COLOR_TYPE_RGB_ALPHA),
                       bitDepth: 8,
                       rows: rows,
                       rowLength: rowLength)
    }
}
