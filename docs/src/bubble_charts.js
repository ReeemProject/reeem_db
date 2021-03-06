'use strict';

/* bubbleChart creation function. Returns a function that will
 * instantiate a new bubble chart given a DOM element to display
 * it in and a dataset to visualize.
 *
 * Organization and style inspired by:
 * https://bost.ocks.org/mike/chart/
 *
 */
function bubbleChart() {
  // Constants for sizing
  const width = 940;
  const height = 700;

  // tooltip for mouseover functionality
  const tooltip = floatingTooltip('gates_tooltip', 360);

  // Locations to move bubbles towards, depending
  // on which view mode is selected.
  const center = { x: width / 2, y: height / 2 };

  // @v4 strength to apply to the position forces
  const forceStrength = 0.03;

  // These will be set in create_nodes and create_vis
  let svg = null;
  let bubbles = null;
  let nodes = [];

  // Charge function that is called for each node.
  // As part of the ManyBody force.
  // This is what creates the repulsion between nodes.
  //
  // Charge is proportional to the diameter of the
  // circle (which is stored in the radius attribute
  // of the circle's associated data.
  //
  // This is done to allow for accurate collision
  // detection with nodes of different sizes.
  //
  // Charge is negative because we want nodes to repel.
  // @v4 Before the charge was a stand-alone attribute
  //  of the force layout. Now we can use it as a separate force!
  function charge(d) {
    return -Math.pow(d.radius, 2.0) * forceStrength;
  }

  // Here we create a force layout and
  // @v4 We create a force simulation now and
  //  add forces to it.
  const simulation = d3.forceSimulation()
    .velocityDecay(0.2)
    .force('x', d3.forceX().strength(forceStrength).x(center.x))
    .force('y', d3.forceY().strength(forceStrength).y(center.y))
    .force('charge', d3.forceManyBody().strength(charge))
    .on('tick', ticked);

  // @v4 Force starts up automatically,
  //  which we don't want as there aren't any nodes yet.
  simulation.stop();

  // Nice looking colors - no reason to buck the trend
  // @v4 scales now have a flattened naming scheme
  const fillColor = d3.scaleOrdinal()
    .domain([1, 2, 3, 4, 5, 6, 7, 8])
    .range(['#80001b',
            '#054b80',
            '#803601',
            '#4c3580',
            '#34801a',
            '#801355',
            '#804e12',
            '#01816e'
    ]);


  /*
   * This data manipulation function takes the raw data from
   * the CSV file and converts it into an array of node objects.
   * Each node will store data and visualization values to visualize
   * a bubble.
   *
   * rawData is expected to be an array of data objects, read in from
   * one of d3's loading functions like d3.csv.
   *
   * This function returns the new node array, with a node in that
   * array for each element in the rawData input.
   */
  function createNodes(rawData) {
    // Use the max total_amount in the data as the max in the scale's domain
    // note we have to ensure the total_amount is a number.
    const maxAmount = d3.max(rawData, function (d) { return +d.amount; });

    // Sizes bubbles based on area.
    // @v4: new flattened scale names.
    const radiusScale = d3.scalePow()
      .exponent(0.5)
      .range([2, 85])
      .domain([0, maxAmount]);

    // Use map() to convert raw data into node data.
    // Checkout http://learnjsdata.com/ for more on
    // working with data.
    const myNodes = rawData.map(function (d) {
      return {
        id: d.id,
        radius: radiusScale(+d.amount),
        value: +d.amount,
        key: d.key,
        key_value: d.value,
        schema: d.schema,
        model: d.model,
        x: Math.random() * 900,
        y: Math.random() * 800
      };
    });

    // sort them to prevent occlusion of smaller nodes.
    myNodes.sort(function (a, b) { return b.value - a.value; });

    return myNodes;
  }

  /*
   * Main entry point to the bubble chart. This function is returned
   * by the parent closure. It prepares the rawData for visualization
   * and adds an svg element to the provided selector and starts the
   * visualization creation process.
   *
   * selector is expected to be a DOM element or CSS selector that
   * points to the parent element of the bubble chart. Inside this
   * element, the code will add the SVG continer for the visualization.
   *
   * rawData is expected to be an array of data objects as provided by
   * a d3 loading function like d3.csv.
   */
  const chart = function chart(selector, rawData) {
    // convert raw data into nodes data
    nodes = createNodes(rawData);

    // Create a SVG element inside the provided selector
    // with desired size.
    svg = d3.select(selector)
      .append('svg')
      .attr('width', width)
      .attr('height', height);

    // Bind nodes data to what will become DOM elements to represent them.
    bubbles = svg.selectAll('g')
      .data(nodes, function (d) { return d.id; });

    // Create new circle elements each with class `bubble`.
    // There will be one circle.bubble for each object in the nodes array.
    // Initially, their radius (r attribute) will be 0.
    // @v4 Selections are immutable, so lets capture the
    //  enter selection to apply our transtition to below.
    let bubblesE = bubbles.enter().append('g');

    bubblesE.append('circle')
      .classed('bubble', true)
      .attr('r', 0)
      .attr('fill', function (d) { return fillColor(d.schema); })
      .attr('stroke', function (d) { return d3.rgb(fillColor(d.schema)).darker(2); })
      .attr('stroke-width', 2)
      .on('mouseover', showDetail)
      .on('mouseout', hideDetail);

    bubblesE.append('text')
      .attr('id', d => d.id)
      .attr('fill', 'white')
      .attr('text-anchor', 'middle')
      .attr('dominant-baseline', 'central')
      .text(d => d.schema);

    // @v4 Merge the original empty selection and the enter selection
    bubbles = bubbles.merge(bubblesE);

    // Fancy transition to make bubbles appear, ending with the
    // correct radius
    bubbles.select('circle').transition()
      .duration(1000)
      .attr('r', function (d) { return d.radius; });

    // Set the simulation's nodes to our newly created nodes array.
    // @v4 Once we set the nodes, the simulation will start running automatically!
    simulation.nodes(nodes);

    // Set initial layout to single group.
    groupBubbles();
  };

  /*
   * Callback function that is called after every tick of the
   * force simulation.
   * Here we do the actual repositioning of the SVG circles
   * based on the current x and y values of their bound node data.
   * These x and y values are modified by the force simulation.
   */
  function ticked() {
    bubbles.select('circle')
      .attr('cx', function (d) { return d.x; })
      .attr('cy', function (d) { return d.y; });

    bubbles.select('text')
      .style('font-size', function (d) { return d.radius / 3 + 'px'; })
      .attr('x', function (d) { return d.x; })
      .attr('y', function (d) { return d.y; });
  }

  /*
   * Sets visualization in "single group mode".
   * The year labels are hidden and the force layout
   * tick function is set to move all nodes to the
   * center of the visualization.
   */
  function groupBubbles() {
    // hideYearTitles();

    // @v4 Reset the 'x' force to draw the bubbles to the center.
    simulation.force('x', d3.forceX().strength(forceStrength).x(center.x));

    // @v4 We can reset the alpha value and restart the simulation
    simulation.alpha(1).restart();
  }

  /*
   * Function called on mouseover to display the
   * details of a bubble in the tooltip.
   */
  function showDetail(d) {
    // change outline to indicate hover state.
    d3.select(this)
        .attr('stroke', function (d) { return d3.rgb(fillColor(d.schema)); });
    d3.select(this)
        .attr('fill', function (d) { return d3.rgb(fillColor(d.schema)).brighter(1); });
    d3.select(this)
        .attr('r', function (d) { return d.radius + 4; });

    const content = '<span class="name">Model: </span><span class="value">' +
                  d.model +
                  '</span><br/>' +
                  '<span class="name">Schema: </span><span class="value">' +
                  d.schema +
                  '</span><br/>' +
                  '<span class="name">Key: </span><span class="value">' +
                  d.key +
                  '</span><br/>' +
                  '<span class="name">Value: </span><span class="value">' +
                  d.key_value +
                  '</span><br/>' +
                  '<span class="name">Records: </span><span class="value">' +
                  addCommas(d.value) +
                  '</span>';

    tooltip.showTooltip(content, d3.event);
  }

  /*
   * Hides tooltip
   */
  function hideDetail(d) {
    // reset outline
    d3.select(this)
      .attr('fill', function (d) { return d3.rgb(fillColor(d.schema)); });
    d3.select(this)
      .attr('stroke', d3.rgb(fillColor(d.schema)).darker(2));
    d3.select(this)
        .attr('r', function (d) { return d.radius; });

    tooltip.hideTooltip();
  }

  // return the chart function from closure.
  return chart;
}

