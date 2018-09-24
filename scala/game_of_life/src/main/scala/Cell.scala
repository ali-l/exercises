class Cell(row: Int, col: Int, sendMessage: Message => _) {
  private var neighbourCount = 0
  var alive = false

  override def toString: String = s"Cell - alive:$alive, neighbourCount:$neighbourCount, row:$row, col:$col\n"

  def setAlive(state: Boolean): Unit = {
    alive = state
    sendMessage(Message(row, col, alive))
  }

  def processMessage(message: Message): Unit = {
    if (message.alive) neighbourCount += 1 else neighbourCount -= 1
  }

  def updateLivingState(): Unit = {
    if (alive && (neighbourCount > 3 || neighbourCount < 2)) {
      alive = false
      sendMessage(Message(row, col, alive))
    } else if (!alive && neighbourCount == 3) {
      alive = true
      sendMessage(Message(row, col, alive))
    }
  }
}