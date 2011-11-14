require 'dragonfly/rails/images'

app = Dragonfly[:images]
app.configure do |c|
  c.allow_fetch_file = true
end
app.configure_with(:imagemagick)
app.configure_with(:rails)