var Game = React.createClass({

    createHand(cards, points, index) {
        return (
            <Hand cards={cards} cardPlayed={this.cardPlayed} points={points} active={this.state.activeHand == index} playerNum={index}/>
        )
    },

    getInitialState() {
        return {trick: {}, 0: 0, 1: 0, 2: 0, 3: 0, activeHand: 0}
    },

    cardPlayed(card, playerNum) {
        this.setState((state) => {
          var newTrick = state.trick;
          newTrick[playerNum] = card;
            return {trick: newTrick, activeHand: (state.activeHand + 1) % 4}
        }, () => {
            if (Object.keys(this.state.trick).length == 4) {
                $.get('/evaluate', {cards: JSON.stringify(this.state.trick)}, (winner)=> {
                    this.setState({trickWinner: winner[2], activeHand: winner[2]}, () => {
                        this.incrementPoint()
                    })
                })
            }
        });
    },

    resetTrick() {
        this.setState({trick: {}, trickWinner: null})
    },

    incrementPoint() {
        this.props.hands.forEach((cards) => {
            var index = this.props.hands.indexOf(cards);
            if (index == this.state.trickWinner) {
                this.setState((state) => {
                    var obj = {};
                    obj[index] = state[index] + 1;
                    return obj;
                });
            }
        });
    },

    render() {
        return (
            <div className="playingCards">
                {this.props.hands.map((cards) => {
                    var index = this.props.hands.indexOf(cards);
                    var points = this.state[index];
                    return this.createHand(cards, points, index);
                })}
                Trick
                <Trick cards={this.state.trick} winner={this.state.trickWinner}/>
                <button onClick={this.resetTrick}>Reset</button>
            </div>

        )
    }
});