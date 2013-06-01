require File.expand_path('../entry_loader', __FILE__)

namespace :loader do

  desc "Fetch and save new entries of all feeds"
  task update_all_feeds: :environment do
    EntryLoader.updaete_all
  end

end
