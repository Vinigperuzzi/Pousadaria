require "rails_helper"

describe 'Inn API' do
  context 'GET api/v1/inn/cnpj' do
    it 'return details from inn' do
      owner = InnOwner.create!(email: "vini@email.com", password: "password", first_name: "Vinícius", last_name: "Peruzzi", document: "01968717005")
      inn1 = Inn.create!(name: "Pousada do mar", inn_owner: owner, registration_number: "00245679870001")
      inn2 = Inn.create!(name: "Pousada da lagoa", inn_owner: owner, registration_number: "00245671560001")
      address1 = Address.create!(address: 'Rua da orla', postal_code: "96050000", number: "15",
        neighborhood: "Centro", city: "Praia Alta", state: "RS", inn_id: inn1.id)
      address2 = Address.create!(address: 'Rua da o', postal_code: "96050000", number: "15",
        neighborhood: "Centro", city: "Praia Alta", state: "RS")
      #:address, :postal_code, :number, :neighborhood, :city, :state
    end
  end
end