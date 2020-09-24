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