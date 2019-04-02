class Anonimizer
  
  def self.anonymize(text, author)
      puts "Received -- #{text} == #{author}"
     text.gsub!(/is/, "IS")
     "#{text} --- #{author}"
  end
  
end