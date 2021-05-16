require 'spec_helper'

def mock_up(filename)
  mock = File.open("spec/fixtures/#{filename}.html").read
  allow(RestClient).to receive(:get) { mock }
end

describe Lita::Handlers::OnewheelUnstagram, lita_handler: true do
  it 'quotes up' do
    mock_up 'fufb'
    send_message 'https://www.instagram.com/p/CO5qXfAhoux/?igshid=fufufu'
    expect(replies.last).to include('https://www.instagram.com/p/CO5qXfAhoux/ https://scontent-sea1-1.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/185897310_4380019145342687_6234123367976157504_n.jpg?tp=1&_nc_ht=scontent-sea1-1.cdninstagram.com&_nc_cat=111&_nc_ohc=GLcdG6-FWMoAX9zDuAg&edm=AABBvjUBAAAA&ccb=7-4&oh=9232e5b803d5ffd4a6f75414ff36c99d&oe=60C4EA15&_nc_sid=83d603')
  end
end
