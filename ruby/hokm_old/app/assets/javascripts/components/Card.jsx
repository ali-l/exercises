var Card = React.createClass({

    getClassName() {
        return 'card rank-' + this.getValue() + ' ' + this.getSuit();
    },

    getSuitHTML() {
        return {__html: '&' + this.getSuit() + ';'};
    },

    getValueHTML() {
        var value = this.getValue().toString();
        return value.charAt(0).toUpperCase() + value.slice(1);
    },

    getSuit() {
        const SUIT_MAP = {'Spades': 'spades', 'Clubs': 'clubs', 'Hearts': 'hearts', 'Diamonds': 'diams'};
        return SUIT_MAP[this.props.suit];
    },

    getValue() {
        var value = this.props.value;
        if (value <= 10) {
            return value;
        } else if (value == 11) {
            return 'j'
        } else if (value == 12) {
            return 'q'
        } else if (value == 13) {
            return 'k'
        } else if (value == 14) {
            return 'a'
        }
    },

    handleClick() {
        this.props.handleClick({value: this.props.value, suit: this.props.suit});
    },

    render() {

      if (this.props.active) {

        return (
          <a className={this.getClassName()} href='#' onClick={this.handleClick}>
            <span className="rank">{this.getValueHTML()}</span>
            <span className="suit" dangerouslySetInnerHTML={this.getSuitHTML()}></span>
          </a>
        )

      } else {

        return (
          <div className={this.getClassName()} >
            <span className="rank">{this.getValueHTML()}</span>
            <span className="suit" dangerouslySetInnerHTML={this.getSuitHTML()}></span>
          </div>
        )
      }

    }
});