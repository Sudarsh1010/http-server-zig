const std = @import("std");
const Map = std.static_string_map.StaticStringMap;

const MethodMap = Map(Method).initComptime(.{.{ "GET", Method.GET }});

pub const Method = enum {
    GET,

    pub fn init(text: []const u8) !Method {
        return MethodMap.get(text).?;
    }

    pub fn isSupported(m: []const u8) bool {
        const method = MethodMap.get(m);
        if (method) |_| {
            return true;
        }
        return false;
    }
};
