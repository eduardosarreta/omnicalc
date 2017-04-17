class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")

    @character_count_without_spaces = text_wo_tabs.length



    @word_count = @text.split.count




    text_wo_special_features = @text.gsub(",","").gsub(".","").gsub("!","").gsub("?","").gsub("/","").downcase

    special_word_downcase = @special_word.downcase

    @occurrences = text_wo_special_features.split.count special_word_downcase

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal*((@apr/100)/12)/((1-((1+((@apr/100)/12))**(-12*@years))))






    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/3600
    @days = (@ending - @starting)/(3600*24)
    @weeks = (@ending - @starting)/(3600*24*7)
    @years = (@ending - @starting)/(3600*24*365)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median =
      if @count.odd?
        @sorted_numbers.at(@count/2)
      else
        (@sorted_numbers.at(@count/2-1)+@sorted_numbers.at(@count/2))/2
      end

    @sum = @numbers.sum

    @mean = @sum / @count

    array_of_numbers_minus_mean_squared = []

    @numbers.each do |num|
      numbers_minus_mean_squared =(num - @mean)**2
      array_of_numbers_minus_mean_squared.push(numbers_minus_mean_squared)
    end

    @variance = (array_of_numbers_minus_mean_squared.sum)/@count

    @standard_deviation = @variance**(1/2.0)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] +=1;h}

    @mode = @numbers.max_by{|v| freq[v]}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
