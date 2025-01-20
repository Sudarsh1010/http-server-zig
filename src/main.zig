const std = @import("std");
const socketConf = @import("socket.zig");
const requestConf = @import("request.zig");
const responseConf = @import("response.zig");
const methodConf = @import("method.zig");

const Method = methodConf.Method;
const Socket = socketConf.Socket;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try Socket.init();
    var server = try socket.address.listen(.{});

    while (true) {
        const connection = try server.accept();
        defer connection.stream.close();

        var buffer: [1000]u8 = undefined;
        @memset(&buffer, 0);

        _ = try requestConf.readRequest(connection, buffer[0..buffer.len]);
        const request = requestConf.parseRequest(buffer[0..buffer.len]);

        if (request.method == Method.GET) {
            if (std.mem.eql(u8, request.uri, "/")) {
                try responseConf.send200(connection);
            } else {
                try responseConf.send404(connection);
            }
        }
    }
}
