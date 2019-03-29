ActiveAdmin.register UploadedOffer do
  permit_params :book_file

  show do |owners|

    attributes_table do
      row :offer
      row :book_file
    end

    panel 'Uploaded file owners' do
      table_for owners.uploaded_offer_owners do |t|
        t.column :user
      end
    end

  end

end
