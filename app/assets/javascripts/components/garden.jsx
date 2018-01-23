class Garden extends React.Component {
  constructor(props) {
    super(props);

    var map_grid = [];
    for(var x=1; x<= this.width(); x++) {
      map_grid[x] = [];
      for(var y=1; y<= this.height(); y++) {
        map_grid[x][y] = this.props.plantings[x];
      }
    }
    this.state = {  map_grid: map_grid };
  }
  // renderPlantings() {
  //   return this.props.plantings.map((planting) =>
  //     <Planting planting={planting} />
  //   );
  // }
  renderMapGrid() {
    return this.state.map_grid.map((x, row) =>
      <MapRow key={x} x={x} row={row} />
    );
  }
  width() {
    return this.props.plantings.length;
  }
  height() {
    return this.props.plantings.length;
  }

  render() {
    return (
      <div name="garden">
        <h1>{this.props.garden.name}</h1>
        {this.renderMapGrid()}
      </div>
    );
  }
}

class MapRow extends React.Component {
  render() {
    return this.props.row.map((y) =>
      <MapSquare x={this.props.x} y={y} />
    );
  }
}
class MapSquare extends React.Component {
  render() {
    return <p>{x}/{y}</p>
  }
}