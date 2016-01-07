require 'rubygems'
require 'csv'
File.open("data/lastfmuserdata.tsv") do |fi|
	darray = []
	begin
		1500.times { fi.readline }
		5000.times.each { darray += CSV.parse(fi.readline,col_sep:"\t")}
	rescue EOFError
	end

	CSV.open("data/User0001_2.csv","w") do |csvobject|
		darray.each do |row_arr|
			csvobject << row_arr
		end
	end
	#CSV.open("data/User0001.csv", "w") { |f| f.write(array.inject([]){|csv,array| csv << CSV.generate_line(array).join("")})}
	#CSV.open("data/User0001.csv","w") do |csv|
	#	csv<<["row","of","csv"]
	#end
end