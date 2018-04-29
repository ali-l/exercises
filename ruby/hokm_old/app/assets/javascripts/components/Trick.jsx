var Trick = React.createClass({

    createCard(card, border) {
        return (
            <li style={border == true ? {border: '120px solid green'} : {}}>
                <Card value={card.value} suit={card.suit} active={false} />
            </li>
        )
    },

    render() {
        return (
            <ul className="hand">
                {Object.keys(this.props.cards).map((k) => {
                    var card = this.props.cards[k];

                    if(k == this.props.winner) {
                        return this.createCard(card, true)
                    } else {
                        return this.createCard(card)
                    }
                })}
            </ul>
        )
    }
});