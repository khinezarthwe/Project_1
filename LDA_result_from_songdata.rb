require 'rubygems'
require 'shoulda'
require 'yaml'
require 'lda-ruby'
require 'minitest/autorun'
require 'io/console'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

class TestMeme < Minitest::Test

	stopword = ["she'd","a", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount", "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as", "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the"]
	

	@corpus = Lda::Corpus.new

	Dir.foreach('data/songlyric') do |song_name|
		next if song_name == '.' or song_name == '..'
		file = File.open('data/songlyric/'+ song_name, "r")

		songlyric = file.read
		songlyric = songlyric.split.delete_if{|x| stopword.include?(x)}.join(' ')

		@songdata = Lda::TextDocument.new(@corpus,songlyric)
		@corpus.add_document(@songdata)
	end

	@lda = Lda::Lda.new(@corpus)
	@lda.num_topics = 5
	@lda.em('random')
	topics = @lda.top_words(5)
	@lda.print_topics(5)
	mat1 = @lda.compute_topic_document_probability
    mat1.to_a.each {|r| puts r.inspect}

=begin
	

	@corpus = Lda::Corpus.new
	file = File.open("data/song_lyric_1.txt", "r")
	@songdata = Lda::TextDocument.new(@corpus,file.read)
	@corpus.add_document(@songdata)

	file = File.open("data/song_lyric_2.txt", "r")
	@songdata = Lda::TextDocument.new(@corpus,file.read)
	@corpus.add_document(@songdata)
	
	@lda = Lda::Lda.new(@corpus)
	@lda.num_topics = 5
	@lda.em('random')
	topics = @lda.top_words(5)
	@lda.print_topics(5)
	mat1 = @lda.compute_topic_document_probability
    mat1.to_a.each {|r| puts r.inspect} 
----------------------------

	stopword = IO.readlines('data/stopwordlist.txt')
	stopword.each do |a|
		 stopword = a.gsub('\n', '')
	end

	puts stopword

------------------------

=end

end
