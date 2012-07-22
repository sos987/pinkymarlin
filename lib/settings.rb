class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  def self.gateway
    @@gateway ||= Class.new(Settingslogic) do
      source "#{Rails.root}/config/gateway.yml"
      namespace Rails.env
    end
  end

end