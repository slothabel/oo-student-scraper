require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
      doc.css("div.roster-cards-container").each do |card|
        card.css(".student-card").each do |student|
          student_link = student.css("a").attribute("href").value
      student.css(".card-text-container").each do |container|
          student_name = container.css(".student-name").text
            student_location = container.css(".student-location").text
              students << {name: student_name, location: student_location, profile_url: student_link}
      end#container ender
    end#student ender
  end#card ender
students
  end#method ender


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}

    links = doc.css(".social-icon-container").children.css("a").map { |i| i.attribute('href').value}
      links.each do |link|
        if link.include?("linkedin")
          student_info[:linkedin] = link
        elsif link.include?("github")
          student_info[:github] = link
        elsif link.include?("twitter")
          student_info[:twitter] = link
        else
          student_info[:blog] = link
        end#if ender
      end#each ender
    
      doc.css(".vitals-text-container").each do |top_info|
      student_info[:profile_quote] = top_info.css(".profile-quote").text
     end

    
    doc.css(".details-container").children.css(".bio-block").each do |bio|
      student_info[:bio] = bio.css(".description-holder").text.strip
     # binding.pry
    end
    student_info

  end#method ender







end#class ender

