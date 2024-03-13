//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
//= link popper.js
//= link bootstrap.min.js
// ...
//= link manifest.json
{
  "name": "Sporteam",
  "description": "ECRIRE ICI UNE DESCRIPTION",
  "background_color": "#242933", // Couleur à changer selon votre thème
  "theme_color": "#242933", // Couleur à changer selon votre thème
  "id": "/",
  "display": "fullscreen",
  "start_url": "/",
  "icons": [
    <% files = Dir.entries(Rails.root.join("app/assets/images/icons/")).select {|f| !File.directory? f} %>
    <% files.each_with_index do |file, index| %>
    <% match = file.match(/.+-(?<size>\d{2,3}x\d{2,3}).png/) %>
    {
      "src": "<%= image_path "icons/#{file}" %>",
      "sizes": "<%= match && match[:size] %>",
      "type": "image/png"
    }<%= "," unless (files.size - 1) == index %>
    <% end %>
  ]
}
