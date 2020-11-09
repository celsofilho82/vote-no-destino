require 'rails_helper'

feature 'Votando no destino de viagem favorito' do
  let!(:rio_de_janeiro) { create(:destination, name: 'Rio de Janeiro') }
  let!(:sao_paulo) { create(:destination, name: 'São Paulo') }
  let!(:cancun) { create(:destination, name: 'Cancun') }
  let!(:las_vegas) { create(:destination, name: 'Las Vegas') }
  let!(:buenos_aires) { create(:destination, name: 'Buenos Aires') }
  let(:user) { create(:user, name: "Biu Gates", email: 'biugates@email.com') }
  before do
    visit primeiro_destino_path
  end

  context 'inserindo dados válidos' do
    scenario 'sucesso com usuario que já existe' do
      choose('Rio de Janeiro')
      click_on 'Votar'
  
      choose('Las Vegas')
      click_on 'Votar'
  
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      click_on 'Confirmar'
  
      expect(rio_de_janeiro.votes_for.count).to eq(1)
      expect(las_vegas.votes_for.count).to eq(1)
      expect(current_path).to eq(rank_path(user.id))
      expect(Votersession.count).to eq(2)
      expect(Votersession.first.user.id).to eq(user.id)
      expect(Votersession.last.user.id).to eq(user.id)
    end

    scenario 'sucesso com novo usuario' do
      choose('São Paulo')
      click_on 'Votar'
  
      choose('Buenos Aires')
      click_on 'Votar'
  
      fill_in 'user[name]', with: 'Jeffinho Besos'
      fill_in 'user[email]', with: 'jeffinho@amazonia.com'
      click_on 'Confirmar'

      user = User.last
  
      expect(sao_paulo.votes_for.count).to eq(1)
      expect(buenos_aires.votes_for.count).to eq(1)
      expect(current_path).to eq(rank_path(user.id))
      expect(Votersession.count).to eq(2)
      expect(Votersession.first.user.id).to eq(user.id)
      expect(Votersession.last.user.id).to eq(user.id)
    end
  end

  context 'inserindo dados inválidos' do
    scenario 'erro quando nome e email estão em branco' do
      choose('Rio de Janeiro')
      click_on 'Votar'
  
      choose('Las Vegas')
      click_on 'Votar'
  
      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: ''
      click_on 'Confirmar'
  
      expect(current_path).to eq(user_path)
      expect(page).to have_content('{"name"=>["can\'t be blank"], "email"=>["is invalid"]}')
    end
  
    scenario 'erro quando email é inválido' do
      choose('Rio de Janeiro')
      click_on 'Votar'
  
      choose('Las Vegas')
      click_on 'Votar'
  
      fill_in 'user[name]', with: 'Elon Muskito'
      fill_in 'user[email]', with: 'elon.ford.com'
      click_on 'Confirmar'
  
      expect(current_path).to eq(user_path)
      expect(page).to have_content('{"email"=>["is invalid"]}')
    end
  end
end