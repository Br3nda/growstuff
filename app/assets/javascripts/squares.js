$(document).ready(function () {
  display_garden_map = function(targetId) {

    var width = $( "#garden_width" ).val();
    var length = $( "#garden_length" ).val();

    let gridDefinition = []
    let order = 0;
    let max = 20; // maximum width/length
    for (let yOrigin=0, i=0; i < length && i < max; i++) {
        for (let xOrigin = 0, j=0; j < width && j < max; j++) {
            gridDefinition.push({
                x: xOrigin * 50,
                y: yOrigin * 50,
                width: 50,
                height: 50,
                index: [i,j].toString(),
                order: order
            })
            xOrigin++;
            order++;
        }
        yOrigin++;
        order++;
    }

    d3.select(targetId).selectAll("*").remove();

    let canvas = d3.select(targetId).append("svg")
        .attr("width", 50 * width)
        .attr("height", 50 * length)

    let map = canvas.selectAll(".map")
        .data([gridDefinition])
        .enter().append("svg:g")
        .attr("class", "map")

    let cells = map.selectAll(".cell")
        .data( gridDefinition )
        .enter().append("svg:circle")
        .attr("cx", (d) => d.x + 25 )
        .attr("cy", (d) => d.y + 25 )
        .attr("r", 15)
        .attr("width", (d) => d.width )
        .attr("height", (d) => d.height )
        .attr("index", (d) => d.index )
        .on('click', function(){ handle_click(this) })
        .style("fill", '#FFF')
        .style("stroke", '#555')
  }

  handle_click = function(element) {
      // let status_color;
      // let hit_color = "#75AF1D"
      // let miss_color = "#CC3300"
      let cell = d3.select(element);
      let planting_id = $('input[name=planting]:checked').val();
      // let planting_name = PLANTINGS[planting_id];

      // if (hit_boxes.indexOf(cell.attr("index")) != -1) {
      //     status_color = hit_color
      // } else {
      //     status_color = miss_color
      // }
      cell.style("fill", "#CC3300")
      cell.enter().append("!");
  }

  assign_plantings = function(gridSize) {

    //assume initial state is horizontal
    let ship_dimensions = [[5, 1], [4, 1], [3, 1], [3, 1], [3, 1]]
    let occupied = []

    ship_dimensions.forEach((ship) => {
        place_ship(ship, occupied);
    })

    return occupied;
  }


  $( "#garden_width,#garden_length" ).change(function() {
    display_garden_map("#gardenmap");
  });

  var planting_map = []; // TODO load from server

  display_garden_map("#gardenmap");
});