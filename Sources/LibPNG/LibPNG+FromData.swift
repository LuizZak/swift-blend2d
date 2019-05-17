import CLibPNG

public extension PNGFile {
    static func fromRgba(_ pixels: [UInt32], width: Int, height: Int) -> PNGFile {
        return pixels.withUnsafeBufferPointer { pointer in
            return fromRgba(pointer, width: width, height: height)
        }
    }
    
    static func fromRgba(_ pixels: UnsafeBufferPointer<UInt32>, width: Int, height: Int) -> PNGFile {
        let rowLength = MemoryLayout<UInt32>.size * width
        var rows: [[png_byte]] = []
        
        for y in 0..<height {
            let start = y * width
            let end = start + width
            var row: [png_byte] = Array()
            row.reserveCapacity(rowLength)
            
            for pixel in pixels[start..<end] {
                row.append(png_byte((pixel >> 16) & 0xff))
                row.append(png_byte((pixel >> 8) & 0xff))
                row.append(png_byte((pixel) & 0xff))
                row.append(png_byte((pixel >> 24) & 0xff))
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
