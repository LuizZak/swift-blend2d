// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Path command.
public extension BLPathCmd {
    /// Move-to command (starts a new figure).
    static let move = BL_PATH_CMD_MOVE
    
    /// On-path command (interpreted as line-to or the end of a curve).
    static let on = BL_PATH_CMD_ON
    
    /// Quad-to control point.
    static let quad = BL_PATH_CMD_QUAD
    
    /// Cubic-to control point (always used as a pair of commands).
    static let cubic = BL_PATH_CMD_CUBIC
    
    /// Close path.
    static let close = BL_PATH_CMD_CLOSE
    
    /// Maximum value of `BLPathCmd`.
    static let maxValue = BL_PATH_CMD_MAX_VALUE
}
