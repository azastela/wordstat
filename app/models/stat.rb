class Stat < ApplicationRecord
  serialize :words, HashSerializer
end
