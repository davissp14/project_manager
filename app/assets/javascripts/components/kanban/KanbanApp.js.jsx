var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var KanbanApp = React.createClass({

  propTypes: {
    kanban_id: React.PropTypes.number.isRequired
  },

  getInitialState: function(){
    return { data: [] }
  },

  componentWillMount: function(){
    this.loadDataFromServer();
  },

  loadDataFromServer: function(){
    $.ajax({
      url: this.props.kanban_id + '/boards',
      dataType: 'json',
      cache: false,
      success: function(data){
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(xhr, status, err.toString());
      }
    });
  },

  render: function() {
    var Boards = this.state.data.map(function(board, index) {
      return (
        <Board key={index}
                  id={board.id}
                  kanban_id={board.kanban_id }
                  name={board.name}
                  cards={board.cards} />
      );

    });

    return (
      <div className="row">
        {Boards}
        <NewBoardForm kanban_id={this.props.kanban_id} kanban={this}  />
      </div>
    );
 }
});