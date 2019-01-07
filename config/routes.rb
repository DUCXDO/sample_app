Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/about"
  get "static_pages/home"
  get "static_pages/help"
  scope "(:locale)", locale: /en|vi/ do
  end
end
