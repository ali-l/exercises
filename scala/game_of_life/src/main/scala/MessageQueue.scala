import scala.collection.mutable.ListBuffer

case class Message(row: Int, col: Int, alive: Boolean)

class MessageQueue {
  private var messages = ListBuffer[Message]()

  def insert(message: Message): Unit = {
    messages += message
  }

  def flush(): List[Message] = {
    val buffer = messages.toList
    messages = ListBuffer[Message]()
    buffer
  }
}
