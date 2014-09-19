# Class: zip::params
#
# This class defines default parameters used by the main module class zip
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to zip class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class zip::params {

  ### Application related parameters

  $package = 'zip'
  $package_unzip = 'unzip'

  # General Settings
  $my_class = ''
  $version = 'present'
  $absent = false
  $noops = undef

}
