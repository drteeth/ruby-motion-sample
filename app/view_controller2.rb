class ViewController2 < UIViewController
  attr_accessor :item_name

  def viewDidLoad
    @label = UILabel.alloc.initWithFrame([[0,100],[300,80]])
    @label.text = item_name

    view.addSubview(@label)
  end

end
