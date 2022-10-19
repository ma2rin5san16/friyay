# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true

#pin "application", preload: true
#pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js, preload: true
