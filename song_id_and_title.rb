op = File.open("data/songid.txt", "w+") 
IO.foreach("data/mxm_matches.txt") do |a|
	ary = a.split(",")
	ary = ary[3..ary.size]

	str = ary.join(",")
	op << str
end