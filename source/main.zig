const std: type = @import("std");
const builtin: type = @import("builtin");
const meowWindow: type = @import("MeowWindow");
const meowbloxClient: type = @import("MeowbloxClient");

pub fn main(init: std.process.Init) !void {
    var debugAllocator: ?std.heap.DebugAllocator(.{}) = null;
    var allocator: std.mem.Allocator = undefined;
    
    if (builtin.mode == .Debug) {
            debugAllocator = .init;
            allocator = debugAllocator.?.allocator();
    } else {
        allocator = std.heap.page_allocator;
    }
    defer if (builtin.mode == .Debug) {
        _ = debugAllocator.?.deinit();
    };
    
    var context: meowWindow.Context = .create(allocator,init.io,init.environ_map);
    
    var window: meowWindow.Window = try context.createWindow("Test",.{500,325},.{});
    defer window.destroy();
    
    var client: meowbloxClient.Client = try .create(allocator,init.io,meowWindow.Window.RawHandles,window.getRawHandles(),window.getSizePointer());
    defer client.destroy();
    
    while (window.stepMainLoop()) {
        defer client.stepMainLoop();
    }
}
