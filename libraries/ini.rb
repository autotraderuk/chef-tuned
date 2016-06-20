# Helpers for working with INI files.
#
module Tuned
  # Utils namespace
  module Utils
    module_function

    # Format a Hash as an INI file.
    #
    # @ini_data [Hash<String, Hash<String, String>>] Hash to format.
    # @return [String]
    def to_ini(ini_data)
      ''.tap do |buf|
        # Iterate through keys firstly sorting so that 'main' is the first
        # element dealt with then sorting the remaing elements alphabetised
        #
        # If the first argument, a should be sorted first, -1 should be
        # returned; if the second argument, b should be sorted first, 1 should
        # be returned.
        sections_name = ini_data.keys.sort do |a, b|
          if a.to_s == 'main'
            -1
          elsif b.to_str == 'main'
            1
          else
            a <=> b
          end
        end
        sections_name.each do |section_name|
          buf << "[#{section_name}]\n"
          ini_data[section_name].each do |key, value|
            buf << "#{key}=#{escape_ini_value(value)}\n"
          end
        end
      end
    end

    # Escape special characters for an INI file. Based on
    # https://github.com/TwP/inifile/blob/master/lib/inifile.rb
    # Copyright Tim Pease, used under MIT license.
    #
    # @param value [String] The value to escape.
    # @return [String]
    def escape_ini_value(value)
      value = value.to_s.dup
      value.gsub!(/\\([0nrt])/, '\\\\\1')
      value.gsub!(/\n/, '\n')
      value.gsub!(/\r/, '\r')
      value.gsub!(/\t/, '\t')
      value.gsub!(/\0/, '\0')
      value
    end
  end
end
