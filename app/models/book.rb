# -*- encoding: utf-8 -*-
class Book
  attr_reader :title, :creators, :publisher, :pub_date, :link

  def initialize(node)
    @node = node
  end

  def title
    @node.at('./xmlns:title').try(:content)
  end

  def creators
    @node.xpath('./dc:creator').map{|e| e.try(:content)}.compact
  end

  def publisher
    @node.at('./dc:publisher').try(:content)
  end

  def pub_date
    @node.at('./dc:date').try(:content)
  end

  def link
    @node.at('./xmlns:link').content
  end

  def rdf
    @node.at('./rdfs:seeAlso[@rdf:resource]').attributes['resource'].value
  end

  def self.per_page
    10
  end
end
