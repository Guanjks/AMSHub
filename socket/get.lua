--Mayormente funciones
function runscripthttp(URL)
	lua_dostring(http.request(URL))
end


-- determines the size of a http file
function gethttpsize(u)
    local r, c, h = http.request {method = "HEAD", url = u}
    if c == 200 then
        return tonumber(h["content-length"])
    end
end

-- downloads a file using the http protocol
function getbyhttp(u, file)

local body, code = http.request(u)
if not body then error(code) end

local f = assert(io.open(file, 'wb')) -- open in "binary" mode
f:write(body)
f:close()
end


function DownloadResource(path,DownloadImg)
	FileInformation = String.SplitPath(DownloadImg);
	
	if file_exists(path) == false then
	getbyhttp(DownloadImg, path)
	end
end

function CheckVersionFile(file,Download)
	if file_exists(file) == false or gethttpsize(Download) ~= File.GetSize(file) then
	getbyhttp(Download, file)
	end
end

function nicesize(b)
    local l = "B"
    if b > 1024 then
        b = b / 1024
        l = "KB"
        if b > 1024 then
            b = b / 1024
            l = "MB"
            if b > 1024 then
                b = b / 1024
                l = "GB" -- hmmm
            end
        end
    end
    return string.format("%7.2f%2s", b, l)
end

function file_exists(name)
f=io.open(name,"r")
if f~=nil then io.close(f) return true else return false end
end
function file_read(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end
function file_size(file)
        local current = file:seek()      -- get current position
        local size = file:seek("end")    -- get file size
        file:seek("set", current)        -- restore position
        return size
end

function file_copy(src, dest)
  local content = file.read(src)
  file.write(dest, content)
end

function file_write(path, content, mode)
  mode = mode or 'w'
  local file, err = io.open(path, mode)
  if err then
    error(err)
  end
  file:write(content)
  file:close()
end


function round(num)
  local mult = 10^0
  return math.floor(num * mult + 0.5) / mult
end