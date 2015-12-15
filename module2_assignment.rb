class LineAnalyzer
  
  attr_reader :highest_wf_count, 
              :highest_wf_words, 
              :content, 
              :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_words = []
    self.calculate_word_frequency
  end

  def calculate_word_frequency
    current_line = @content.split(" ")
    word_frequency = {}
    
    current_line.each do |word|
      word_frequency[word] ||= 0 

      word_frequency[word] += 1
    end
        
    word_frequency.each do |frequency_element|
      @highest_wf_words.push(frequency_element[0]) unless frequency_element[1] == 1
    end

    @highest_wf_count = word_frequency.values.max
    
  end

end


class Solution 

  attr_reader :analyzers,
              :highest_count_across_lines,
              :highest_count_words_across_lines

  def initialize
    @analyzers = []
    
  end
  
  def analyze_file(file_name = 'test.txt')
    current_string_number = 1 

    File.foreach(file_name) do |line|
      single_line_object = LineAnalyzer.new(line, current_string_number)
      @analyzers.push(single_line_object)
      current_string_number += 1
    end

  end

 

  def calculate_line_with_highest_frequency
    # 12.1
    @highest_count_words_across_lines = []
    highest_wf_count_values = []

    @analyzers.each do |analyzer_object|
      highest_wf_count_values.push(analyzer_object.highest_wf_count)
    end
    @highest_count_across_lines = highest_wf_count_values.sort.reverse[0]
    
    # 12.2
    analizer_cell = 0
    @analyzers.each do |analyzer_object|
      if analyzer_object.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines.push(@analyzers[analizer_cell])
      end
      analizer_cell += 1
    end

  end
  
  def print_highest_word_frequency_across_lines
    p "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line_analyzer_element|
      print line_analyzer_element.highest_wf_words
      print " (appears in line #"
      print line_analyzer_element.line_number 
      p ")"
      
    end
  end

end