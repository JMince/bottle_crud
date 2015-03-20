require 'rails_helper'

feature 'user can crud a bottle' do


  before :each do
    @bottle = Bottle.create(name: "Eldorado", material: "Plastic", contents: "Water")
  end


    scenario 'user can see list of bottles on the index'do
       visit root_path
       expect(page).to have_content("List Of Bottles")
       expect(page).to have_content("Eldorado")
       expect(page).to have_content("Plastic")
       expect(page).to have_content("Water")
   end


    scenario 'user can create a new bottle' do
      visit root_path
      click_on 'New Bottle'
      expect(current_path).to eq (new_bottle_path)
      expect(page).to have_content("Create A New Bottle")

      fill_in :name, with: "Coors"
      fill_in :material, with: "Glass"
      fill_in :contents, with: "Beer"
      click_on "Create Bottle"

      expect(current_path).to eq (root_path)
      expect(page).to have_content("Coors Bottle Created")
      expect(page).to have_content("Coors Glass Beer Bottle")
    end


    scenario 'index links go to a Bottle show page' do
      visit root_path
      click_on "Coors Glass Beer Bottle"

      expect(current_path).to eq bottle_path(@bottle)
      expect(page).to have_content('Name: Eldorado')
      expect(page).to have_content('Material: Plastic')
      expect(page).to have_content('Contents: Beer')

      expect(find_link('Index')[:href]).to eq (root_path)
      expect(find_link('Edit')[:href]).to eq (edit_bottle_path(@bottle))
      expect(find_link('Delete')[:href]).to eq (bottle_path(@bottle))
    end


    scenario 'User can update bottle' do
      visit bottle_path(@bottle)
      click_on "Edit"
      expect(current_path).to eq edit_bottle_path(@bottle)
      expect(page).to have_content('Edit Bottle')

      fill_in :material, with: "Kryptonite"
      fill_in :contents, with: "Lava"
      fill_in :name, with: "Superman"
      click_on "Update Bottle"

      expect(page).to have_content("Bottle Updated")
      expect(page).to have_content("Kryptonite")
      expect(page).to have_content("Lava")
      expect(page).to have_content("Superman")
      expect(page).to have_no_content("Eldorao")
      expect(page).to have_no_content("Plastic")
      expect(page).to have_no_content("Water")
    end


    scenario 'User can delete bottle'  do
      visit bottle_path(@bottle)
      click_on "Delete"

      expect(current_path).to eq root_path
      expect(page).to have_content "Bottle Successfully Destroyed"
      expect(page).to have_no_content "Eldorado Plastic Water Bottle"
    end


end
