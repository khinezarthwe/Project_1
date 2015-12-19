require 'rubygems'
require 'shoulda'
require 'yaml'
require 'lda-ruby'
require 'minitest/autorun'
require 'io/console'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

class TestMeme < Minitest::Test

	stopword = IO.readlines('data/stopwordlist.txt')
	stopword.each do |a|
		 stopword = a.gsub('\n', '')
	end

	puts stopword
	#stopword = ["she'd"]

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
=end

end
