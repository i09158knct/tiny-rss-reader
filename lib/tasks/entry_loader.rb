require 'feedzirra'

class EntryLoader
  def self.updaete_all
    Feed.find_each {|feed|
      puts "loading: #{feed.title}"
      begin
        entries = fetch_and_save_new_entries feed
        puts "Loaded #{entries.length} items: #{feed.title}"
      rescue Exception => e
        puts "Error: #{feed.title} #{feed.url} #{feed.feed_url}"
        puts e
      end
    }
  end

  def self.fetch_and_save_new_entries(feed)
    parsed_feed = Feedzirra::Feed.fetch_and_parse feed.feed_url

    last_modified = fetch_published_time_of_latest_entry feed.id
    new_entries = parsed_feed.entries.select {|entry|
      entry.published > last_modified
    }

    return Entry.create new_entries.map {|new_entry|
      {
        feed_id: feed.id,
        title: new_entry.title,
        url: new_entry.url,
        summary: new_entry.summary,
        content: new_entry.content,
        published_at: new_entry.published,
        unread: true,
      }
    }


  end

  def self.fetch_published_time_of_latest_entry(feed_id)
    latest_entry = Entry.where(feed_id: feed_id).order('published_at DESC').first

    return (latest_entry.nil? || latest_entry.published_at.nil?) ?
      Time.at(0) :
      latest_entry.published_at
  end

end
