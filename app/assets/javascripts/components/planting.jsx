class Planting extends React.Component {
  fetchRecord(field) {

  }
  render() {
    return (
      <div name="planting">
        {this.props.planting.planted_at}
      </div>
    );
  }
}