const std: type = @import("std");
const builtin: type = @import("builtin");

pub fn build(b: *std.Build) void {
    const target: std.Build.ResolvedTarget = b.standardTargetOptions(.{});
    const optimize: std.builtin.OptimizeMode = b.standardOptimizeOption(.{});
    
    const executable: *std.Build.Step.Compile = b.addExecutable(.{
        .name = "MeowbloxStudio",
        .root_module = b.createModule(.{
            .root_source_file = b.path("source/main.zig"),
            .target = target,
            .optimize = optimize,
            .strip = optimize != .Debug
        }),
        .use_llvm = true
    });
    
    {
        const dependency: *std.Build.Dependency = b.dependency("MeowUtilities",.{
            .target = target,
            .optimize = optimize
        });
        
        executable.root_module.addImport(
            "MeowUtilities",
            dependency.module("main")
        );
    }
    
    {
        const dependency: *std.Build.Dependency = b.dependency("MeowWindow",.{
            .target = target,
            .optimize = optimize
        });
        
        executable.root_module.addImport(
            "MeowWindow",
            dependency.module("main")
        );
        
        // executable.linkLibrary(dependency.artifact("dependencies"));
        // executable.addIncludePath(b.path("dependencies/engine/dependencies/Vulkan-Headers/include"));
    }
    
    {
        const dependency: *std.Build.Dependency = b.dependency("MeowbloxClient",.{
            .target = target,
            .optimize = optimize
        });
        
        const buildRuntimeDirectories: type = @import("dependencies/MeowbloxClient/developerDependencies/buildRuntimeDirectories.zig");
        buildRuntimeDirectories.main(b,dependency.path(""));
        
        executable.root_module.addImport(
            "MeowbloxClient",
            dependency.module("main")
        );
    }
    
    b.installArtifact(executable);
    
    const runStep: *std.Build.Step = b.step("run","Run ^w^");
    
    const runCommand: *std.Build.Step.Run = b.addRunArtifact(executable);
    runCommand.step.dependOn(b.getInstallStep());
    
    runStep.dependOn(&runCommand.step);
    
    if (b.args != null) {
        runCommand.addArgs(b.args.?);
    }
    
    const executableTests: *std.Build.Step.Compile = b.addTest(.{
        .root_module = executable.root_module
    });
    
    const runExecutableTests: *std.Build.Step.Run = b.addRunArtifact(executableTests);
    
    const testStep = b.step("test","Test >:3");
    testStep.dependOn(&runExecutableTests.step);
}
