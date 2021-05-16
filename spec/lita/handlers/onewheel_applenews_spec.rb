require 'spec_helper'

def mock_up(filename)
  mock = File.open("spec/fixtures/#{filename}.html").read
  allow(RestClient).to receive(:get) { mock }
end

describe Lita::Handlers::OnewheelUnstagram, lita_handler: true do
  it 'quotes up' do
    mock_up 'fufb'
    send_message 'https://www.instagram.com/p/CO5qXfAhoux/?igshid=fufufu'
    expect(replies.last).to include('https://www.cnn.com/2021/05/03/tech/bill-and-melinda-gates-divorce/index.html')
  end
end
