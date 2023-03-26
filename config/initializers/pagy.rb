# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/extras/array
require 'pagy/extras/array'

# Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
# See https://ddnexus.github.io/pagy/extras/bootstrap
require 'pagy/extras/bootstrap'

Pagy::DEFAULT[:items] = 3        # items per page
