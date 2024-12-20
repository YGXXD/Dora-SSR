-- [yue]: Script/Dev/Entry.yue
local App = Dora.App -- 1
local _module_0 = Dora.ImGui -- 1
local ShowConsole = _module_0.ShowConsole -- 1
local package = _G.package -- 1
local DB = Dora.DB -- 1
local View = Dora.View -- 1
local Director = Dora.Director -- 1
local Size = Dora.Size -- 1
local thread = Dora.thread -- 1
local sleep = Dora.sleep -- 1
local Vec2 = Dora.Vec2 -- 1
local Color = Dora.Color -- 1
local Buffer = Dora.Buffer -- 1
local HttpClient = Dora.HttpClient -- 1
local json = Dora.json -- 1
local tonumber = _G.tonumber -- 1
local os = _G.os -- 1
local yue = Dora.yue -- 1
local IsFontLoaded = _module_0.IsFontLoaded -- 1
local LoadFontTTF = _module_0.LoadFontTTF -- 1
local table = _G.table -- 1
local Cache = Dora.Cache -- 1
local Texture2D = Dora.Texture2D -- 1
local pairs = _G.pairs -- 1
local tostring = _G.tostring -- 1
local string = _G.string -- 1
local print = _G.print -- 1
local xml = Dora.xml -- 1
local teal = Dora.teal -- 1
local wait = Dora.wait -- 1
local Routine = Dora.Routine -- 1
local Entity = Dora.Entity -- 1
local Platformer = Dora.Platformer -- 1
local Audio = Dora.Audio -- 1
local ubox = Dora.ubox -- 1
local tolua = Dora.tolua -- 1
local collectgarbage = _G.collectgarbage -- 1
local Wasm = Dora.Wasm -- 1
local HttpServer = Dora.HttpServer -- 1
local emit = Dora.emit -- 1
local Profiler = Dora.Profiler -- 1
local xpcall = _G.xpcall -- 1
local debug = _G.debug -- 1
local Log = Dora.Log -- 1
local math = _G.math -- 1
local AlignNode = Dora.AlignNode -- 1
local Label = Dora.Label -- 1
local Checkbox = _module_0.Checkbox -- 1
local Button = _module_0.Button -- 1
local SetNextWindowPosCenter = _module_0.SetNextWindowPosCenter -- 1
local SetNextWindowSize = _module_0.SetNextWindowSize -- 1
local PushStyleVar = _module_0.PushStyleVar -- 1
local Begin = _module_0.Begin -- 1
local TextColored = _module_0.TextColored -- 1
local SameLine = _module_0.SameLine -- 1
local TreeNode = _module_0.TreeNode -- 1
local TextWrapped = _module_0.TextWrapped -- 1
local OpenPopup = _module_0.OpenPopup -- 1
local BeginPopup = _module_0.BeginPopup -- 1
local Selectable = _module_0.Selectable -- 1
local Separator = _module_0.Separator -- 1
local BeginDisabled = _module_0.BeginDisabled -- 1
local setmetatable = _G.setmetatable -- 1
local ipairs = _G.ipairs -- 1
local threadLoop = Dora.threadLoop -- 1
local Keyboard = Dora.Keyboard -- 1
local SetNextWindowPos = _module_0.SetNextWindowPos -- 1
local PushStyleColor = _module_0.PushStyleColor -- 1
local SetNextWindowBgAlpha = _module_0.SetNextWindowBgAlpha -- 1
local Dummy = _module_0.Dummy -- 1
local ImGui = Dora.ImGui -- 1
local ShowStats = _module_0.ShowStats -- 1
local coroutine = _G.coroutine -- 1
local Image = _module_0.Image -- 1
local TextDisabled = _module_0.TextDisabled -- 1
local IsItemHovered = _module_0.IsItemHovered -- 1
local BeginTooltip = _module_0.BeginTooltip -- 1
local PushTextWrapPos = _module_0.PushTextWrapPos -- 1
local Text = _module_0.Text -- 1
local once = Dora.once -- 1
local SetNextItemWidth = _module_0.SetNextItemWidth -- 1
local InputText = _module_0.InputText -- 1
local Columns = _module_0.Columns -- 1
local PushID = _module_0.PushID -- 1
local ImageButton = _module_0.ImageButton -- 1
local NextColumn = _module_0.NextColumn -- 1
local SetNextItemOpen = _module_0.SetNextItemOpen -- 1
local ScrollWhenDraggingOnVoid = _module_0.ScrollWhenDraggingOnVoid -- 1
local _module_0 = { } -- 1
local Content, Path -- 11
do -- 11
	local _obj_0 = Dora -- 11
	Content, Path = _obj_0.Content, _obj_0.Path -- 11
