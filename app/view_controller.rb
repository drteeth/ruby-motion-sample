class ViewController < UITableViewController

  CellIdentifier = 'Cell'

  def viewDidLoad
    @items = ['Loading...']
    getItemsFromTheIntertubes
  end

  def tableView(tableView, numberOfRowsInSection:section)
    return @items.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    # try to recycle a cell
    cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
    unless cell
      # we weren't able to recycle a cell, create a new one
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CellIdentifier)
    end

    cell.textLabel.text = @items[indexPath.row]
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    detailController = ViewController2.alloc.init
    detailController.item_name = @items[indexPath.row]
    navigationController.pushViewController(detailController, animated:true)
  end

  def getItemsFromTheIntertubes
    Dispatch::Queue.concurrent.async do
      begin
        items = NBC::fetch_sports.map { |x| x['sport'] }
        Dispatch::Queue.main.sync {
          @items.clear
          @items.concat(items)
          view.reloadData
        }
      rescue RuntimeError => e
        puts "error getting items from network: #{e}"
        Dispatch::Queue.main.sync{ error("Failed network request.") }
      end
    end

    def error(message)
       dialog = UIAlertView.alloc.initWithTitle("Error",
                                        message:message.to_s,
                                        delegate:self,
                                        cancelButtonTitle:"Cancel",
                                        otherButtonTitles:nil)
        dialog.show
    end

    def alertView(alertView, didDismissWithButtonIndex:buttonIndex)
      puts buttonIndex
    end

  end

end
