Potemkin = {
	running = false, -- Currently not used
	lastUrl = nil
}

function Potemkin.LoadFileFromURL(url, callback)
	if not url then
		print("Please specify a URL")
		return
	end
	if not callback then
		print("Please specify a callback")
		return
	end
	print("Loading file at '" .. url .. "'")
	local request = http.get(url)
	local function tick()
		local status = request:status()
		if status == "running" then
			return
		elseif status == "done" then
			local response, code = request:finish()
			if code == 200 then
				callback(response)
			else
				print("Loading '" .. url .. "' failed with error code " .. code .. ". Try again with Potemkin.RetryLastURL()?")
			end
		end
	
		event.unregister(evt.tick, tick)
	end
	
	evt.register(evt.tick, tick)
end

function Potemkin.RunScriptFromURL(url)
	if not url then
		print("Please specify a URL")
		return
	end
	Potemkin.lastUrl = url
	Potemkin.LoadFileFromURL(url, function(luaScript)
		local f = loadstring(luaScript)
		if f then
			print("Successfully loaded '" .. url .. "'")
			f()
			Potemkin.running = true
		else
			print("Failed to execute script from '" .. url .. "'. Try again with Potemkin.RetryLastURL()?")
		end
	end)
end

function Potemkin.SetURL(url)
	if not url then
		print("Please specify a URL")
		return
	end
	MANAGER.savesetting("PotemkinLoader", "url", url)
	print("[PotemkinLoader] Startup URL set. Reload to run script.")
end

function Potemkin.RetryLastURL()
	if not Potemkin.lastUrl then
		print("No URL found to retry")
		return
	end
	Potemkin.RunScriptFromURL(Potemkin.lastUrl)
end

local url = MANAGER.getsetting("PotemkinLoader", "url")
if url then
	Potemkin.RunScriptFromURL(url)
else
	print("[PotemkinLoader] No URL configured. Type Potemkin.SetURL(url) in the console to set a URL to load on startup.")
end