module ResumesHelper
  def RandomLabel
    labels = ['Cat','Dog','Elephant','Hamster']
    return labels.sample
  end
end
