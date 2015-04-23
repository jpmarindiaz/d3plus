HTMLWidgets.widget({

    name: "d3plusScatter",
    type: "output",

    initialize: function(el, width, height) {

        return d3plus.viz();
    },

    resize: function(el, width, height, instance) {

        // instance.draw();
    },

    renderValue: function(el, x, instance) {

        var vizId = "viz" + Math.random().toString(36).substr(2, 5);

        d3.select(el).append("div")
            .attr('id', vizId);
            
        var sample_data = HTMLWidgets.dataframeToD3(x.data);

        var id = x.settings.id;
        var xAxis = x.settings.xAxis;
        var yAxis = x.settings.yAxis;

        instance
            .container("#" + vizId) // container DIV to hold the visualization
            .data(sample_data) // data to use with the visualization
            .type("scatter") // visualization type
            .id(id) // key for which our data is unique on
            .x(xAxis) // key for x-axis
            .y(yAxis) // key for y-axis
            .draw()



    },
});
