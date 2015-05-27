var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var Board = React.createClass({

  propTypes: {
    id: React.PropTypes.number.isRequired,
    kanban_id: React.PropTypes.number.isRequired,
    name: React.PropTypes.string.isRequired,
    cards: React.PropTypes.arrayOf(React.PropTypes.object).isRequired
  },
 
  getInitialState: function() {
    return { cards: this.props.cards };
  },

  deleteCard: function(id) {
    var cards = this.state.cards;
    cards.splice(id, 1);
    this.setState({ cards: cards });
  },

  addCard: function(card) {
    var self = this;
    // Confidence add
    self.state.cards.concat([card])
    $.ajax({
      url: card.kanban_id + '/cards/' + card.id,
      type: 'PATCH',
      data: { 'id' : card.id, board_id: this.props.id },
      success: function(result) {
        self.setState({ cards: self.state.cards.concat([card]) });
      }
    });
  },

  render: function() {
    var self = this;
    var cards = this.state.cards.map(function(card, index) {
      return (
        <Card key={index}
              id={card.id}
              kanban_id={self.props.kanban_id}
              title={card.title}
              deleteCard={self.deleteCard.bind(self, index)} />
      );
    });

    return (
      <div className="col-md-3">
        <div className='form-box'>
          <div className='form-box-title'>
            <strong>{this.props.name}</strong>
          </div>
          <div className='form-box-content'>
            <ul className="sortable list-group list-tasks">
              <ReactCSSTransitionGroup transitionName="example" >
              {cards}
                 </ReactCSSTransitionGroup>
            </ul>
            <CardDropBin board={this} />
            <NewCardForm board={this} kanban_id={this.props.kanban_id} />
          </div>
        </div>
      </div>
    );
  }
});