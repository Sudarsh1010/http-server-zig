const std = @import("std");
const SocketConf = @import("socket.zig").Socket;

pub fn main() !void {
    _ = try SocketConf.init();
}
