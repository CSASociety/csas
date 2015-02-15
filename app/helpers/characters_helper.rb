module CharactersHelper
  def avaliable_campaigns(user)
    Campaign.references(:players).includes(:players).where("players.user_id = ?", user.id)
  end
end
