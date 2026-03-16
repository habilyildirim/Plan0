#!/bin/lua
--[[

	Copyright (C) 2026 Kaan Ince

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program. If not, see <https://www.gnu.org/licenses/>.

]]

CC = "gcc";
SRC = "init.c";
OUT = "init";

function build()
    os.execute(CC .. " " .. SRC .. " -static -o " .. OUT);
    os.execute("find . | cpio -o -H newc > ../linux/rootfs.cpio");
end

function clear()
    os.execute("rm -f " .. OUT);
    os.execute("rm -f rootfs.cpio");
end

function run()
    os.execute("qemu-system-x86_64 " ..
        "-kernel arch/x86/boot/bzImage " ..
        "-initrd rootfs.cpio " ..
        "-append \"init=/init\" " ..
        "-m 512M -smp 1");
end

if (arg[1] == nil) then
    build();
elseif (arg[1] == "clear") then
    clear();
elseif (arg[1] == "run") then
    run();
else
    print("usage: lua build.lua [build|run|clear]");
end
