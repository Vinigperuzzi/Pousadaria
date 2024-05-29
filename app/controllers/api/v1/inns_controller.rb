class Api::V1::InnsController < ActionController::API
  def show_details
    cnpj = params[:cnpj]
    inn = Inn.where(registration_number: cnpj)
    address = Address.where(inn_id: inn.id)
    render status: 200, json: {name: inn.name, registration_number: inn.registration_number,
      address: {address: address.address, postal_code: address.postal_code, number: address.number, city: address.cuty,
      state: address.state, neighborhood: address.neighborhood},
      qtd_rooms: inn.inn_rooms.length}
  end
end