# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clients', type: :request do
  describe 'clients' do
    it 'index' do
      get clients_path
    end

    it 'show' do
      client = Client.new(id: 1, name: 'Any', email: 'example@gmail.com', company_name: 'Any')
      client.save
      get client_path(client)
    end
  end
end
