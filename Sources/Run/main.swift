import App
import Service
import Vapor
import Foundation

// you should use a proper health-check, but for the demo this is fine
if
    let param = ProcessInfo.processInfo.environment["SLEEP_LENGTH"],
    let duration = UInt32(param), duration > 0
{
    sleep(duration)
}

// The contents of main are wrapped in a do/catch block because any errors that get raised to the top level will crash Xcode
do {
    try app(.detect()).run()
} catch {
    print(error)
    exit(1)
}
