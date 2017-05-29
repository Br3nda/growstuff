class CropSearch
  # Crop.search(string)
  def self.search(query)
    CropSearch.search(query)
    if ENV['GROWSTUFF_ELASTICSEARCH'] == "true"
      elastic_search(query)
    else
      database_search(query)
    end
  end

  def self.elastic_search_query(search_str)
    {
      multi_match: {
        query: search_str.to_s,
        analyzer: "standard",
        fields: ["name", "scientific_names.scientific_name", "alternate_names.name"]
      }
    }
  end

  def self.elastic_search(query)
    search_str = query.nil? ? "" : query.downcase
    response = __elasticsearch__.search(
      # Finds documents which match any field, but uses the _score from
      # the best field insead of adding up _score from each field.
      query: elastic_search_query(search_str),
      filter: {
        term: { approval_status: "approved" }
      },
      size: 50
    )
    response.records.to_a
  end

  def self.database_search
    # if we don't have elasticsearch, just do a basic SQL query.
    # also, make sure it's an actual array not an activerecord
    # collection, so it matches what we get from elasticsearch and we can
    # manipulate it in the same ways (eg. deleting elements without deleting
    # the whole record from the db)
    matches = Crop.approved.where("name ILIKE ?", "%#{query}%").to_a

    # we want to make sure that exact matches come first, even if not
    # using elasticsearch (eg. in development)
    exact_match = Crop.approved.find_by(name: query)
    if exact_match
      matches.delete(exact_match)
      matches.unshift(exact_match)
    end

    matches
  end
end
