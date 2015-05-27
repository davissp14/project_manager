var DragDropMixin = ReactDND.DragDropMixin;

const ItemTypes = {
  CARD: 'card'
};

var Card = React.createClass({  

  propTypes: {
    kanban_id: React.PropTypes.number.isRequired,
    title: React.PropTypes.string.isRequired,
    deleteCard: React.PropTypes.func.isRequired 
  },

  mixins: [
    DragDropMixin
  ],

  statics: {
    configureDragDrop: function(register) {
      register(ItemTypes.CARD, {
        dragSource: {
          beginDrag: function(component) {
            return {
              item: {
                id: component.props.id,
                kanban_id: component.props.kanban_id,
                title: component.props.title,
                deleteCard: component.props.deleteCard
              }
            };
          }
        }
      });
    }
  },

  render: function() {
    return (
      <li className="task list-group-item"
          {...this.dragSourceFor(ItemTypes.CARD)}>
        {this.props.title}
        <span className="delete"
              onClick={this.props.deleteCard} />
      </li>
    );
  }
});

var CardDropBin = React.createClass({
  mixins: [DragDropMixin],

  statics: {
    configureDragDrop: function(register) {
      register(ItemTypes.CARD, {
        dropTarget: {
          acceptDrop: function(component, card) {
            // When a card is dropped, add it to the parent card list
            card.deleteCard();
            component.props.board.addCard(card);
          }
        }
      });
    }
  },

  render: function() {
    const dropState = this.getDropState(ItemTypes.CARD);

    var stateClass = 'none';
    if (dropState.isHovering) {
      stateClass = 'hovering';
    } else if (dropState.isDragging) {
      stateClass = 'dragging';
    }

    return <div className={"drop drop-state-" + stateClass}
              {...this.dropTargetFor(ItemTypes.CARD)}>
      Drop here
    </div>;
  }
});