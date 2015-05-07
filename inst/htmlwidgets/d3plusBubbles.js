HTMLWidgets.widget({

    name: "d3plusBubbles",
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

console.log(x.settings.data_names)
        var id = x.settings.data_names.id;
        var value = x.settings.data_names.value;
        var group = x.settings.data_names.group;

        instance
            .container("#" + vizId) // container DIV to hold the visualization
            .data(sample_data) // data to use with the visualization
            .type("bubbles")       // visualization type
            .id([group, id]) // nesting keys
            .depth(1)              // 0-based depth
            .size(value)         // key name to size bubbles
            .color(group)        // color by each group
            .draw()

    },
});
