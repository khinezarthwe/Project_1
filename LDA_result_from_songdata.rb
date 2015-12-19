require 'rubygems'
require 'shoulda'
require 'yaml'
require 'lda-ruby'
require 'minitest/autorun'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
class songlda< Minitest::Test
	@corpus = Lda::Corpus.new
	file = File.open("data/song_lyric_1", "r")
	@songdata = Lda::TextDocument.new (@corpus,file.read)
	@lda = Lda::Lda.new(@corpus)
	@lda.num_topics = 5
	@lda.em('random')
	topics = @lda.top_words(5)
	@lda.print_topics(5)
end