end -- 11
local type <const> = type -- 12
App.idled = true -- 14
ShowConsole(false, true) -- 15
local moduleCache = { } -- 17
local oldRequire = _G.require -- 18
local require -- 19
require = function(path) -- 19
	local loaded = package.loaded[path] -- 20
	if loaded == nil then -- 21
		moduleCache[#moduleCache + 1] = path -- 22
		return oldRequire(path) -- 23
	end -- 21
	return loaded -- 24
end -- 19
_G.require = require -- 25
Dora.require = require -- 26
local searchPaths = Content.searchPaths -- 28
local useChinese = (App.locale:match("^zh") ~= nil) -- 30
local updateLocale -- 31
updateLocale = function() -- 31
	useChinese = (App.locale:match("^zh") ~= nil) -- 32
	searchPaths[#searchPaths] = Path(Content.assetPath, "Script", "Lib", "Dora", useChinese and "zh-Hans" or "en") -- 33
	Content.searchPaths = searchPaths -- 34
end -- 31
if DB:exist("Config") then -- 36
	local _exp_0 = DB:query("select value_str from Config where name = 'locale'") -- 37
	local _type_0 = type(_exp_0) -- 38
	local _tab_0 = "table" == _type_0 or "userdata" == _type_0 -- 38
	if _tab_0 then -- 38
		local locale -- 38
		do -- 38
			local _obj_0 = _exp_0[1] -- 38
			local _type_1 = type(_obj_0) -- 38
			if "table" == _type_1 or "userdata" == _type_1 then -- 38
				locale = _obj_0[1] -- 38
			end -- 40
		end -- 40
		if locale ~= nil then -- 38
			if App.locale ~= locale then -- 38
				App.locale = locale -- 39
				updateLocale() -- 40
			end -- 38
		end -- 38
	end -- 40
end -- 36
local Config = require("Config") -- 42
local config = Config("", "fpsLimited", "targetFPS", "fixedFPS", "vsync", "fullScreen", "alwaysOnTop", "winX", "winY", "winWidth", "winHeight", "themeColor", "locale", "editingInfo", "showStats", "showConsole", "showFooter", "filter", "engineDev", "webProfiler", "drawerWidth", "lastUpdateCheck", "updateNotification") -- 43
config:load() -- 68
if (config.fpsLimited ~= nil) then -- 69
	App.fpsLimited = config.fpsLimited -- 70
else -- 72
	config.fpsLimited = App.fpsLimited -- 72
end -- 69
if (config.targetFPS ~= nil) then -- 74
	App.targetFPS = config.targetFPS -- 75
else -- 77
	config.targetFPS = App.targetFPS -- 77
end -- 74
if (config.vsync ~= nil) then -- 79
	View.vsync = config.vsync -- 80
else -- 82
	config.vsync = View.vsync -- 82
end -- 79
if (config.fixedFPS ~= nil) then -- 84
	Director.scheduler.fixedFPS = config.fixedFPS -- 85
else -- 87
	config.fixedFPS = Director.scheduler.fixedFPS -- 87
end -- 84
local showEntry = true -- 89
local isDesktop = false -- 91
if (function() -- 92
	local _val_0 = App.platform -- 92
	return "Linux" == _val_0 or "Windows" == _val_0 or "macOS" == _val_0 -- 92
end)() then -- 92
	isDesktop = true -- 93
	if config.fullScreen then -- 94
		App.fullScreen = true -- 95
	elseif (config.winWidth ~= nil) and (config.winHeight ~= nil) then -- 96
		local size = Size(config.winWidth, config.winHeight) -- 97
		if App.winSize ~= size then -- 98
			App.winSize = size -- 99
			showEntry = false -- 100
			thread(function() -- 101
				sleep() -- 102
				sleep() -- 103
				showEntry = true -- 104
			end) -- 101
		end -- 98
		local winX, winY -- 105
		do -- 105
			local _obj_0 = App.winPosition -- 105
			winX, winY = _obj_0.x, _obj_0.y -- 105
		end -- 105
		if (config.winX ~= nil) then -- 106
			winX = config.winX -- 107
		else -- 109
			config.winX = 0 -- 109
		end -- 106
		if (config.winY ~= nil) then -- 110
			winY = config.winY -- 111
		else -- 113
			config.winY = 0 -- 113
		end -- 110
		App.winPosition = Vec2(winX, winY) -- 114
	end -- 94
	if (config.alwaysOnTop ~= nil) then -- 115
		App.alwaysOnTop = config.alwaysOnTop -- 116
	else -- 118
		config.alwaysOnTop = true -- 118
	end -- 115
end -- 92
if (config.themeColor ~= nil) then -- 120
	App.themeColor = Color(config.themeColor) -- 121
else -- 123
	config.themeColor = App.themeColor:toARGB() -- 123
end -- 120
if not (config.locale ~= nil) then -- 125
	config.locale = App.locale -- 126
end -- 125
local showStats = false -- 128
if (config.showStats ~= nil) then -- 129
	showStats = config.showStats -- 130
else -- 132
	config.showStats = showStats -- 132
end -- 129
local showConsole = false -- 134
if (config.showConsole ~= nil) then -- 135
	showConsole = config.showConsole -- 136
else -- 138
	config.showConsole = showConsole -- 138
end -- 135
local showFooter = true -- 140
if (config.showFooter ~= nil) then -- 141
	showFooter = config.showFooter -- 142
else -- 144
	config.showFooter = showFooter -- 144
end -- 141
local filterBuf = Buffer(20) -- 146
if (config.filter ~= nil) then -- 147
	filterBuf.text = config.filter -- 148
else -- 150
	config.filter = "" -- 150
end -- 147
local engineDev = false -- 152
if (config.engineDev ~= nil) then -- 153
	engineDev = config.engineDev -- 154
else -- 156
	config.engineDev = engineDev -- 156
end -- 153
if (config.webProfiler ~= nil) then -- 158
	Director.profilerSending = config.webProfiler -- 159
else -- 161
	config.webProfiler = true -- 161
	Director.profilerSending = true -- 162
end -- 158
if not (config.drawerWidth ~= nil) then -- 164
	config.drawerWidth = 200 -- 165
end -- 164
_module_0.getConfig = function() -- 167
	return config -- 167
end -- 167
_module_0.getEngineDev = function() -- 168
	if not App.debugging then -- 169
		return false -- 169
	end -- 169
	return config.engineDev -- 170
end -- 168
local updateCheck -- 172
updateCheck = function() -- 172
	return thread(function() -- 172
		local res = HttpClient:getAsync("https://api.github.com/repos/IppClub/Dora-SSR/releases/latest") -- 173
		if res then -- 173
			local data = json.load(res) -- 174
			if data then -- 174
				local major, minor, patch = App.version:match("(%d+)%.(%d+)%.(%d+)%.(%d+)") -- 175
				local a, b, c = tonumber(major), tonumber(minor), tonumber(patch) -- 176
				local sa, sb, sc = data.tag_name:match("v(%d+)%.(%d+)%.(%d+)") -- 177
				local na, nb, nc = tonumber(sa), tonumber(sb), tonumber(sc) -- 178
				if na < a then -- 179
					goto not_new_version -- 180
				end -- 179
				if na == a then -- 181
					if nb < b then -- 182
						goto not_new_version -- 183
					end -- 182
					if nb == b then -- 184
						if nc < c then -- 185
							goto not_new_version -- 186
						end -- 185
						if nc == c then -- 187
							goto not_new_version -- 188
						end -- 187
					end -- 184
				end -- 181
				config.updateNotification = true -- 189
				::not_new_version:: -- 190
				config.lastUpdateCheck = os.time() -- 191
			end -- 174
		end -- 173
	end) -- 191
end -- 172
if (config.lastUpdateCheck ~= nil) then -- 193
	local diffSeconds = os.difftime(os.time(), config.lastUpdateCheck) -- 194
	if diffSeconds >= 7 * 24 * 60 * 60 then -- 195
		updateCheck() -- 196
	end -- 195
else -- 198
	updateCheck() -- 198
end -- 193
local Set, Struct, LintYueGlobals, GSplit -- 200
do -- 200
	local _obj_0 = require("Utils") -- 200
	Set, Struct, LintYueGlobals, GSplit = _obj_0.Set, _obj_0.Struct, _obj_0.LintYueGlobals, _obj_0.GSplit -- 200
end -- 200
local yueext = yue.options.extension -- 201
local isChineseSupported = IsFontLoaded() -- 203
if not isChineseSupported then -- 204
	LoadFontTTF("Font/sarasa-mono-sc-regular.ttf", 20, "Chinese", function() -- 205
		isChineseSupported = true -- 206
	end) -- 205
end -- 204
local building = false -- 208
local getAllFiles -- 210
getAllFiles = function(path, exts, recursive) -- 210
	if recursive == nil then -- 210
		recursive = true -- 210
	end -- 210
	local filters = Set(exts) -- 211
	local files -- 212
	if recursive then -- 212
		files = Content:getAllFiles(path) -- 213
	else -- 215
		files = Content:getFiles(path) -- 215
	end -- 212
	local _accum_0 = { } -- 216
	local _len_0 = 1 -- 216
	for _index_0 = 1, #files do -- 216
		local file = files[_index_0] -- 216
		if not filters[Path:getExt(file)] then -- 217
			goto _continue_0 -- 217
		end -- 217
		_accum_0[_len_0] = file -- 218
		_len_0 = _len_0 + 1 -- 218
		::_continue_0:: -- 217
	end -- 218
	return _accum_0 -- 218
end -- 210
_module_0["getAllFiles"] = getAllFiles -- 218
local getFileEntries -- 220
getFileEntries = function(path, recursive, excludeFiles) -- 220
	if recursive == nil then -- 220
		recursive = true -- 220
	end -- 220
	if excludeFiles == nil then -- 220
		excludeFiles = nil -- 220
	end -- 220
	local entries = { } -- 221
	local excludes -- 222
	if excludeFiles then -- 222
		excludes = Set(excludeFiles) -- 223
	end -- 222
	local _list_0 = getAllFiles(path, { -- 224
		"lua", -- 224
		"xml", -- 224
		yueext, -- 224
		"tl" -- 224
	}, recursive) -- 224
	for _index_0 = 1, #_list_0 do -- 224
		local file = _list_0[_index_0] -- 224
		local entryName = Path:getName(file) -- 225
		if excludes and excludes[entryName] then -- 226
			goto _continue_0 -- 227
		end -- 226
		local entryAdded = false -- 228
		for _index_1 = 1, #entries do -- 229
			local _des_0 = entries[_index_1] -- 229
			local ename = _des_0[1] -- 229
			if entryName == ename then -- 230
				entryAdded = true -- 231
				break -- 232
			end -- 230
		end -- 232
		if entryAdded then -- 233
			goto _continue_0 -- 233
		end -- 233
		local fileName = Path:replaceExt(file, "") -- 234
		fileName = Path(path, fileName) -- 235
		local entry = { -- 236
			entryName, -- 236
			fileName -- 236
		} -- 236
		entries[#entries + 1] = entry -- 237
		::_continue_0:: -- 225
	end -- 237
	table.sort(entries, function(a, b) -- 238
		return a[1] < b[1] -- 238
	end) -- 238
	return entries -- 239
end -- 220
local getProjectEntries -- 241
getProjectEntries = function(path) -- 241
	local entries = { } -- 242
	local _list_0 = Content:getDirs(path) -- 243
	for _index_0 = 1, #_list_0 do -- 243
		local dir = _list_0[_index_0] -- 243
		if dir:match("^%.") then -- 244
			goto _continue_0 -- 244
		end -- 244
		local _list_1 = getAllFiles(Path(path, dir), { -- 245
			"lua", -- 245
			"xml", -- 245
			yueext, -- 245
			"tl", -- 245
			"wasm" -- 245
		}) -- 245
		for _index_1 = 1, #_list_1 do -- 245
			local file = _list_1[_index_1] -- 245
			if "init" == Path:getName(file):lower() then -- 246
				local fileName = Path:replaceExt(file, "") -- 247
				fileName = Path(path, dir, fileName) -- 248
				local entryName = Path:getName(Path:getPath(fileName)) -- 249
				local entryAdded = false -- 250
				for _index_2 = 1, #entries do -- 251
					local _des_0 = entries[_index_2] -- 251
					local ename = _des_0[1] -- 251
					if entryName == ename then -- 252
						entryAdded = true -- 253
						break -- 254
					end -- 252
				end -- 254
				if entryAdded then -- 255
					goto _continue_1 -- 255
				end -- 255
				local examples = { } -- 256
				local tests = { } -- 257
				local examplePath = Path(path, dir, Path:getPath(file), "Example") -- 258
				if Content:exist(examplePath) then -- 259
					local _list_2 = getFileEntries(examplePath) -- 260
					for _index_2 = 1, #_list_2 do -- 260
						local _des_0 = _list_2[_index_2] -- 260
						local name, ePath = _des_0[1], _des_0[2] -- 260
						local entry = { -- 261
							name, -- 261
							Path(path, dir, Path:getPath(file), ePath) -- 261
						} -- 261
						examples[#examples + 1] = entry -- 262
					end -- 262
				end -- 259
				local testPath = Path(path, dir, Path:getPath(file), "Test") -- 263
				if Content:exist(testPath) then -- 264
					local _list_2 = getFileEntries(testPath) -- 265
					for _index_2 = 1, #_list_2 do -- 265
						local _des_0 = _list_2[_index_2] -- 265
						local name, tPath = _des_0[1], _des_0[2] -- 265
						local entry = { -- 266
							name, -- 266
							Path(path, dir, Path:getPath(file), tPath) -- 266
						} -- 266
						tests[#tests + 1] = entry -- 267
					end -- 267
				end -- 264
				local entry = { -- 268
					entryName, -- 268
					fileName, -- 268
					examples, -- 268
					tests -- 268
				} -- 268
				local bannerFile = Path(path, Path:getPath(fileName), "Image", "banner.png") -- 269
				if not Content:exist(bannerFile) then -- 270
					bannerFile = Path(path, Path:getPath(fileName), "Image", "banner.jpg") -- 271
					if not Content:exist(bannerFile) then -- 272
						bannerFile = nil -- 272
					end -- 272
				end -- 270
				if bannerFile then -- 273
					thread(function() -- 273
						if Cache:loadAsync(bannerFile) then -- 274
							local bannerTex = Texture2D(bannerFile) -- 275
							if bannerTex then -- 276
								entry[#entry + 1] = bannerFile -- 277
								entry[#entry + 1] = bannerTex -- 278
							end -- 276
						end -- 274
					end) -- 273
				end -- 273
				entries[#entries + 1] = entry -- 279
			end -- 246
			::_continue_1:: -- 246
		end -- 279
		::_continue_0:: -- 244
	end -- 279
	table.sort(entries, function(a, b) -- 280
		return a[1] < b[1] -- 280
	end) -- 280
	return entries -- 281
end -- 241
local gamesInDev, games -- 283
local doraTools, doraExamples, doraTests -- 284
local cppTests, cppTestSet -- 285
local allEntries -- 286
local _anon_func_0 = function(App) -- 294
	if not App.debugging then -- 294
		return { -- 294
			"ImGui" -- 294
		} -- 294
	end -- 294
end -- 294
local updateEntries -- 288
updateEntries = function() -- 288
	gamesInDev = getProjectEntries(Content.writablePath) -- 289
	games = getProjectEntries(Path(Content.assetPath, "Script")) -- 290
	doraTools = getFileEntries(Path(Content.assetPath, "Script", "Tools"), false) -- 292
	doraExamples = getFileEntries(Path(Content.assetPath, "Script", "Example")) -- 293
	doraTests = getFileEntries(Path(Content.assetPath, "Script", "Test"), true, _anon_func_0(App)) -- 294
	cppTests = { } -- 296
	local _list_0 = App.testNames -- 297
	for _index_0 = 1, #_list_0 do -- 297
		local name = _list_0[_index_0] -- 297
		local entry = { -- 298
			name -- 298
		} -- 298
		cppTests[#cppTests + 1] = entry -- 299
	end -- 299
	cppTestSet = Set(cppTests) -- 300
	allEntries = { } -- 302
	for _index_0 = 1, #gamesInDev do -- 303
		local game = gamesInDev[_index_0] -- 303
		allEntries[#allEntries + 1] = game -- 304
		local examples, tests = game[3], game[4] -- 305
		for _index_1 = 1, #examples do -- 306
			local example = examples[_index_1] -- 306
			allEntries[#allEntries + 1] = example -- 307
		end -- 307
		for _index_1 = 1, #tests do -- 308
			local test = tests[_index_1] -- 308
			allEntries[#allEntries + 1] = test -- 309
		end -- 309
	end -- 309
	for _index_0 = 1, #games do -- 310
		local game = games[_index_0] -- 310
		allEntries[#allEntries + 1] = game -- 311
		local examples, tests = game[3], game[4] -- 312
		for _index_1 = 1, #examples do -- 313
			local example = examples[_index_1] -- 313
			doraExamples[#doraExamples + 1] = example -- 314
		end -- 314
		for _index_1 = 1, #tests do -- 315
			local test = tests[_index_1] -- 315
			doraTests[#doraTests + 1] = test -- 316
		end -- 316
	end -- 316
	local _list_1 = { -- 318
		doraExamples, -- 318
		doraTests, -- 319
		cppTests -- 320
	} -- 317
	for _index_0 = 1, #_list_1 do -- 321
		local group = _list_1[_index_0] -- 317
		for _index_1 = 1, #group do -- 322
			local entry = group[_index_1] -- 322
			allEntries[#allEntries + 1] = entry -- 323
		end -- 323
	end -- 323
end -- 288
updateEntries() -- 325
local doCompile -- 327
doCompile = function(minify) -- 327
	if building then -- 328
		return -- 328
	end -- 328
	building = true -- 329
	local startTime = App.runningTime -- 330
	local luaFiles = { } -- 331
	local yueFiles = { } -- 332
	local xmlFiles = { } -- 333
	local tlFiles = { } -- 334
	local writablePath = Content.writablePath -- 335
	local buildPaths = { -- 337
		{ -- 338
			Path(Content.assetPath), -- 338
			Path(writablePath, ".build"), -- 339
			"" -- 340
		} -- 337
	} -- 336
	for _index_0 = 1, #gamesInDev do -- 343
		local _des_0 = gamesInDev[_index_0] -- 343
		local entryFile = _des_0[2] -- 343
		local gamePath = Path:getPath(Path:getRelative(entryFile, writablePath)) -- 344
		buildPaths[#buildPaths + 1] = { -- 346
			Path(writablePath, gamePath), -- 346
			Path(writablePath, ".build", gamePath), -- 347
			Path(writablePath, gamePath, "Script", "?.lua") .. ";" .. Path(writablePath, gamePath, "?.lua"), -- 348
			gamePath -- 349
		} -- 345
	end -- 349
	for _index_0 = 1, #buildPaths do -- 350
		local _des_0 = buildPaths[_index_0] -- 350
		local inputPath, outputPath, searchPath, gamePath = _des_0[1], _des_0[2], _des_0[3], _des_0[4] -- 350
		if not Content:exist(inputPath) then -- 351
			goto _continue_0 -- 351
		end -- 351
		local _list_0 = getAllFiles(inputPath, { -- 353
			"lua" -- 353
		}) -- 353
		for _index_1 = 1, #_list_0 do -- 353
			local file = _list_0[_index_1] -- 353
			luaFiles[#luaFiles + 1] = { -- 355
				file, -- 355
				Path(inputPath, file), -- 356
				Path(outputPath, file), -- 357
				gamePath -- 358
			} -- 354
		end -- 358
		local _list_1 = getAllFiles(inputPath, { -- 360
			yueext -- 360
		}) -- 360
		for _index_1 = 1, #_list_1 do -- 360
			local file = _list_1[_index_1] -- 360
			yueFiles[#yueFiles + 1] = { -- 362
				file, -- 362
				Path(inputPath, file), -- 363
				Path(outputPath, Path:replaceExt(file, "lua")), -- 364
				searchPath, -- 365
				gamePath -- 366
			} -- 361
		end -- 366
		local _list_2 = getAllFiles(inputPath, { -- 368
			"xml" -- 368
		}) -- 368
		for _index_1 = 1, #_list_2 do -- 368
			local file = _list_2[_index_1] -- 368
			xmlFiles[#xmlFiles + 1] = { -- 370
				file, -- 370
				Path(inputPath, file), -- 371
				Path(outputPath, Path:replaceExt(file, "lua")), -- 372
				gamePath -- 373
			} -- 369
		end -- 373
		local _list_3 = getAllFiles(inputPath, { -- 375
			"tl" -- 375
		}) -- 375
		for _index_1 = 1, #_list_3 do -- 375
			local file = _list_3[_index_1] -- 375
			if not file:match(".*%.d%.tl$") then -- 376
				tlFiles[#tlFiles + 1] = { -- 378
					file, -- 378
					Path(inputPath, file), -- 379
					Path(outputPath, Path:replaceExt(file, "lua")), -- 380
					searchPath, -- 381
					gamePath -- 382
				} -- 377
			end -- 376
		end -- 382
		::_continue_0:: -- 351
	end -- 382
	local paths -- 384
	do -- 384
		local _tbl_0 = { } -- 384
		local _list_0 = { -- 385
			luaFiles, -- 385
			yueFiles, -- 385
			xmlFiles, -- 385
			tlFiles -- 385
		} -- 385
		for _index_0 = 1, #_list_0 do -- 385
			local files = _list_0[_index_0] -- 385
			for _index_1 = 1, #files do -- 386
				local file = files[_index_1] -- 386
				_tbl_0[Path:getPath(file[3])] = true -- 384
			end -- 384
		end -- 384
		paths = _tbl_0 -- 384
	end -- 386
	for path in pairs(paths) do -- 388
		Content:mkdir(path) -- 388
	end -- 388
	local totalFiles = #yueFiles + #xmlFiles + #tlFiles -- 390
	local fileCount = 0 -- 391
	local errors = { } -- 392
	for _index_0 = 1, #yueFiles do -- 393
		local _des_0 = yueFiles[_index_0] -- 393
		local file, input, output, searchPath, gamePath = _des_0[1], _des_0[2], _des_0[3], _des_0[4], _des_0[5] -- 393
		local filename -- 394
		if gamePath then -- 394
			filename = Path(gamePath, file) -- 394
		else -- 394
			filename = file -- 394
		end -- 394
		yue.compile(input, output, searchPath, function(codes, err, globals) -- 395
			if not codes then -- 396
				errors[#errors + 1] = "Compile errors in " .. tostring(filename) .. ".\n" .. tostring(err) -- 397
				return -- 398
			end -- 396
			local success, result = LintYueGlobals(codes, globals) -- 399
			if success then -- 400
				codes = codes:gsub("%s*local%s*_ENV%s*=%s*Dora%([^%)]-%)[^\n\r]+[\n\r%s]*", "\n") -- 401
				codes = codes:gsub("%s*local%s*_ENV%s*=%s*Dora[^%w_$][^\n\r]+[\n\r%s]*", "\n") -- 402
				codes = codes:gsub("^\n*", "") -- 403
				if not (result == "") then -- 404
					result = result .. "\n" -- 404
				end -- 404
				return "-- [yue]: " .. tostring(file) .. "\n" .. tostring(result) .. tostring(codes) -- 405
			else -- 407
				local yueCodes = Content:load(input) -- 407
				if yueCodes then -- 407
					local globalErrors = { } -- 408
					for _index_1 = 1, #result do -- 409
						local _des_1 = result[_index_1] -- 409
						local name, line, col = _des_1[1], _des_1[2], _des_1[3] -- 409
						local countLine = 1 -- 410
						local code = "" -- 411
						for lineCode in yueCodes:gmatch("([^\r\n]*)\r?\n?") do -- 412
							if countLine == line then -- 413
								code = lineCode -- 414
								break -- 415
							end -- 413
							countLine = countLine + 1 -- 416
						end -- 416
						globalErrors[#globalErrors + 1] = "invalid global variable \"" .. tostring(name) .. "\"\nin \"" .. tostring(filename) .. "\", at line " .. tostring(line) .. ", col " .. tostring(col) .. ".\n" .. tostring(code:gsub("\t", " ") .. '\n' .. string.rep(" ", col - 1) .. "^") -- 417
					end -- 417
					errors[#errors + 1] = table.concat(globalErrors, "\n") -- 418
				else -- 420
					errors[#errors + 1] = "failed to load file " .. tostring(input) -- 420
				end -- 407
			end -- 400
		end, function(success) -- 395
			if success then -- 421
				print("Yue compiled: " .. tostring(filename)) -- 421
			end -- 421
			fileCount = fileCount + 1 -- 422
		end) -- 395
	end -- 422
	thread(function() -- 424
		for _index_0 = 1, #xmlFiles do -- 425
			local _des_0 = xmlFiles[_index_0] -- 425
			local file, input, output, gamePath = _des_0[1], _des_0[2], _des_0[3], _des_0[4] -- 425
			local filename -- 426
			if gamePath then -- 426
				filename = Path(gamePath, file) -- 426
			else -- 426
				filename = file -- 426
			end -- 426
			local sourceCodes = Content:loadAsync(input) -- 427
			local codes, err = xml.tolua(sourceCodes) -- 428
			if not codes then -- 429
				errors[#errors + 1] = "Compile errors in " .. tostring(filename) .. ".\n" .. tostring(err) -- 430
			else -- 432
				Content:saveAsync(output, "-- [xml]: " .. tostring(file) .. "\n" .. tostring(codes)) -- 432
				print("Xml compiled: " .. tostring(filename)) -- 433
			end -- 429
			fileCount = fileCount + 1 -- 434
		end -- 434
	end) -- 424
	thread(function() -- 436
		for _index_0 = 1, #tlFiles do -- 437
			local _des_0 = tlFiles[_index_0] -- 437
			local file, input, output, searchPath, gamePath = _des_0[1], _des_0[2], _des_0[3], _des_0[4], _des_0[5] -- 437
			local filename -- 438
			if gamePath then -- 438
				filename = Path(gamePath, file) -- 438
			else -- 438
				filename = file -- 438
			end -- 438
			local sourceCodes = Content:loadAsync(input) -- 439
			local codes, err = teal.toluaAsync(sourceCodes, file, searchPath) -- 440
			if not codes then -- 441
				errors[#errors + 1] = "Compile errors in " .. tostring(filename) .. ".\n" .. tostring(err) -- 442
			else -- 444
				Content:saveAsync(output, codes) -- 444
				print("Teal compiled: " .. tostring(filename)) -- 445
			end -- 441
			fileCount = fileCount + 1 -- 446
		end -- 446
	end) -- 436
	return thread(function() -- 448
		wait(function() -- 449
			return fileCount == totalFiles -- 449
		end) -- 449
		if minify then -- 450
			local _list_0 = { -- 451
				yueFiles, -- 451
				xmlFiles, -- 451
				tlFiles -- 451
			} -- 451
			for _index_0 = 1, #_list_0 do -- 451
				local files = _list_0[_index_0] -- 451
				for _index_1 = 1, #files do -- 451
					local file = files[_index_1] -- 451
					local output = Path:replaceExt(file[3], "lua") -- 452
					luaFiles[#luaFiles + 1] = { -- 454
						Path:replaceExt(file[1], "lua"), -- 454
						output, -- 455
						output -- 456
					} -- 453
				end -- 456
			end -- 456
			local FormatMini -- 458
			do -- 458
				local _obj_0 = require("luaminify") -- 458
				FormatMini = _obj_0.FormatMini -- 458
			end -- 458
			for _index_0 = 1, #luaFiles do -- 459
				local _des_0 = luaFiles[_index_0] -- 459
				local file, input, output = _des_0[1], _des_0[2], _des_0[3] -- 459
				if Content:exist(input) then -- 460
					local sourceCodes = Content:loadAsync(input) -- 461
					local res, err = FormatMini(sourceCodes) -- 462
					if res then -- 463
						Content:saveAsync(output, res) -- 464
						print("Minify: " .. tostring(file)) -- 465
					else -- 467
						errors[#errors + 1] = "Minify errors in " .. tostring(file) .. ".\n" .. tostring(err) -- 467
					end -- 463
				else -- 469
					errors[#errors + 1] = "Minify errors in " .. tostring(file) .. ".\nTarget file is not exist!" -- 469
				end -- 460
			end -- 469
			package.loaded["luaminify.FormatMini"] = nil -- 470
			package.loaded["luaminify.ParseLua"] = nil -- 471
			package.loaded["luaminify.Scope"] = nil -- 472
			package.loaded["luaminify.Util"] = nil -- 473
		end -- 450
		local errorMessage = table.concat(errors, "\n") -- 474
		if errorMessage ~= "" then -- 475
			print("\n" .. errorMessage) -- 475
		end -- 475
		local builtFiles = totalFiles + (minify and #luaFiles or 0) - #errors -- 476
		print("\n" .. tostring(builtFiles) .. " " .. tostring(builtFiles == 1 and 'file' or 'files') .. " built! Cost " .. tostring(string.format('%.2f', App.runningTime - startTime)) .. "s") -- 477
		print(tostring(#errors) .. " " .. tostring(#errors == 1 and 'file fails' or 'files fail') .. " to build.") -- 478
		Content:clearPathCache() -- 479
		teal.clear() -- 480
		yue.clear() -- 481
		building = false -- 482
	end) -- 482
end -- 327
local doClean -- 484
doClean = function() -- 484
	if building then -- 485
		return -- 485
	end -- 485
	local writablePath = Content.writablePath -- 486
	local targetDir = Path(writablePath, ".build") -- 487
	Content:clearPathCache() -- 488
	if Content:remove(targetDir) then -- 489
		return print("Cleaned: " .. tostring(targetDir)) -- 490
	end -- 489
end -- 484
local screenScale = 2.0 -- 492
local scaleContent = false -- 493
local isInEntry = true -- 494
local currentEntry = nil -- 495
local footerWindow = nil -- 497
local entryWindow = nil -- 498
local testingThread = nil -- 499
local setupEventHandlers = nil -- 501
local allClear -- 503
allClear = function() -- 503
	local _list_0 = Routine -- 504
	for _index_0 = 1, #_list_0 do -- 504
		local routine = _list_0[_index_0] -- 504
		if footerWindow == routine or entryWindow == routine or testingThread == routine then -- 506
			goto _continue_0 -- 507
		else -- 509
			Routine:remove(routine) -- 509
		end -- 509
		::_continue_0:: -- 505
	end -- 509
	for _index_0 = 1, #moduleCache do -- 510
		local module = moduleCache[_index_0] -- 510
		package.loaded[module] = nil -- 511
	end -- 511
	moduleCache = { } -- 512
	Director:cleanup() -- 513
	Cache:unload() -- 514
	Entity:clear() -- 515
	Platformer.Data:clear() -- 516
	Platformer.UnitAction:clear() -- 517
	Audio:stopStream(0.5) -- 518
	Struct:clear() -- 519
	View.postEffect = nil -- 520
	View.scale = scaleContent and screenScale or 1 -- 521
	Director.clearColor = Color(0xff1a1a1a) -- 522
	teal.clear() -- 523
	yue.clear() -- 524
	for _, item in pairs(ubox()) do -- 525
		local node = tolua.cast(item, "Node") -- 526
		if node then -- 526
			node:cleanup() -- 526
		end -- 526
	end -- 526
	collectgarbage() -- 527
	collectgarbage() -- 528
	setupEventHandlers() -- 529
	Content.searchPaths = searchPaths -- 530
	App.idled = true -- 531
	return Wasm:clear() -- 532
end -- 503
_module_0["allClear"] = allClear -- 532
local clearTempFiles -- 534
clearTempFiles = function() -- 534
	local writablePath = Content.writablePath -- 535
	Content:remove(Path(writablePath, ".upload")) -- 536
	return Content:remove(Path(writablePath, ".download")) -- 537
end -- 534
local _anon_func_1 = function(App, _with_0) -- 552
	local _val_0 = App.platform -- 552
	return "Linux" == _val_0 or "Windows" == _val_0 or "macOS" == _val_0 -- 552
end -- 552
setupEventHandlers = function() -- 539
	local _with_0 = Director.postNode -- 540
	_with_0:onAppEvent(function(eventType) -- 541
		if eventType == "Quit" then -- 541
			allClear() -- 542
			return clearTempFiles() -- 543
		end -- 541
	end) -- 541
	_with_0:onAppChange(function(settingName) -- 544
		if "Theme" == settingName then -- 545
			config.themeColor = App.themeColor:toARGB() -- 546
		elseif "Locale" == settingName then -- 547
			config.locale = App.locale -- 548
			updateLocale() -- 549
			return teal.clear(true) -- 550
		elseif "FullScreen" == settingName or "Size" == settingName or "Position" == settingName then -- 551
			if _anon_func_1(App, _with_0) then -- 552
				if "FullScreen" == settingName then -- 554
					config.fullScreen = App.fullScreen -- 554
				elseif "Position" == settingName then -- 555
					local _obj_0 = App.winPosition -- 555
					config.winX, config.winY = _obj_0.x, _obj_0.y -- 555
				elseif "Size" == settingName then -- 556
					local width, height -- 557
					do -- 557
						local _obj_0 = App.winSize -- 557
						width, height = _obj_0.width, _obj_0.height -- 557
					end -- 557
					config.winWidth = width -- 558
					config.winHeight = height -- 559
				end -- 559
			end -- 552
		end -- 559
	end) -- 544
	_with_0:onAppWS(function(eventType) -- 560
		if eventType == "Close" then -- 560
			if HttpServer.wsConnectionCount == 0 then -- 561
				return updateEntries() -- 562
			end -- 561
		end -- 560
	end) -- 560
	return _with_0 -- 540
end -- 539
setupEventHandlers() -- 564
clearTempFiles() -- 565
local stop -- 567
stop = function() -- 567
	if isInEntry then -- 568
		return false -- 568
	end -- 568
	allClear() -- 569
	isInEntry = true -- 570
	currentEntry = nil -- 571
	return true -- 572
end -- 567
_module_0["stop"] = stop -- 572
local _anon_func_2 = function(Content, Path, file, require, type) -- 594
	local scriptPath = Path:getPath(file) -- 587
	Content:insertSearchPath(1, scriptPath) -- 588
	scriptPath = Path(scriptPath, "Script") -- 589
	if Content:exist(scriptPath) then -- 590
		Content:insertSearchPath(1, scriptPath) -- 591
	end -- 590
	local result = require(file) -- 592
	if "function" == type(result) then -- 593
		result() -- 593
	end -- 593
	return nil -- 594
end -- 587
local _anon_func_3 = function(Label, _with_0, err, fontSize, width) -- 626
	local label = Label("sarasa-mono-sc-regular", fontSize) -- 623
	label.alignment = "Left" -- 624
	label.textWidth = width - fontSize -- 625
	label.text = err -- 626
	return label -- 623
end -- 623
local enterEntryAsync -- 574
enterEntryAsync = function(entry) -- 574
	isInEntry = false -- 575
	App.idled = false -- 576
	emit(Profiler.EventName, "ClearLoader") -- 577
	currentEntry = entry -- 578
	local name, file = entry[1], entry[2] -- 579
	if cppTestSet[entry] then -- 580
		if App:runTest(name) then -- 581
			return true -- 582
		else -- 584
			return false, "failed to run cpp test '" .. tostring(name) .. "'" -- 584
		end -- 581
	end -- 580
	sleep() -- 585
	return xpcall(_anon_func_2, function(msg) -- 627
		local err = debug.traceback(msg) -- 596
		Log("Error", err) -- 597
		allClear() -- 598
		local ScrollArea = require("UI.Control.Basic.ScrollArea") -- 599
		local viewWidth, viewHeight -- 600
		do -- 600
			local _obj_0 = View.size -- 600
			viewWidth, viewHeight = _obj_0.width, _obj_0.height -- 600
		end -- 600
		local width, height = viewWidth - 20, viewHeight - 20 -- 601
		local fontSize = math.floor(20 * App.devicePixelRatio) -- 602
		Director.ui:addChild((function() -- 603
			local root = AlignNode() -- 603
			do -- 604
				local _obj_0 = App.bufferSize -- 604
				width, height = _obj_0.width, _obj_0.height -- 604
			end -- 604
			root:css("width: " .. tostring(width) .. "; height: " .. tostring(height)) -- 605
			root:onAppChange(function(settingName) -- 606
				if settingName == "Size" then -- 606
					do -- 607
						local _obj_0 = App.bufferSize -- 607
						width, height = _obj_0.width, _obj_0.height -- 607
					end -- 607
					return root:css("width: " .. tostring(width) .. "; height: " .. tostring(height)) -- 608
				end -- 606
			end) -- 606
			root:addChild((function() -- 609
				local _with_0 = ScrollArea({ -- 610
					width = width, -- 610
					height = height, -- 611
					paddingX = 0, -- 612
					paddingY = 50, -- 613
					viewWidth = height, -- 614
					viewHeight = height -- 615
				}) -- 609
				root:onAlignLayout(function(w, h) -- 617
					_with_0.position = Vec2(w / 2, h / 2) -- 618
					w = w - 20 -- 619
					h = h - 20 -- 620
					_with_0.view.children.first.textWidth = w - fontSize -- 621
					return _with_0:adjustSizeWithAlign("Auto", 10, Size(w, h)) -- 622
				end) -- 617
				_with_0.view:addChild(_anon_func_3(Label, _with_0, err, fontSize, width)) -- 623
				return _with_0 -- 609
			end)()) -- 609
			return root -- 603
		end)()) -- 603
		return err -- 627
	end, Content, Path, file, require, type) -- 627
end -- 574
_module_0["enterEntryAsync"] = enterEntryAsync -- 627
local enterDemoEntry -- 629
enterDemoEntry = function(entry) -- 629
	return thread(function() -- 629
		return enterEntryAsync(entry) -- 629
	end) -- 629
end -- 629
local reloadCurrentEntry -- 631
reloadCurrentEntry = function() -- 631
	if currentEntry then -- 632
		allClear() -- 633
		return enterDemoEntry(currentEntry) -- 634
	end -- 632
end -- 631
Director.clearColor = Color(0xff1a1a1a) -- 636
local waitForWebStart = true -- 638
thread(function() -- 639
	sleep(2) -- 640
	waitForWebStart = false -- 641
end) -- 639
local reloadDevEntry -- 643
reloadDevEntry = function() -- 643
	return thread(function() -- 643
		waitForWebStart = true -- 644
		doClean() -- 645
		allClear() -- 646
		_G.require = oldRequire -- 647
		Dora.require = oldRequire -- 648
		package.loaded["Script.Dev.Entry"] = nil -- 649
		return Director.systemScheduler:schedule(function() -- 650
			Routine:clear() -- 651
			oldRequire("Script.Dev.Entry") -- 652
			return true -- 653
		end) -- 653
	end) -- 653
end -- 643
local isOSSLicenseExist = Content:exist("LICENSES") -- 655
local ossLicenses = nil -- 656
local ossLicenseOpen = false -- 657
local _anon_func_4 = function(App) -- 661
	local _val_0 = App.platform -- 661
	return not ("Android" == _val_0 or "iOS" == _val_0) -- 661
end -- 661
local extraOperations -- 659
extraOperations = function() -- 659
	local zh = useChinese and isChineseSupported -- 660
	if _anon_func_4(App) then -- 661
		local alwaysOnTop = config.alwaysOnTop -- 662
		local changed -- 663
		changed, alwaysOnTop = Checkbox(zh and "窗口置顶" or "Always On Top", alwaysOnTop) -- 663
		if changed then -- 663
			App.alwaysOnTop = alwaysOnTop -- 664
			config.alwaysOnTop = alwaysOnTop -- 665
		end -- 663
	end -- 661
	if isOSSLicenseExist then -- 666
		if Button(zh and '开源协议' or 'OSS Licenses') then -- 667
			if not ossLicenses then -- 668
				ossLicenses = { } -- 669
				local licenseText = Content:load("LICENSES") -- 670
				ossLicenseOpen = (licenseText ~= nil) -- 671
				if ossLicenseOpen then -- 671
					licenseText = licenseText:gsub("\r\n", "\n") -- 672
					for license in GSplit(licenseText, "\n--------\n", true) do -- 673
						local name, text = license:match("[%s\n]*([^\n]*)[\n]*(.*)") -- 674
						if name then -- 674
							ossLicenses[#ossLicenses + 1] = { -- 675
								name, -- 675
								text -- 675
							} -- 675
						end -- 674
					end -- 675
				end -- 671
			else -- 677
				ossLicenseOpen = true -- 677
			end -- 668
		end -- 667
		if ossLicenseOpen then -- 678
			local width, height, themeColor -- 679
			do -- 679
				local _obj_0 = App -- 679
				width, height, themeColor = _obj_0.visualSize.width, _obj_0.visualSize.height, _obj_0.themeColor -- 679
			end -- 679
			SetNextWindowPosCenter("Appearing", Vec2(0.5, 0.5)) -- 680
			SetNextWindowSize(Vec2(math.min(width * 0.8, 750), height * 0.8), "Appearing") -- 681
			PushStyleVar("WindowPadding", Vec2(20, 10), function() -- 682
				ossLicenseOpen = Begin(zh and '开源协议' or 'OSS Licenses', ossLicenseOpen, { -- 685
					"NoSavedSettings" -- 685
				}, function() -- 686
					for _index_0 = 1, #ossLicenses do -- 686
						local _des_0 = ossLicenses[_index_0] -- 686
						local firstLine, text = _des_0[1], _des_0[2] -- 686
						local name, license = firstLine:match("(.+): (.+)") -- 687
						TextColored(themeColor, name) -- 688
						SameLine() -- 689
						TreeNode(tostring(license) .. "###" .. tostring(name), function() -- 690
							return TextWrapped(text) -- 690
						end) -- 690
					end -- 690
				end) -- 682
			end) -- 682
		end -- 678
	end -- 666
	if not App.debugging then -- 692
		return -- 692
	end -- 692
	return TreeNode(zh and "开发操作" or "Development", function() -- 693
		if Button(zh and "脚本编译测试" or "Script Build Test") then -- 694
			OpenPopup("build") -- 694
		end -- 694
		PushStyleVar("WindowPadding", Vec2(10, 10), function() -- 695
			return BeginPopup("build", function() -- 695
				if Selectable(zh and "编译" or "Compile") then -- 696
					doCompile(false) -- 696
				end -- 696
				Separator() -- 697
				if Selectable(zh and "压缩" or "Minify") then -- 698
					doCompile(true) -- 698
				end -- 698
				Separator() -- 699
				if Selectable(zh and "清理" or "Clean") then -- 700
					return doClean() -- 700
				end -- 700
			end) -- 700
		end) -- 695
		if isInEntry then -- 701
			if waitForWebStart then -- 702
				BeginDisabled(function() -- 703
					return Button(zh and "重载开发程序(Ctrl+Z)" or "Reload Dev Entry(Ctrl+Z)") -- 703
				end) -- 703
			elseif Button(zh and "重载开发程序(Ctrl+Z)" or "Reload Dev Entry(Ctrl+Z)") then -- 704
				reloadDevEntry() -- 705
			end -- 702
		end -- 701
		do -- 706
			local changed -- 706
			changed, scaleContent = Checkbox(string.format("%.1fx " .. tostring(zh and '屏幕缩放' or 'Screen'), screenScale), scaleContent) -- 706
			if changed then -- 706
				View.scale = scaleContent and screenScale or 1 -- 707
			end -- 706
		end -- 706
		do -- 708
			local changed -- 708
			changed, engineDev = Checkbox(zh and '引擎开发模式' or 'Engine Dev Mode', engineDev) -- 708
			if changed then -- 708
				config.engineDev = engineDev -- 709
			end -- 708
		end -- 708
		if Button(zh and "开始自动测试" or "Test automatically") then -- 710
			testingThread = thread(function() -- 711
				local _ <close> = setmetatable({ }, { -- 712
					__close = function() -- 712
						allClear() -- 713
						testingThread = nil -- 714
						isInEntry = true -- 715
						currentEntry = nil -- 716
						return print("Testing done!") -- 717
					end -- 712
				}) -- 712
				for _, entry in ipairs(allEntries) do -- 718
					allClear() -- 719
					print("Start " .. tostring(entry[1])) -- 720
					enterDemoEntry(entry) -- 721
					sleep(2) -- 722
					print("Stop " .. tostring(entry[1])) -- 723
				end -- 723
			end) -- 711
		end -- 710
	end) -- 693
end -- 659
local transparant = Color(0x0) -- 725
local windowFlags = { -- 726
	"NoTitleBar", -- 726
	"NoResize", -- 726
	"NoMove", -- 726
	"NoCollapse", -- 726
	"NoSavedSettings", -- 726
	"NoBringToFrontOnFocus" -- 726
} -- 726
local initFooter = true -- 734
local _anon_func_5 = function(allEntries, currentIndex) -- 770
	if currentIndex > 1 then -- 770
		return allEntries[currentIndex - 1] -- 771
	else -- 773
		return allEntries[#allEntries] -- 773
	end -- 770
end -- 770
local _anon_func_6 = function(allEntries, currentIndex) -- 777
	if currentIndex < #allEntries then -- 777
		return allEntries[currentIndex + 1] -- 778
	else -- 780
		return allEntries[1] -- 780
	end -- 777
end -- 777
footerWindow = threadLoop(function() -- 735
	local zh = useChinese and isChineseSupported -- 736
	if HttpServer.wsConnectionCount > 0 then -- 737
		return -- 738
	end -- 737
	if Keyboard:isKeyDown("Escape") then -- 739
		allClear() -- 740
		App:shutdown() -- 741
	end -- 739
	do -- 742
		local ctrl = Keyboard:isKeyPressed("LCtrl") -- 743
		if ctrl and Keyboard:isKeyDown("Q") then -- 744
			stop() -- 745
		end -- 744
		if ctrl and Keyboard:isKeyDown("Z") then -- 746
			reloadCurrentEntry() -- 747
		end -- 746
		if ctrl and Keyboard:isKeyDown(",") then -- 748
			if showFooter then -- 749
				showStats = not showStats -- 749
			else -- 749
				showStats = true -- 749
			end -- 749
			showFooter = true -- 750
			config.showFooter = showFooter -- 751
			config.showStats = showStats -- 752
		end -- 748
		if ctrl and Keyboard:isKeyDown(".") then -- 753
			if showFooter then -- 754
				showConsole = not showConsole -- 754
			else -- 754
				showConsole = true -- 754
			end -- 754
			showFooter = true -- 755
			config.showFooter = showFooter -- 756
			config.showConsole = showConsole -- 757
		end -- 753
		if ctrl and Keyboard:isKeyDown("/") then -- 758
			showFooter = not showFooter -- 759
			config.showFooter = showFooter -- 760
		end -- 758
		local left = ctrl and Keyboard:isKeyDown("Left") -- 761
		local right = ctrl and Keyboard:isKeyDown("Right") -- 762
		local currentIndex = nil -- 763
		for i, entry in ipairs(allEntries) do -- 764
			if currentEntry == entry then -- 765
				currentIndex = i -- 766
			end -- 765
		end -- 766
		if left then -- 767
			allClear() -- 768
			if currentIndex == nil then -- 769
				currentIndex = #allEntries + 1 -- 769
			end -- 769
			enterDemoEntry(_anon_func_5(allEntries, currentIndex)) -- 770
		end -- 767
		if right then -- 774
			allClear() -- 775
			if currentIndex == nil then -- 776
				currentIndex = 0 -- 776
			end -- 776
			enterDemoEntry(_anon_func_6(allEntries, currentIndex)) -- 777
		end -- 774
	end -- 780
	if not showEntry then -- 781
		return -- 781
	end -- 781
	local width, height -- 783
	do -- 783
		local _obj_0 = App.visualSize -- 783
		width, height = _obj_0.width, _obj_0.height -- 783
	end -- 783
	SetNextWindowSize(Vec2(50, 50)) -- 784
	SetNextWindowPos(Vec2(width - 50, height - 50)) -- 785
	PushStyleColor("WindowBg", transparant, function() -- 786
		return Begin("Show", windowFlags, function() -- 786
			if isInEntry or width >= 540 then -- 787
				local changed -- 788
				changed, showFooter = Checkbox("##dev", showFooter) -- 788
				if changed then -- 788
					config.showFooter = showFooter -- 789
				end -- 788
			end -- 787
		end) -- 789
	end) -- 786
	if isInEntry and not waitForWebStart and Keyboard:isKeyPressed("LCtrl") and Keyboard:isKeyDown("Z") then -- 791
		reloadDevEntry() -- 795
	end -- 791
	if initFooter then -- 796
		initFooter = false -- 797
	else -- 799
		if not showFooter then -- 799
			return -- 799
		end -- 799
	end -- 796
	SetNextWindowSize(Vec2(width, 50)) -- 801
	SetNextWindowPos(Vec2(0, height - 50)) -- 802
	SetNextWindowBgAlpha(0.35) -- 803
	do -- 804
		return PushStyleVar("WindowPadding", Vec2(10, 0), function() -- 805
			return Begin("Footer", windowFlags, function() -- 806
				Dummy(Vec2(width - 20, 0)) -- 807
				do -- 808
					local changed -- 808
					changed, showStats = Checkbox(zh and "状态" or "Stats", showStats) -- 808
					if changed then -- 808
						config.showStats = showStats -- 809
					end -- 808
				end -- 808
				SameLine() -- 810
				do -- 811
					local changed -- 811
					changed, showConsole = Checkbox(zh and "控制台" or "Log", showConsole) -- 811
					if changed then -- 811
						config.showConsole = showConsole -- 812
					end -- 811
				end -- 811
				if config.updateNotification then -- 813
					SameLine() -- 814
					if ImGui.Button(zh and "更新可用" or "Update Available") then -- 815
						config.updateNotification = false -- 816
						enterDemoEntry({ -- 817
							"SelfUpdater", -- 817
							Path(Content.assetPath, "Script", "Tools", "SelfUpdater") -- 817
						}) -- 817
					end -- 815
				end -- 813
				if not isInEntry then -- 818
					SameLine() -- 819
					if Button(zh and "主页" or "Home", Vec2(70, 30)) then -- 820
						allClear() -- 821
						isInEntry = true -- 822
						currentEntry = nil -- 823
					end -- 820
					local currentIndex = nil -- 824
					for i, entry in ipairs(allEntries) do -- 825
						if currentEntry == entry then -- 826
							currentIndex = i -- 827
						end -- 826
					end -- 827
					if currentIndex then -- 828
						if currentIndex > 1 then -- 829
							SameLine() -- 830
							if Button(zh and "前一个" or "Prev", Vec2(70, 30)) then -- 831
								allClear() -- 832
								enterDemoEntry(allEntries[currentIndex - 1]) -- 833
							end -- 831
						end -- 829
						if currentIndex < #allEntries then -- 834
							SameLine() -- 835
							if Button(zh and "后一个" or "Next", Vec2(70, 30)) then -- 836
								allClear() -- 837
								enterDemoEntry(allEntries[currentIndex + 1]) -- 838
							end -- 836
						end -- 834
					end -- 828
					SameLine() -- 839
					if Button(zh and "刷新" or "Reload", Vec2(70, 30)) then -- 840
						reloadCurrentEntry() -- 841
					end -- 840
				end -- 818
				return PushStyleVar("WindowPadding", Vec2(10, 10), function() -- 842
					if showStats then -- 843
						SetNextWindowPos(Vec2(10, 50), "FirstUseEver") -- 844
						showStats = ShowStats(showStats, extraOperations) -- 845
						config.showStats = showStats -- 846
					end -- 843
					if showConsole then -- 847
						SetNextWindowPos(Vec2(width - 425, height - 375), "FirstUseEver") -- 848
						showConsole = ShowConsole(showConsole) -- 849
						config.showConsole = showConsole -- 850
					end -- 847
				end) -- 842
			end) -- 806
		end) -- 805
	end -- 850
end) -- 735
local MaxWidth <const> = 800 -- 852
local displayWindowFlags = { -- 854
	"NoDecoration", -- 854
	"NoSavedSettings", -- 854
	"NoFocusOnAppearing", -- 854
	"NoNav", -- 854
	"NoMove", -- 854
	"NoScrollWithMouse", -- 854
	"AlwaysAutoResize", -- 854
	"NoBringToFrontOnFocus" -- 854
} -- 854
local webStatus = nil -- 865
local descColor = Color(0xffa1a1a1) -- 866
local gameOpen = #gamesInDev == 0 -- 867
local toolOpen = false -- 868
local exampleOpen = false -- 869
local testOpen = false -- 870
local filterText = nil -- 871
local anyEntryMatched = false -- 872
local urlClicked = nil -- 873
local match -- 874
match = function(name) -- 874
	local res = not filterText or name:lower():match(filterText) -- 875
	if res then -- 876
		anyEntryMatched = true -- 876
	end -- 876
	return res -- 877
end -- 874
local iconTex = nil -- 878
thread(function() -- 879
	if Cache:loadAsync("Image/icon_s.png") then -- 879
		iconTex = Texture2D("Image/icon_s.png") -- 880
	end -- 879
end) -- 879
entryWindow = threadLoop(function() -- 882
	if App.fpsLimited ~= config.fpsLimited then -- 883
		config.fpsLimited = App.fpsLimited -- 884
	end -- 883
	if App.targetFPS ~= config.targetFPS then -- 885
		config.targetFPS = App.targetFPS -- 886
	end -- 885
	if View.vsync ~= config.vsync then -- 887
		config.vsync = View.vsync -- 888
	end -- 887
	if Director.scheduler.fixedFPS ~= config.fixedFPS then -- 889
		config.fixedFPS = Director.scheduler.fixedFPS -- 890
	end -- 889
	if Director.profilerSending ~= config.webProfiler then -- 891
		config.webProfiler = Director.profilerSending -- 892
	end -- 891
	if urlClicked then -- 893
		local _, result = coroutine.resume(urlClicked) -- 894
		if result then -- 895
			coroutine.close(urlClicked) -- 896
			urlClicked = nil -- 897
		end -- 895
	end -- 893
	if not showEntry then -- 898
		return -- 898
	end -- 898
	if not isInEntry then -- 899
		return -- 899
	end -- 899
	local zh = useChinese and isChineseSupported -- 900
	if HttpServer.wsConnectionCount > 0 then -- 901
		local themeColor = App.themeColor -- 902
		local width, height -- 903
		do -- 903
			local _obj_0 = App.visualSize -- 903
			width, height = _obj_0.width, _obj_0.height -- 903
		end -- 903
		SetNextWindowBgAlpha(0.5) -- 904
		SetNextWindowPos(Vec2(width / 2, height / 2), "Always", Vec2(0.5, 0.5)) -- 905
		Begin("Web IDE Connected", displayWindowFlags, function() -- 906
			Separator() -- 907
			TextColored(themeColor, tostring(zh and '网页 IDE 已连接 ……' or 'Web IDE connected ...')) -- 908
			if iconTex then -- 909
				Image("Image/icon_s.png", Vec2(24, 24)) -- 910
				SameLine() -- 911
			end -- 909
			local slogon = zh and 'Dora 启动！' or 'Dora Start!' -- 912
			TextColored(descColor, slogon) -- 913
			return Separator() -- 914
		end) -- 906
		return -- 915
	end -- 901
	local themeColor = App.themeColor -- 917
	local fullWidth, height -- 918
	do -- 918
		local _obj_0 = App.visualSize -- 918
		fullWidth, height = _obj_0.width, _obj_0.height -- 918
	end -- 918
	SetNextWindowBgAlpha(0.85) -- 920
	SetNextWindowPos(Vec2(fullWidth - 30, height - 130), "Always", Vec2(1, 0)) -- 921
	PushStyleVar("WindowPadding", Vec2(10, 5), function() -- 922
		return Begin("Web IDE", displayWindowFlags, function() -- 923
			Separator() -- 924
			TextColored(themeColor, tostring(zh and '网页' or 'Web') .. " IDE") -- 925
			SameLine() -- 926
			TextDisabled('(?)') -- 927
			if IsItemHovered() then -- 928
				BeginTooltip(function() -- 929
					return PushTextWrapPos(280, function() -- 930
						return Text(zh and '在本机或是本地局域网连接的其他设备上，使用浏览器访问下面这个地址来使用网页 IDE' or 'You can use the Web IDE by accessing the following address in a browser on this machine or other devices connected to the local network') -- 931
					end) -- 931
				end) -- 929
			end -- 928
			do -- 932
				local url -- 932
				if webStatus ~= nil then -- 932
					url = webStatus.url -- 932
				end -- 932
				if url then -- 932
					if isDesktop and not config.fullScreen then -- 933
						if urlClicked then -- 934
							BeginDisabled(function() -- 935
								return Button(url) -- 935
							end) -- 935
						elseif Button(url) then -- 936
							urlClicked = once(function() -- 937
								return sleep(5) -- 937
							end) -- 937
							App:openURL("http://localhost:8866") -- 938
						end -- 934
					else -- 940
						TextColored(descColor, url) -- 940
					end -- 933
				else -- 942
					TextColored(descColor, zh and '不可用' or 'not available') -- 942
				end -- 932
			end -- 932
			return Separator() -- 943
		end) -- 943
	end) -- 922
	local width = math.min(MaxWidth, fullWidth) -- 945
	local paddingX = math.max(10, fullWidth / 2 - width / 2 - 10) -- 946
	local maxColumns = math.max(math.floor(width / 200), 1) -- 947
	SetNextWindowPos(Vec2.zero) -- 948
	SetNextWindowBgAlpha(0) -- 949
	do -- 950
		PushStyleVar("WindowPadding", Vec2(10, 0), function() -- 951
			return Begin("Dora Dev", displayWindowFlags, function() -- 952
				Dummy(Vec2(fullWidth - 20, 0)) -- 953
				if iconTex then -- 954
					Image("Image/icon_s.png", Vec2(24, 24)) -- 955
					SameLine() -- 956
				end -- 954
				TextColored(themeColor, "DORA SSR " .. tostring(zh and '开发' or 'DEV')) -- 957
				if fullWidth >= 320 then -- 958
					SameLine() -- 959
					Dummy(Vec2(fullWidth - 320, 0)) -- 960
					SameLine() -- 961
					SetNextItemWidth(-30) -- 962
					if InputText(zh and '筛选' or 'Filter', filterBuf, { -- 963
						"AutoSelectAll" -- 963
					}) then -- 963
						config.filter = filterBuf.text -- 964
					end -- 963
				end -- 958
				Separator() -- 965
				return Dummy(Vec2(fullWidth - 20, 0)) -- 966
			end) -- 952
		end) -- 951
	end -- 966
	anyEntryMatched = false -- 968
	SetNextWindowPos(Vec2(0, 50)) -- 969
	SetNextWindowSize(Vec2(fullWidth, height - 100)) -- 970
	do -- 971
		return PushStyleColor("WindowBg", transparant, function() -- 972
			return PushStyleVar("WindowPadding", Vec2(paddingX, 10), function() -- 973
				return Begin("Content", windowFlags, function() -- 974
					filterText = filterBuf.text:match("[^%%%.%[]+") -- 975
					if filterText then -- 976
						filterText = filterText:lower() -- 976
					end -- 976
					if #gamesInDev > 0 then -- 977
						for _index_0 = 1, #gamesInDev do -- 978
							local game = gamesInDev[_index_0] -- 978
							local gameName, fileName, examples, tests, bannerFile, bannerTex = game[1], game[2], game[3], game[4], game[5], game[6] -- 979
							local showSep = false -- 980
							if match(gameName) then -- 981
								Columns(1, false) -- 982
								TextColored(themeColor, zh and "项目：" or "Project:") -- 983
								SameLine() -- 984
								Text(gameName) -- 985
								Separator() -- 986
								if bannerFile then -- 987
									local texWidth, texHeight = bannerTex.width, bannerTex.height -- 988
									local displayWidth = (fullWidth / 2 - paddingX) * 2 - 35 -- 989
									local sizing <const> = 0.8 -- 990
									texHeight = displayWidth * sizing * texHeight / texWidth -- 991
									texWidth = displayWidth * sizing -- 992
									local padding = displayWidth * (1 - sizing) / 2 - 10 -- 993
									Dummy(Vec2(padding, 0)) -- 994
									SameLine() -- 995
									PushID(fileName, function() -- 996
										if ImageButton(gameName, bannerFile, Vec2(texWidth, texHeight)) then -- 997
											return enterDemoEntry(game) -- 998
										end -- 997
									end) -- 996
								else -- 1000
									PushID(fileName, function() -- 1000
										if Button(zh and "开始运行" or "Game Start", Vec2(-1, 40)) then -- 1001
											return enterDemoEntry(game) -- 1002
										end -- 1001
									end) -- 1000
								end -- 987
								NextColumn() -- 1003
								showSep = true -- 1004
							end -- 981
							if #examples > 0 then -- 1005
								local showExample = false -- 1006
								for _index_1 = 1, #examples do -- 1007
									local example = examples[_index_1] -- 1007
									if match(example[1]) then -- 1008
										showExample = true -- 1009
										break -- 1010
									end -- 1008
								end -- 1010
								if showExample then -- 1011
									Columns(1, false) -- 1012
									TextColored(themeColor, zh and "示例：" or "Example:") -- 1013
									SameLine() -- 1014
									Text(gameName) -- 1015
									PushStyleVar("ItemSpacing", Vec2(20, 10), function() -- 1016
										Columns(maxColumns, false) -- 1017
										for _index_1 = 1, #examples do -- 1018
											local example = examples[_index_1] -- 1018
											if not match(example[1]) then -- 1019
												goto _continue_0 -- 1019
											end -- 1019
											PushID(tostring(gameName) .. " " .. tostring(example[1]) .. " example", function() -- 1020
												if Button(example[1], Vec2(-1, 40)) then -- 1021
													enterDemoEntry(example) -- 1022
												end -- 1021
												return NextColumn() -- 1023
											end) -- 1020
											showSep = true -- 1024
											::_continue_0:: -- 1019
										end -- 1024
									end) -- 1016
								end -- 1011
							end -- 1005
							if #tests > 0 then -- 1025
								local showTest = false -- 1026
								for _index_1 = 1, #tests do -- 1027
									local test = tests[_index_1] -- 1027
									if match(test[1]) then -- 1028
										showTest = true -- 1029
										break -- 1030
									end -- 1028
								end -- 1030
								if showTest then -- 1031
									Columns(1, false) -- 1032
									TextColored(themeColor, zh and "测试：" or "Test:") -- 1033
									SameLine() -- 1034
									Text(gameName) -- 1035
									PushStyleVar("ItemSpacing", Vec2(20, 10), function() -- 1036
										Columns(maxColumns, false) -- 1037
										for _index_1 = 1, #tests do -- 1038
											local test = tests[_index_1] -- 1038
											if not match(test[1]) then -- 1039
												goto _continue_0 -- 1039
											end -- 1039
											PushID(tostring(gameName) .. " " .. tostring(test[1]) .. " test", function() -- 1040
												if Button(test[1], Vec2(-1, 40)) then -- 1041
													enterDemoEntry(test) -- 1042
												end -- 1041
												return NextColumn() -- 1043
											end) -- 1040
											showSep = true -- 1044
											::_continue_0:: -- 1039
										end -- 1044
									end) -- 1036
								end -- 1031
							end -- 1025
							if showSep then -- 1045
								Columns(1, false) -- 1046
								Separator() -- 1047
							end -- 1045
						end -- 1047
					end -- 977
					if #games > 0 or #doraExamples > 0 or #doraTests > 0 then -- 1048
						local showGame = false -- 1049
						for _index_0 = 1, #games do -- 1050
							local _des_0 = games[_index_0] -- 1050
							local name = _des_0[1] -- 1050
							if match(name) then -- 1051
								showGame = true -- 1051
							end -- 1051
						end -- 1051
						local showTool = false -- 1052
						for _index_0 = 1, #doraTools do -- 1053
							local _des_0 = doraTools[_index_0] -- 1053
							local name = _des_0[1] -- 1053
							if match(name) then -- 1054
								showTool = true -- 1054
							end -- 1054
						end -- 1054
						local showExample = false -- 1055
						for _index_0 = 1, #doraExamples do -- 1056
							local _des_0 = doraExamples[_index_0] -- 1056
							local name = _des_0[1] -- 1056
							if match(name) then -- 1057
								showExample = true -- 1057
							end -- 1057
						end -- 1057
						local showTest = false -- 1058
						for _index_0 = 1, #doraTests do -- 1059
							local _des_0 = doraTests[_index_0] -- 1059
							local name = _des_0[1] -- 1059
							if match(name) then -- 1060
								showTest = true -- 1060
							end -- 1060
						end -- 1060
						for _index_0 = 1, #cppTests do -- 1061
							local _des_0 = cppTests[_index_0] -- 1061
							local name = _des_0[1] -- 1061
							if match(name) then -- 1062
								showTest = true -- 1062
							end -- 1062
						end -- 1062
						if not (showGame or showTool or showExample or showTest) then -- 1063
							goto endEntry -- 1063
						end -- 1063
						Columns(1, false) -- 1064
						TextColored(themeColor, "Dora SSR:") -- 1065
						SameLine() -- 1066
						Text(zh and "开发示例" or "Development Showcase") -- 1067
						Separator() -- 1068
						local demoViewWith <const> = 400 -- 1069
						if #games > 0 and showGame then -- 1070
							local opened -- 1071
							if (filterText ~= nil) then -- 1071
								opened = showGame -- 1071
							else -- 1071
								opened = false -- 1071
							end -- 1071
							SetNextItemOpen(gameOpen) -- 1072
							TreeNode(zh and "游戏演示" or "Game Demo", function() -- 1073
								local columns = math.max(math.floor(width / demoViewWith), 1) -- 1074
								Columns(columns, false) -- 1075
								for _index_0 = 1, #games do -- 1076
									local game = games[_index_0] -- 1076
									if not match(game[1]) then -- 1077
										goto _continue_0 -- 1077
									end -- 1077
									local gameName, fileName, bannerFile, bannerTex = game[1], game[2], game[5], game[6] -- 1078
									if columns > 1 then -- 1079
										if bannerFile then -- 1080
											local texWidth, texHeight = bannerTex.width, bannerTex.height -- 1081
											local displayWidth <const> = demoViewWith - 40 -- 1082
											texHeight = displayWidth * texHeight / texWidth -- 1083
											texWidth = displayWidth -- 1084
											Text(gameName) -- 1085
											PushID(fileName, function() -- 1086
												if ImageButton(gameName, bannerFile, Vec2(texWidth, texHeight)) then -- 1087
													return enterDemoEntry(game) -- 1088
												end -- 1087
											end) -- 1086
										else -- 1090
											PushID(fileName, function() -- 1090
												if Button(gameName, Vec2(-1, 40)) then -- 1091
													return enterDemoEntry(game) -- 1092
												end -- 1091
											end) -- 1090
										end -- 1080
									else -- 1094
										if bannerFile then -- 1094
											local texWidth, texHeight = bannerTex.width, bannerTex.height -- 1095
											local displayWidth = (fullWidth / 2 - paddingX) * 2 - 35 -- 1096
											local sizing = 0.8 -- 1097
											texHeight = displayWidth * sizing * texHeight / texWidth -- 1098
											texWidth = displayWidth * sizing -- 1099
											if texWidth > 500 then -- 1100
												sizing = 0.6 -- 1101
												texHeight = displayWidth * sizing * texHeight / texWidth -- 1102
												texWidth = displayWidth * sizing -- 1103
											end -- 1100
											local padding = displayWidth * (1 - sizing) / 2 - 10 -- 1104
											Dummy(Vec2(padding, 0)) -- 1105
											SameLine() -- 1106
											Text(gameName) -- 1107
											Dummy(Vec2(padding, 0)) -- 1108
											SameLine() -- 1109
											PushID(fileName, function() -- 1110
												if ImageButton(gameName, bannerFile, Vec2(texWidth, texHeight)) then -- 1111
													return enterDemoEntry(game) -- 1112
												end -- 1111
											end) -- 1110
										else -- 1114
											PushID(fileName, function() -- 1114
												if Button(gameName, Vec2(-1, 40)) then -- 1115
													return enterDemoEntry(game) -- 1116
												end -- 1115
											end) -- 1114
										end -- 1094
									end -- 1079
									NextColumn() -- 1117
									::_continue_0:: -- 1077
								end -- 1117
								Columns(1, false) -- 1118
								opened = true -- 1119
							end) -- 1073
							gameOpen = opened -- 1120
						end -- 1070
						if #doraTools > 0 and showTool then -- 1121
							local opened -- 1122
							if (filterText ~= nil) then -- 1122
								opened = showTool -- 1122
							else -- 1122
								opened = false -- 1122
							end -- 1122
							SetNextItemOpen(toolOpen) -- 1123
							TreeNode(zh and "引擎工具" or "Engine Tools", function() -- 1124
								return PushStyleVar("ItemSpacing", Vec2(20, 10), function() -- 1125
									Columns(maxColumns, false) -- 1126
									for _index_0 = 1, #doraTools do -- 1127
										local example = doraTools[_index_0] -- 1127
										if not match(example[1]) then -- 1128
											goto _continue_0 -- 1128
										end -- 1128
										if Button(example[1], Vec2(-1, 40)) then -- 1129
											enterDemoEntry(example) -- 1130
										end -- 1129
										NextColumn() -- 1131
										::_continue_0:: -- 1128
									end -- 1131
									Columns(1, false) -- 1132
									opened = true -- 1133
								end) -- 1125
							end) -- 1124
							toolOpen = opened -- 1134
						end -- 1121
						if #doraExamples > 0 and showExample then -- 1135
							local opened -- 1136
							if (filterText ~= nil) then -- 1136
								opened = showExample -- 1136
							else -- 1136
								opened = false -- 1136
							end -- 1136
							SetNextItemOpen(exampleOpen) -- 1137
							TreeNode(zh and "引擎示例" or "Engine Example", function() -- 1138
								return PushStyleVar("ItemSpacing", Vec2(20, 10), function() -- 1139
									Columns(maxColumns, false) -- 1140
									for _index_0 = 1, #doraExamples do -- 1141
										local example = doraExamples[_index_0] -- 1141
										if not match(example[1]) then -- 1142
											goto _continue_0 -- 1142
										end -- 1142
										if Button(example[1], Vec2(-1, 40)) then -- 1143
											enterDemoEntry(example) -- 1144
										end -- 1143
										NextColumn() -- 1145
										::_continue_0:: -- 1142
									end -- 1145
									Columns(1, false) -- 1146
									opened = true -- 1147
								end) -- 1139
							end) -- 1138
							exampleOpen = opened -- 1148
						end -- 1135
						if (#doraTests > 0 or #cppTests > 0) and showTest then -- 1149
							local opened -- 1150
							if (filterText ~= nil) then -- 1150
								opened = showTest -- 1150
							else -- 1150
								opened = false -- 1150
							end -- 1150
							SetNextItemOpen(testOpen) -- 1151
							TreeNode(zh and "引擎测试" or "Engine Test", function() -- 1152
								return PushStyleVar("ItemSpacing", Vec2(20, 10), function() -- 1153
									Columns(maxColumns, false) -- 1154
									for _index_0 = 1, #doraTests do -- 1155
										local test = doraTests[_index_0] -- 1155
										if not match(test[1]) then -- 1156
											goto _continue_0 -- 1156
										end -- 1156
										if Button(test[1], Vec2(-1, 40)) then -- 1157
											enterDemoEntry(test) -- 1158
										end -- 1157
										NextColumn() -- 1159
										::_continue_0:: -- 1156
									end -- 1159
									for _index_0 = 1, #cppTests do -- 1160
										local test = cppTests[_index_0] -- 1160
										if not match(test[1]) then -- 1161
											goto _continue_1 -- 1161
										end -- 1161
										if Button(test[1], Vec2(-1, 40)) then -- 1162
											enterDemoEntry(test) -- 1163
										end -- 1162
										NextColumn() -- 1164
										::_continue_1:: -- 1161
									end -- 1164
									opened = true -- 1165
								end) -- 1153
							end) -- 1152
							testOpen = opened -- 1166
						end -- 1149
					end -- 1048
					::endEntry:: -- 1167
					if not anyEntryMatched then -- 1168
						SetNextWindowBgAlpha(0) -- 1169
						SetNextWindowPos(Vec2(fullWidth / 2, height / 2), "Always", Vec2(0.5, 0.5)) -- 1170
						Begin("Entries Not Found", displayWindowFlags, function() -- 1171
							Separator() -- 1172
							TextColored(themeColor, zh and "多萝：" or "Dora:") -- 1173
							TextColored(descColor, zh and '别担心，改变一些咒语，我们会找到新的冒险～' or 'Don\'t worry, more magic words and we\'ll find a new adventure!') -- 1174
							return Separator() -- 1175
						end) -- 1171
					end -- 1168
					Columns(1, false) -- 1176
					Dummy(Vec2(100, 80)) -- 1177
					return ScrollWhenDraggingOnVoid() -- 1178
				end) -- 974
			end) -- 973
		end) -- 972
	end -- 1178
end) -- 882
webStatus = require("Script.Dev.WebServer") -- 1180
return _module_0 -- 1180
