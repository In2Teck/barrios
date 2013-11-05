class AddInfluencersBatch1 < ActiveRecord::Migration
  def up
    role_influencer = Role.create(name: 'influencer')

    User.find_by_email("castillo.fernanda@gmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("pipere_3@hotmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("jimena@madmamacitas.tv").update_attribute(:roles, [role_influencer])
    #User.find_by_email("lechugol@hotmail.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("rul717@hotmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("Renata.ibor@hotmail.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("fachisth@hotmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("maildelaguera@gmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("catalan000@yahoo.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("jemi11@hotmail.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("lau_palma@hotmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("melmendoza@mmstylingmedia.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("matiasnovoaburgos@yahoo.com.mx").update_attribute(:roles, [role_influencer])
    User.find_by_email("carolina.x.padron.-ND@espn.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("damaquintanar@gmail.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("plopezdelacerda@gmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("renatolopezmusic@gmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("mariamartinni@yahoo.com.mx").update_attribute(:roles, [role_influencer])
    User.find_by_email("gonzgarvi@gmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("pedroza.mauricio@gmail.com").update_attribute(:roles, [role_influencer])
    User.find_by_email("javier@rancho.st").update_attribute(:roles, [role_influencer])
    #User.find_by_email("soydiealfaro@gmail.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("moshitessa@hotmail.com").update_attribute(:roles, [role_influencer])
    #User.find_by_email("eddyvilard@hotmail.es").update_attribute(:roles, [role_influencer])

  end

  def down
  end
end
