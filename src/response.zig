const std = @import("std");
const Connection = std.net.Server.Connection;

pub fn send200(conn: Connection) !void {
    const status = "HTTP/1.1 200 OK\n";
    const content_length = "Content-Length: 48\n";
    const content_type = "Content-Type: text/html\n";
    const connection_status = "Connection: Closed\n\n";
    const body = "<html><body><h1>Hello, world!</h1></body></html>";

    const message = status ++ content_length ++ content_type ++ connection_status ++ body;
    _ = try conn.stream.write(message);
}

pub fn send404(conn: Connection) !void {
    const status = "HTTP/1.1 404 OK\n";
    const content_length = "Content-Length: 44\n";
    const content_type = "Content-Type: text/html\n";
    const connection_status = "Connection: Closed\n\n";
    const body = "<html><body><h1>Not Found</h1></body></html>";

    const message = status ++ content_length ++ content_type ++ connection_status ++ body;
    _ = try conn.stream.write(message);
}
