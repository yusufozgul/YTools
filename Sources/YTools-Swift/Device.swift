#if canImport(UIKit)
import UIKit

public class Device {
    public static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    public static var currentBrightness: CGFloat {
        UIScreen.main.brightness
    }
    
    public static var isScreenRecording: Bool {
        UIScreen.main.isCaptured
    }
    
    public static var batteryState: UIDevice.BatteryState {
        UIDevice.current.batteryState
    }
    
    public static var batteryLevel: Float {
        UIDevice.current.batteryLevel
    }
    
    public static var model: String {
        UIDevice.current.model
    }
}
#endif
