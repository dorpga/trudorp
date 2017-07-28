class Page < ActiveRecord::Base
  def to_param
    path
  end
end
