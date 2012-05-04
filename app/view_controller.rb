class ViewController < UIViewController
  def viewDidLoad
    @label = UILabel.alloc.initWithFrame([[10,60],[300,80]])
    @label.text = "zomgz"
    view.addSubview(@label)

    view.userInteractionEnabled = true
    tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'next')
    view.addGestureRecognizer(tap)
  end

  def next
    controller = ViewController2.alloc.init
    navigationController.pushViewController(controller, animated:true)
  end
end
