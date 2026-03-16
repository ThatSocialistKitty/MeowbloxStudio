const std: type = @import("std");
const meowWindow: type = @import("MeowWindow");

pub fn main() !void {
    var debugAllocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debugAllocator.deinit();
    
    var window: *meowWindow.Window = try .create(
        debugAllocator.allocator(),
        "meow :3",
        .{500,325},
        .Toplevel
    );
    defer window.destroy();
    
    while (window.stepEventLoop()) {
        // :p
    }
}
