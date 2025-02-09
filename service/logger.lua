local ltask = require "ltask"

local S = {}

local function writelog()
	while true do
		local ti, id, msg, sz = ltask.poplog()
		if ti == nil then
			break
		end
		local tsec = ti // 100
		local msec = ti % 100
		local t = table.pack(ltask.unpack_remove(msg, sz))
		local str = {}
		for i = 1, t.n do
			str[#str+1] = tostring(t[i])
		end
		io.write(string.format("[%s.%02d : %08d]\t%s\n", os.date("%c", tsec), msec, id, table.concat(str, "\t")))
	end
end

local function loop()
	writelog()
	ltask.sleep(100)
end

ltask.timeout(0, loop)

function S.quit()
	writelog()
	ltask.quit()
end

return S
