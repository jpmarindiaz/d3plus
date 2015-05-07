HTMLWidgets.widget({

    name: "d3plusLines",
    type: "output",

    initialize: function(el, width, height) {

        return d3plus.viz();
    },

    resize: function(el, width, height, instance) {
        // instance.draw();
    },

    renderValue: function(el, x, instance) {

        var vizId = el.id;

        var sample_data = HTMLWidgets.dataframeToD3(x.data);

        var id = x.settings.id;
        var xAxis = x.settings.xAxis;
        var value = x.settings.value;

        instance
            .container("#" + vizId) // container DIV to hold the visualization
            .data(sample_data) // data to use with the visualization
            .type("line") // visualization type
            .text(id)       // key to use for display text
            .id(id) // key for which our data is unique on
            .color(id)
            .x(xAxis) // key for x-axis
            .y(value) // key for y-axis
            // .legend()
            .legend({"size": 50})
            .draw()

    },
});
