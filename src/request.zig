const std = @import("std");
const Connection = std.net.Server.Connection;
const Method = @import("method.zig").Method;

pub fn readRequest(conn: Connection, buffer: []u8) !void {
    const reader = conn.stream.reader();
    _ = try reader.read(buffer);
}

pub fn parseRequest(text: []u8) Request {
    const last_index = std.mem.indexOfScalar(u8, text, '\n') orelse text.len;
    var iterator = std.mem.splitScalar(u8, text[0..last_index], ' ');

    const method = try Method.init(iterator.next().?);
    const uri = iterator.next().?;
    const version = iterator.next().?;

    const request = Request.init(method, uri, version);
    return request;
}

pub const Request = struct {
    method: Method,
    uri: []const u8,
    version: []const u8,

    pub fn init(
        method: Method,
        uri: []const u8,
        version: []const u8,
    ) Request {
        return Request{ .method = method, .uri = uri, .version = version };
    }
};
