require 'rails_helper'

feature 'Acessa a home' do
  scenario 'com sucesso' do
    visit root_path

    expect(page).to have_content('Vote no seu destino de viagem favorito!')
  end
end