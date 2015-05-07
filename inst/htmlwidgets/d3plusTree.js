HTMLWidgets.widget({

    name: "d3plusTree",
    type: "output",

    initialize: function(el, width, height) {
        return d3plus.viz();
    },

    resize: function(el, width, height, instance) {

        // instance.draw();
    },

    renderValue: function(el, x, instance) {

        d3plus = instance
        var vizId = el.id;
        
        // select the viz element and remove existing children
        // d3.select(el).select(vizId).selectAll("*").remove();

        var sample_data = HTMLWidgets.dataframeToD3(x.data);

        var id = x.settings.data_names.id;
        var size = x.settings.data_names.size;
        var color = x.settings.data_names.color;

        d3plus
            .container("#" + vizId) // container DIV to hold the visualization
            .data(sample_data) // data to use with the visualization
            .type("tree_map")   // visualization type
            .id(id) // nesting keys
            .size(size)         // key name to size bubbles
            .color(color)
            .draw()
    },
});
