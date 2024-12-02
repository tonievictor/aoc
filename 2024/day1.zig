const std = @import("std");
const buffer = @embedFile("data/day1.txt");
const parseInt = std.fmt.parseInt;
const MAX = 1000;
const sort = std.mem.sort;

pub fn main() !void {
    var c1: [MAX]u32 = undefined;
    var c2: [MAX]u32 = undefined;

    var iter = std.mem.splitAny(u8, buffer, "\n");
    var i: u32 = 0;
    while (iter.next()) |lines| {
        if (i == MAX) break;
        var line = std.mem.splitAny(u8, lines, "   ");
        const left = std.mem.trim(u8, line.first(), " ");
        c1[i] = try parseInt(u32, left, 10);
        const right = std.mem.trim(u8, line.rest(), " ");
        c2[i] = try parseInt(u32, right, 10);
        i += 1;
    }

    sort(u32, &c1, {}, std.sort.asc(u32));
    sort(u32, &c2, {}, std.sort.asc(u32));

    i = 0;
    var sum: u32 = 0;
    while (i < MAX) {
        if (c1[i] >= c2[i]) {
            sum += c1[i] - c2[i];
        } else {
            sum += c2[i] - c1[i];
        }
        i += 1;
    }
    std.debug.print("Total distance: {any}\n", .{sum});

    i = 0;
    sum = 0;
    while (i < MAX) {
        var k: u32 = 0;
        var occurence: u32 = 0;
        while (k < MAX) {
            if (c2[k] == c1[i]) occurence += 1;
            if (c2[k] > c1[i]) break;
            k += 1;
        }
        sum += c1[i] * occurence;
        i += 1;
    }
    std.debug.print("Similarity score: {any}\n", .{sum});
}
