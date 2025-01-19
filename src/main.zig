const std = @import("std");
const SocketConf = @import("socket.zig").Socket;
const request = @import("request.zig");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try SocketConf.init();
    var server = try socket.address.listen(.{});
    const connection = try server.accept();

    var buffer: [1000]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }

    _ = try request.readRequest(connection, &buffer);
    try stdout.print("request: {s}\n", .{buffer});
}
