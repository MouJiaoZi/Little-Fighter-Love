function table_maxn(t)
	local mn = nil
	for k, v in pairs(t) do
		if mn == nil then
			mn = k
		end
		if mn < k then
			mn = k
		end
	end
	return mn
end

function PrintTable(t)
	local print_r_cache={}
	local function sub_print_r(t,indent)
		if (print_r_cache[tostring(t)]) then
			print(indent.."*"..tostring(t))
		else
			print_r_cache[tostring(t)]=true
			if (type(t)=="table") then
				for pos,val in pairs(t) do
					if (type(val)=="table") then
						print(indent.."["..pos.."] => "..tostring(t).." {")
						sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
						print(indent..string.rep(" ",string.len(pos)+6).."}")
					elseif (type(val)=="string") then
						print(indent.."["..pos..'] => "'..val..'"')
					else
						print(indent.."["..pos.."] => "..tostring(val))
					end
				end
			else
				print(indent..tostring(t))
			end
		end
	end
	if (type(t)=="table") then
		print(tostring(t).." {")
		sub_print_r(t,"  ")
		print("}")
	else
		sub_print_r(t,"  ")
	end
	print()
end

function IsInt(...)
	local arg = {...}
	for k,v in pairs(arg) do
		if type(v) ~= "number" or math.floor(v) ~= math.ceil(v) then
			return false
		end
	end
	return true
end

--usage: IsType(string type, any variable)
function IsType(sType, ...)
	local arg = {...}
	for k,v in pairs(arg) do
		if type(v) ~= sType then
			return false
		end
	end
	return true
end