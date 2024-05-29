require "rails_helper"

describe 'Inn API', :type => :request do
  context 'GET api/v1/inn/cnpj' do
    it 'return details from inn' do
      owner = InnOwner.create!(email: "vini@email.com", password: "password", first_name: "Vinícius", last_name: "Peruzzi", document: "01968717005")
      inn1 = Inn.create!(name: "Pousada do mar", inn_owner: owner, registration_number: "00245679870001")
      inn2 = Inn.create!(name: "Pousada da lagoa", inn_owner: owner, registration_number: "00245671560001")
      address1 = Address.create!(address: 'Rua da orla', postal_code: "96050000", number: "15",
        neighborhood: "Centro", city: "Praia Alta", state: "RS", inn_id: inn1.id)
      address2 = Address.create!(address: 'Rua da lagoa', postal_code: "96050150", number: "1000",
        neighborhood: "Centro", city: "Lagoa Azul", state: "RS", inn_id: inn2.id)
      InnRoom.create!(name: "Vista para o mar", size: 45, guest_limit: 4, daily_rate_cents: 25000, inn_id: inn1.id)
      InnRoom.create!(name: "Suíte Master", size: 90, guest_limit: 8, daily_rate_cents: 75000, inn_id: inn1.id)
      InnRoom.create!(name: "Vista para a lagoa", size: 35, guest_limit: 2, daily_rate_cents: 25000, inn_id: inn2.id)

      get '/api/v1/inn/00245679870001'

      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response["name"]).to eq "Pousada do mar"
      expect(json_response["registration_number"]).to eq "00245679870001"
      expect(json_response["address"]["address"]).to eq 'Rua da orla'
      expect(json_response["address"]["postal_code"]).to eq '96050000'
      expect(json_response["address"]["number"]).to eq "15"
      expect(json_response["address"]["neighborhood"]).to eq 'Centro'
      expect(json_response["address"]["city"]).to eq 'Praia Alta'
      expect(json_response["address"]["state"]).to eq 'RS'
      expect(json_response["qtd_rooms"]).to eq 2
    end
  end
end