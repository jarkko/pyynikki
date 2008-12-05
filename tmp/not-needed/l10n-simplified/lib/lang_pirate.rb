# lang_pirate.rb
# Pirate baseline translation file. 
# Translated by Tobias Michaelsen , additions by Jesper Rønn-Jensen ( http://justaddwater.dk/ )


module LocalizationSimplified
  About = {
    :lang => "pirate",
    :updated => "2006-09-07"
  }

  class ActiveRecord
    # ErrorMessages to override default messages in 
    # +ActiveRecord::Errors::@@default_error_messages+
    # This plugin also replaces hardcoded 3 text messages 
    # :error_translation is inflected using the Rails 
    # inflector. 
    #
    # Remember to modify the Inflector with your localized translation
    # of "error" and "errors" in the bottom of this file
    # 
    ErrorMessages = {
      :inclusion           => "be not included in the list, me hearty",
      :exclusion           => "be reserrrrved",
      :invalid             => "be innvalid, m hearty",
      :confirmation        => "doesn't match confirmation",
      :accepted            => "must be accepted, arrrrh!",
      :empty               => "no nay ne'er be empty",
      :blank               => "no nay be blank, ye scurvy dog!",# alternate formulation: "is required"
      :too_long            => "be too vastly in length (no more than %d characters or ye drivin' me nuts)",
      :too_short           => "be way too short (at least %d characters or ye drivin' me nuts)",
      :wrong_length        => "be the wrong length (should be %d characters)",
      :taken               => "has already been taken",
      :not_a_number        => "be not a number, matey",
      #Jespers additions:
      :error_translation   => "errrorrr",
      :error_header        => "Ahoy me hearty! %s prohibited ye %s from bein' saved",
      :error_subheader     => "Turn the steering wheeel and corrrect these fields, arrrrh."
    }
  end

  # Texts to override +distance_of_time_in_words()+
  class DateHelper
    Texts = {
      :less_than_x_seconds => "less than %d seconds",
      :half_a_minute       => "half arrr minute",
      :less_than_a_minute  => "less than arrr minute",
      :one_minute          => "1 minute ye landlubber",
      :x_minutes           => "%d minutes accounted ferrrr",
      :one_hour            => "about one hourrr and a bottle of rum",
      :x_hours             => "about %d hourrrs and a bottle of rum",
      :one_day             => "1 day and a dead mans chest arrr",
      :x_days              => "%d days and a ship full of hornpipes",
      :one_month           => "1 full moon",
      :x_months            => "%d full moons",
      :one_year            => "1 yearrrr",
      :x_years             => "%d yearrrrrs"
    }

    # Rails uses Month names in Date and time select boxes 
    # (+date_select+ and +datetime_select+ )
    # Currently (as of version 1.1.6), Rails doesn't use daynames
    Monthnames     = [nil] + %w{January February March April May June July August September October November December}
    AbbrMonthnames = [nil] + %w{Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec}
    Daynames       = %w{Sunday Monday Tuesday Wednesday Thurrrrrrsday Frrriday Saturrrrday}
    AbbrDaynames   = %w{Sun Mon Tue Wed Thurrrr Frri Sat}
    
    # Date and time format syntax explained in http://www.rubycentral.com/ref/ref_c_time.html#strftime
    # These are sent to strftime that Ruby's date and time handlers use internally
    # Same options as php (that has a better list: http://www.php.net/strftime )
    DateFormats = {
      :default  => "%Y-%m-%d",
      :short    => "%b %e",
      :long     => "%B %e, %Y"
    }

    TimeFormats = {
      :default  => "%A, %d %b %Y %H:%M:%S",
      :short    => "%d %b %H:%M",
      :long     => "%B %d, %Y %H:%M"
    }
    # Set the order of +date_select+ and +datetime_select+ boxes
    # Note that at present, the current Rails version only supports ordering of date_select boxes
    DateSelectOrder = {
      :order    => [:year, :month, :day] #default Rails is US ordered: :order => [:year, :month, :day]
    }
  end

  class NumberHelper
    # CurrencyOptions are used as default for +Number#to_currency()+
    # http://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#M000449
    CurrencyOptions = {
      :unit      => "pieces o' silver",
      :separator => ".",             #unit separator (between integer part and fraction part)
      :delimiter => ",",             #delimiter between each group of thousands. Example: 1.234.567 
      :order     => [:number, :unit] #order is at present unsupported in Rails
      #to support for instance Danish format, the order is different: Unit comes last (ex. "1.234,00 dkr.")
    }
  end

  class ArrayHelper
    # Modifies +Array#to_sentence()+
    # http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/Array/Conversions.html#M000274
    ToSentenceTexts = {
      :connector => 'and',
      :skip_last_comma => false
    }
  end
end


# Use the inflector below to pluralize "error" from
# @@default_error_messages[:error_translation] above (if necessary)
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person people'
#   inflect.uncountable %w( information )
# end
