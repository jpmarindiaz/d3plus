HTMLWidgets.widget({

    name: "d3plus",
    type: "output",

    initialize: function(el, width, height) {
        return d3plus.viz();
    },

    resize: function(el, width, height, instance) {
        // instance.draw();
    },

    renderValue: function(el, x, instance) {

        var d3plus = instance;
        var vizId = el.id;
        
        d3plusType = x.settings.d3plusType; 

        // select the viz element and remove existing children
        // d3.select(el).select(vizId).selectAll("*").remove();

        if(d3plusType == "tree"){
            draw_tree(el,x,instance)
        }
        if(d3plusType == "lines"){
            draw_lines(el,x,instance)
        }


        function draw_tree(el, x, instance){
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
        }

        function draw_lines(el, x, instance){
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            var id = x.settings.id;
            var xAxis = x.settings.xAxis;
            var value = x.settings.value;
            d3plus
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
        }



    },
});
