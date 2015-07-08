var NewCardForm = React.createClass({
  
  propTypes: {

  },

  getInitialState: function() {
    return { showForm: false };
  },

  addCard: function(){
    var self = this;
    var cardText = React.findDOMNode(this.refs.cardTitle).value.trim();
    if (cardText == '') {
      return
    }
    
    $.ajax({
      url: this.props.kanban_id + '/cards',
      type: 'POST',
      data: { title : cardText, board_id: this.props.board.props.id },
      success: function(result) {
        self.props.board.setState({ cards: self.props.board.state.cards.concat([result])});
        React.findDOMNode(self.refs.cardTitle).value = '';
        self.setState({showForm: false})
      }
    });
  },

  showCardFormHTML: function(){
    return (
      <div className='add-card'>
        <textarea className="kanban-text-area" ref='cardTitle'></textarea>
        <div className='pull-right'>
          <button className='btn btn-default btn-xs' onClick={this.setCardFormState}>Cancel</button>
          <button className='btn btn-active btn-xs' onClick={this.addCard}>Add</button>
        </div>
        <div className='clearfix'></div>
      </div>
    );  
  },

  hideCardFormHTML: function(){
    return (
      <button className='btn btn-active btn-xs' onClick={this.setCardFormState}>Add Card</button>
    );
  },

  setCardFormState: function(state){
    this.setState({showForm: !this.state.showForm});
  },

  render: function(){
    var html = this.state.showForm ? this.showCardFormHTML() : this.hideCardFormHTML();
    return (
      <div className='addCard'>
        {html}
      </div>
    );
  }
});