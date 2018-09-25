class Cell(row: Int, col: Int, sendMessage: Message => Unit) {
  private var neighbourCount = 0
  private var alive = false

  def isAlive: Boolean = alive

  override def toString: String = s"Cell - alive:$alive, neighbourCount:$neighbourCount, row:$row, col:$col\n"

  def setAlive(state: Boolean): Unit = {
    alive = state
    broadcastLivingState()
  }

  def processMessage(message: Message): Unit = {
    if (message.alive) neighbourCount += 1 else neighbourCount -= 1
  }

  def updateLivingState(): Unit = {
    if (shouldDie) {
      die()
    } else if (shouldBecomeAlive) {
      becomeAlive()
    }
  }

  private def becomeAlive(): Unit = {
    alive = true
    broadcastLivingState()
  }

  private def die(): Unit = {
    alive = false
    broadcastLivingState()
  }

  private def broadcastLivingState(): Unit = sendMessage(Message(row, col, alive))

  private def shouldBecomeAlive = !alive && neighbourCount == 3

  private def shouldDie = alive && (neighbourCount > 3 || neighbourCount < 2)
}