# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/bills').to route_to('bills#create')
    end
    it 'routes to #send_bill_mail' do
      expect(post: '/send_bill_mail').to route_to('bills#send_bill_mail')
    end
    it 'routes to #show' do
      expect(get: '/bills/12').to route_to('bills#show', id: '12')
    end
  end
end
