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
        
        d3plusType = x.d3plusType;
        // console.log(d3plusType)
        // select the viz element and remove existing children
        // d3.select(el).select(vizId).selectAll("*").remove();

        if(d3plusType == "tree"){
            draw_tree(el,x,d3plus);
        }
        if(d3plusType == "lines"){
            draw_lines(el,x,d3plus)
        }
        if(d3plusType == "bubbles"){
            draw_bubbles(el,x,d3plus)
        }
        if(d3plusType == "scatter"){
            draw_scatter(el,x,d3plus)
        }
        if(d3plusType == "network"){
            draw_network(el,x,d3plus)
        }
        if(d3plusType == "rings"){
            draw_rings(el,x,d3plus)
        }

        function draw_tree(el, x, d3plus){
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

        function draw_lines(el, x, d3plus){
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

        function draw_bubbles(el, x, d3plus){
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            console.log(x.settings.data_names)
            var id = x.settings.data_names.id;
            var value = x.settings.data_names.value;
            var group = x.settings.data_names.group;

            d3plus
                .container("#" + vizId) // container DIV to hold the visualization
                .data(sample_data) // data to use with the visualization
                .type("bubbles")       // visualization type
                .id([group, id]) // nesting keys
                .depth(1)              // 0-based depth
                .size(value)         // key name to size bubbles
                .color(group)        // color by each group
                .draw()
            }

        function draw_scatter(el,x,d3plus){
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            var id = x.settings.id;
            var xAxis = x.settings.xAxis;
            var yAxis = x.settings.yAxis;
            d3plus
                .container("#" + vizId) // container DIV to hold the visualization
                .data(sample_data) // data to use with the visualization
                .type("scatter") // visualization type
                .id(id) // key for which our data is unique on
                .x(xAxis) // key for x-axis
                .y(yAxis) // key for y-axis
                .draw()
            }

        function draw_network(el,x,d3plus){
            var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
            var edges = HTMLWidgets.dataframeToD3(x.data.edges);
            var positions = x.data.positions;
            var edgesProps = {
                "arrows": false,
                "label":"label",
                "size": "size",
                "color": "#A40"
                };
              d3plus
                .container("#" + vizId)
                .type("network")
                .data(nodes)
                .nodes(positions)
                .edges(edges)
                .edges(edgesProps)
                .size("size")
                .id("id")
                .draw()
            }

        function draw_rings(el,x,d3plus){
            var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
            var edges = HTMLWidgets.dataframeToD3(x.data.edges);
            var positions = x.data.positions;

            console.log(x.settings)
            var focusDropdown = x.settings.focusDropdown;

            var ui = [];
            if(focusDropdown){
                ui = [{
                        "label": "Center",
                        "method": function(value, viz) {
                            viz.focus(value).draw();
                        },
                        "type": "drop",
                        "value": x.data.nodes.id
                    }];               
            }

            var edgesProps = {
                "arrows": false,
                "label":"label",
                "size": "size",
                "color": "#A40"
                };           
            var focus = {
                "tooltip" : true,
                "value"   : nodes[0].id
                };
            var lang = "es_ES";
            // "zh_CN","en_US","es_ES","pt_BR"
            var tooltip = {
                "html":"<h1>Tootltip</h1>"};
              d3plus
                .container("#" + vizId)
                .type("rings")
                .data(nodes)
                .nodes(positions)
                .edges(edges)
                .edges(edgesProps)
                .size("size")
                .id("id")
                .focus(focus)
                // .tooltip(tooltip)
                // .format(lang)
                .ui(ui)
                .draw()
            }

    }
});
