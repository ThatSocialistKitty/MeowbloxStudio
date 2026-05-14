const std: type = @import("std");
const builtin: type = @import("builtin");

pub fn build(builder: *std.Build) void {
    const target: std.Build.ResolvedTarget = builder.standardTargetOptions(.{});
    const optimize: std.builtin.OptimizeMode = builder.standardOptimizeOption(.{});
    
    const executable: *std.Build.Step.Compile = builder.addExecutable(.{
        .name = "MeowbloxStudio",
        .root_module = builder.createModule(.{
            .root_source_file = builder.path("source/main.zig"),
            .target = target,
            .optimize = optimize,
            .strip = optimize != .Debug
        }),
        .use_llvm = true
    });
    
    // MeowUtilities
    
    
        const meowUtilities: *std.Build.Dependency = builder.dependency("MeowUtilities",.{
            .target = target,
            .optimize = optimize
        });
        
        executable.root_module.addImport(
            "MeowUtilities",
            meowUtilities.module("main")
        );
    
    
    // MeowWindow
    
    
        const meowWindow: *std.Build.Dependency = builder.dependency("MeowWindow",.{
            .target = target,
            .optimize = optimize
        });
        
        executable.root_module.addImport(
            "MeowWindow",
            meowWindow.module("main")
        );
        
        // executable.linkLibrary(dependency.artifact("dependencies"));
        // executable.addIncludePath(builder.path("dependencies/engine/dependencies/Vulkan-Headers/include"));
    
    
    // MeowbloxClient
    
    
        const meowbloxClient: *std.Build.Dependency = builder.dependency("MeowbloxClient",.{
            .target = target,
            .optimize = optimize,
            .builder = @intFromPtr(builder)
        });
        
        executable.root_module.addImport(
            "MeowbloxClient",
            meowbloxClient.module("main")
        );
    
    
    builder.installArtifact(executable);
    
    const runStep: *std.Build.Step = builder.step("run","Run ^w^");
    
    const runCommand: *std.Build.Step.Run = builder.addRunArtifact(executable);
    runCommand.step.dependOn(builder.default_step);
    
    runStep.dependOn(&runCommand.step);
    
    if (builder.args != null) {
        runCommand.addArgs(builder.args.?);
    }
    
    const executableTests: *std.Build.Step.Compile = builder.addTest(.{
        .root_module = executable.root_module
    });
    
    const runExecutableTests: *std.Build.Step.Run = builder.addRunArtifact(executableTests);
    
    const testStep = builder.step("test","Test >:3");
    testStep.dependOn(&runExecutableTests.step);
}
