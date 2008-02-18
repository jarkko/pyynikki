# set L10N_LANG constant in your environment.rb or here
# 
# Choose language file here. Only one language file can be selected
L10N_LANG ||= :da

#require 'lang_en' #default language to run the test cases
require  "lang_" + L10N_LANG.to_s

#require 'lang_de', 'lang_es', 'lang_fi', 'lang_fr', 'lang_nl', 'lang_ko', 'lang_se', 'lang_chef', 'lang_pirate'
# You can Add your own localization file and add it here



# Also include hook code here
require 'localization_simplified'