/*
 * Below is the initialization code as well as some helper functions
 * to create a new bubble chart instance, load the data, and display it.
 */

const myBubbleChart = bubbleChart();

/*
 * Function called once data is loaded from CSV.
 * Calls bubble chart function to display inside #vis div.
 */
function display(error, data) {
  if (error) {
    console.log(error);
  }

  // Delete content in element with vis id
  document.getElementById('vis').innerHTML = "";

  myBubbleChart('#vis', data);
}

/*
 * Sets up the layout buttons to allow for toggling between view modes.
 */
function setupButtons() {
  d3.select('#toolbar')
    .selectAll('.button')
    .on('click', function () {
      // Remove active class from all buttons
      d3.selectAll('.button').classed('active', false);
      // Find the button just clicked
      var button = d3.select(this);

      // Set it as the active button
      button.classed('active', true);
    });
}

/*
 * Helper function to convert a number into a string
 * and add commas to it to improve presentation.
 */
function addCommas(nStr) {
  nStr += '';
  const x = nStr.split('.');
  let x1 = x[0];
  const x2 = x.length > 1 ? '.' + x[1] : '';
  const rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',' + '$2');
  }

  return x1 + x2;
}

// Load the data.
const elements = document.querySelectorAll('#toolbar a');

elements.forEach(el => {
    el.addEventListener('click', () => { d3.csv(`data/${el.id}.csv`, display); });
});

// Setup the buttons.
setupButtons();

/*
 * Set bubble chart on startup, defined by active class in HTML
 * If you set more than one element to the class 'active',
 * it will take the first element.
*/
const el_startup = document.querySelectorAll('.active')[0].id
d3.csv(`data/${el_startup}.csv`, display);
