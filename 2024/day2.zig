const std = @import("std");
const buffer = @embedFile("data/day2.txt");
const parseInt = std.fmt.parseInt;
const MAX = 1000;

pub fn main() !void {
    var iter = std.mem.tokenizeAny(u8, buffer, "\n");
    var safeReports1: u16 = 0;
    var safeReports2: u16 = 0;

    while (iter.next()) |line| {
        if (try isSafe(line)) {
            safeReports1 += 1;
        }

        if (try partTwo(line)) {
            safeReports2 += 1;
        }
    }
    std.debug.print("Part one: {any}\n", .{safeReports1});
    std.debug.print("Part two: {any}\n", .{safeReports2});
}

pub fn isSafe(line: []const u8) !bool {
    var tok = std.mem.tokenizeAny(u8, line, " ");
    const direction = try parseInt(i8, tok.next().?, 10) - try parseInt(i8, tok.next().?, 10);
    tok.reset();
    while (tok.next()) |curr| {
        if (tok.peek()) |next| {
            const diff = try parseInt(i8, curr, 10) - try parseInt(i8, next, 10);
            if (direction < 0) {
                if (diff > -1 or diff < -3) {
                    return false;
                }
            } else if (diff > 3 or diff < 1) {
                return false;
            }
        }
    }
    return true;
}

pub fn partTwo(line: []const u8) !bool {
    if (try isSafe(line)) {
        return true;
    }

    return false;
}
