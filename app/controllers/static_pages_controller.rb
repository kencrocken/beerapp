class StaticPagesController < ApplicationController

  def home
    @query = params[:q]
    do_search @query if @query
  end

  def about
  end

  def search
    @beerid = params[:beerid]
    do_single_search @beerid if @beerid
  end

  private

    def do_search(q)
      response = api.search(q)
      if response.code == 200
        logger.info response.body
        @beers = parse_beers(response)
      else
        @error = "The search can not be empty."
      end
    end

    def do_single_search(beerid)
      response = api.show_beer(beerid)
      if response.code == 200
        logger.info response.body
        @beers = response["data"]
      else
        @error = response.body
      end
    end

    def parse_beers(response)
      return [] unless response["data"]
      response["data"].map { |beer_json| Beer.from_json(beer_json) }
    end

    def api
      @api ||= Brewerydb.new(ENV['BREWERYDB_API_KEY'])
    end

end
