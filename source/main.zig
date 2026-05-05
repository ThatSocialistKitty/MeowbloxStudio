const std: type = @import("std");
const meowWindow: type = @import("MeowWindow");
const meowbloxClient: type = @import("MeowbloxClient");

pub fn main() !void {
    var debugAllocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debugAllocator.deinit();
    
    const allocator: std.mem.Allocator = debugAllocator.allocator();
    
    var window: *meowWindow.Window = try .create(allocator,"Test",.{500,325},.{});
    defer window.destroy();
    
    var client: *meowbloxClient.Client = try .create(allocator,meowWindow.Window.RawHandles,window.getRawHandles(),window.getSizePointer());
    defer client.destroy();
    
    while (window.stepMainLoop()) {
        defer client.stepMainLoop();
    }
}
