var Hand = React.createClass({
    createCard(card) {
        return (
            <li>
                <Card value={card.value} suit={card.suit} handleClick={this.handleClick} active={this.props.active}/>
            </li>
        )
    },

    handleClick(clickedCard) {
        this.state.cards.forEach((card) => {
            if (card.suit == clickedCard.suit && card.value == clickedCard.value) {
                this.props.cardPlayed(card, this.props.playerNum);
                this.setState({
                    cards: this.state.cards.filter(function (e) {
                        return e != card
                    })
                })
            }
        });
    },

    getInitialState() {
        return {cards: this.props.cards}
    },

    render() {
        return (
            <div style={this.props.active ? {border: '1px solid red'} : {}}>
                <ul className="hand" style={{marginBottom: 0}}>
                    {this.state.cards.map(this.createCard)}
                </ul>
                <span>{this.props.points}</span>
            </div>
        )
    }
});