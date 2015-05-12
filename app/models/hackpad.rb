class Hackpad < ActiveRecord::Base
  belongs_to :project

  def persist!
    response = session.request :post, "/api/1.0/pad/create", nil, {}, title, { 'Content-Type' => 'text/plain' }
    update_attributes(pad_id: JSON.parse(response.body)['padId'])
  end

  def self.resync(project)
    return nil unless project
    hackpads = project.hackpads

    results = hackpads.map do |hackpad|
      response = hackpad.session.request :get, "/api/1.0/pad/#{hackpad.pad_id}/content/latest.md"
      if response.code == '200'
        parsed_title = response.body.match(/\A#(.*)/)[1].strip rescue 'Title not found!'
        puts parsed_title
        hackpad.update_attributes(title: parsed_title)
      else
        hackpad.destroy
      end
    end
  end

  def session
    session ||= OAuth::Consumer.new HACKPAD_CLIENT_ID, HACKPAD_SECRET, { :site => HACKPAD_SERVER }
  end

end