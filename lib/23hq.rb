# = TwentyThree
#   An insanely easy interface to the 23hq photo-sharing service.
#
# Author::    Stephen Haberman <stephenh@chase3000.com>
# Copyright:: Copyright (c) 2005 Stephen Haberman <stephenh@chase3000.com>
# License::   MIT <http://www.opensource.org/licenses/mit-license.php>
# Credits::   Scott Raymond <sco@redgreenblu.com> for flickr.rb
#

require 'flickr'

class TwentyThree < Flickr

  def initialize
    super
    @host = 'http://www.23hq.com'
  end

end