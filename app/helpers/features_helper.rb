module FeaturesHelper
  def feature_enabled?(name)
    Feature.find_by(name: name).try(:enabled?)
  end

  def new_feature_request_link(name)
    feature = Feature.find_by(name: name)
    new_feature_feature_request_path(feature)
  end
end
