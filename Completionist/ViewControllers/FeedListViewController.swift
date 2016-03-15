import UIKit
import ReactiveKit
import ReactiveUIKit

protocol FeedListInput {
    var items: ObservableCollection<[FeedItem]> { get }
    var isRefreshing: Observable<Bool> { get }
}

protocol FeedListOutput {
    func refreshList()
    func didHeartItem(itemId: Int)
    func didUnheartItem(itemId: Int)
    func didArchiveItem(itemId: Int)
    func didUnarchiveItem(itemId: Int)
    func didSelectItem(itemId: Int)
}

final class FeedListViewController: UITableViewController {

    let input: FeedListInput
    let output: FeedListOutput

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(input: FeedListInput, output: FeedListOutput) {
        self.input = input
        self.output = output

        super.init(nibName: nil, bundle: nil)

        title = "Feed list"
        tabBarItem.title = "Feed list"

    }

    override func loadView() {
        tableView = UITableView(frame: CGRect.zero, style: .Grouped)
    }

    override func viewDidLoad() {

        refreshControl = UIRefreshControl()
        if let refreshControl = refreshControl {
            refreshControl.backgroundColor = UIColor.lightGrayColor()
            refreshControl.tintColor = UIColor.whiteColor()
            refreshControl.addAction(.ValueChanged) { _ in
                self.output.refreshList()
            }
            input.isRefreshing
                .filter { _ in refreshControl.refreshing }
                .bindTo(refreshControl.rRefreshing)
        }

        let cellName = "DetailItemCell"

//        tableView.registerClass(DetailItemCell.self, forCellReuseIdentifier: cellName)
        let nib = UINib(nibName: cellName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellName)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300

        input.items.bindTo(tableView) { indexPath, items, tableView in
            let cell = self.tableView.dequeueReusableCellWithIdentifier(
                cellName, forIndexPath: indexPath)
            let item = items[indexPath.row]

            if let cell = cell as? DetailItemCell {
                cell.userLabel.text = item.username
                if let image = item.images.first {
                    if let image = UIImage(named: image.url) {
                        cell.photoView.image = image
                        cell.aspectRatio = image.size.width / image.size.height
                    }
                }
            }

            return cell
        }

    }

    override func tableView(
        tableView: UITableView,
        editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let item = input.items[indexPath.row]

        return [
            heartRowAction(item),
            archiveRowAction(item),
        ]
    }

    func heartRowAction(item: FeedItem) -> UITableViewRowAction {
        return UITableViewRowAction(
            style: .Normal,
            title: item.likeCount > 0 ? "👎" : "❤️",
            handler: indexedAction(
                item.likeCount > 0 ? output.didUnheartItem : output.didHeartItem))
    }

    func archiveRowAction(item: FeedItem) -> UITableViewRowAction {
        return UITableViewRowAction(
            style: .Normal,
            title: item.unread ? "🗑" : "📥",
            handler: indexedAction(item.unread ? output.didArchiveItem : output.didUnarchiveItem))
    }

    func indexedAction(action: Int -> Void) -> (UITableViewRowAction, NSIndexPath) -> Void {
        return { [unowned self] row, indexPath in
            self.tableView.editing = false
            action(self.input.items[indexPath.row].id)
        }
    }
}
