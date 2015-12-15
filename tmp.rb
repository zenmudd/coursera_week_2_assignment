class LineAnalyzer
  
  attr_reader :highest_wf_count, 
              :highest_wf_words, 
              :content, 
              :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    self.calculate_word_frequency
  end

  def calculate_word_frequency
    current_line = @content.split(" ")
    word_frequency = {}
    
    current_line.each do |word|
      word_frequency[word] ||= 0 

      word_frequency[word] += 1
    end
    
    @highest_wf_count = word_frequency.values.max
    
    if word_frequency.select { |_, value| value == @highest_wf_count }.length == 1
      @highest_wf_words = word_frequency.key(@highest_wf_count)
    else
      @highest_wf_words = []

      word_frequency.each do |key, value|
        if value == @highest_wf_count
          @highest_wf_words.push(key)
        end
      end
    end
  end
end


class Solution 

  attr_reader :analyzers,
              :highest_count_across_lines,
              :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end
  
  def analyze_file
    current_string_number = 1 
    File.foreach('test.txt') do |line|
      single_line_object = LineAnalyzer.new(line, current_string_number)
      @analyzers.push(single_line_object)
      current_string_number += 1
      #puts single_line_object.content
    end

  end

 def calculate_line_with_highest_frequency
    highest_wf_count_values = []
    @analyzers.each do |obj|
      #puts obj.highest_wf_count
      highest_wf_count_values.push(obj.highest_wf_count)
    end

    #puts highest_wf_count_values

    @highest_count_across_lines = highest_wf_count_values.sort.reverse[0]
    puts @highest_count_across_lines
    
  end

  def print_highest_word_frequency_across_lines
    
  end
end

a = Solution.new
a.analyze_file
a.calculate_line_with_highest_frequency
puts a.highest_count_across_lines