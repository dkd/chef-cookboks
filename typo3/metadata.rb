name             "typo3"
maintainer       "dkd Internet Service GmbH"
maintainer_email "christian.trabold@dkd.de"
license          "Apache 2.0"
description      "Installs/Configures typo3"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe           "typo3", "Main recipe to provide TYPO3 and a database"
recipe           "typo3::typo3_dummy", "Install TYPO3 dummy"

%w{ apache2 }.each do |cb|
  depends cb
end
