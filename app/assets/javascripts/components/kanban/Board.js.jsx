var DragDropMixin = ReactDND.DragDropMixin;
var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var Board = React.createClass({

  propTypes: {
    id: React.PropTypes.number.isRequired,
    kanban_id: React.PropTypes.number.isRequired,
    name: React.PropTypes.string.isRequired,
    cards: React.PropTypes.arrayOf(React.PropTypes.object).isRequired
  },

  mixins: [DragDropMixin],

  statics: {
    configureDragDrop: function(register) {
      register(ItemTypes.CARD, {
        dropTarget: {
          acceptDrop: function(component, card) {
            card.deleteCard();
            component.addCard(card);
          }
        }
      });
    }
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
    
    const dropState = this.getDropState(ItemTypes.CARD);

    var stateClass = 'none';
    if (dropState.isHovering) {
      stateClass = 'hovering';
    } else if (dropState.isDragging) {
      stateClass = 'dragging';
    }

    var cards = this.state.cards.map(function(card, index) {
      return (
        <Card key={index}
              id={card.id}
              board={self}
              board_id={self.props.id}
              kanban_id={self.props.kanban_id}
              title={card.title}
              deleteCard={self.deleteCard.bind(self, index)} />
      );
    });

    return (
      <div className="col-md-3">
        <div className={"drop drop-state-" + stateClass}
            {...this.dropTargetFor(ItemTypes.CARD)}>
          <div className='form-box active-board'>
          
            <BoardTitle id={this.props.id} name={this.props.name} kanban_id={this.props.kanban_id} kanban={this.props.kanban} />
            
            <div className='form-box-content'>
              <ul className="list-group list-cards">
                {cards}
              </ul>

              <NewCardForm board={this} kanban_id={this.props.kanban_id} />
            </div>
    
          </div>
        </div>
      </div>
    );
  }
});