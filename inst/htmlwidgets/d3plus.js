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

        if (d3plusType == "tree") {
            draw_tree(el, x, d3plus);
        }
        if (d3plusType == "lines") {
            draw_lines(el, x, d3plus)
        }
        if (d3plusType == "bubbles") {
            draw_bubbles(el, x, d3plus)
        }
        if (d3plusType == "scatter") {
            draw_scatter(el, x, d3plus)
        }
        if (d3plusType == "network") {
            draw_network(el, x, d3plus)
        }
        if (d3plusType == "rings") {
            draw_rings(el, x, d3plus)
        }

        function draw_tree(el, x, d3plus) {
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            var id = x.settings.data_names.id;
            var size = x.settings.data_names.size;
            var color = x.settings.data_names.color;

            // include legend when color supplied
            var color_opt = (sample_data[0].hasOwnProperty('color')) ? true : false;

            var mouse_opt;
            if (sample_data[0].hasOwnProperty('url')) {
              mouse_opt = {"move": false,
                           "over": false,
                           "click": function(value, viz){
                                       window.open(value.url, '_blank');
                                     }
                          };
              color_opt = false; // switch off legend when using URL
            } else {
              mouse_opt = true; // maintain default when url missing
            }

            d3plus
                .container("#" + vizId) // container DIV to hold the visualization
                .data(sample_data) // data to use with the visualization
                .type("tree_map") // visualization type
                .id(id) // nesting keys
                .size(size) // key name to size bubbles
                .color(color)
                .mouse(mouse_opt)
                .legend(color_opt) // in future, better to enable legend attribute
                .draw();
        }

        function draw_lines(el, x, d3plus) {
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            var id = x.settings.id;
            var xAxis = x.settings.xAxis;
            var value = x.settings.value;
            d3plus
                .container("#" + vizId) // container DIV to hold the visualization
                .data(sample_data) // data to use with the visualization
                .type("line") // visualization type
                .text(id) // key to use for display text
                .id(id) // key for which our data is unique on
                .color(id)
                .x(xAxis) // key for x-axis
                .y(value) // key for y-axis
                // .legend()
                .legend({
                    "size": 50
                })
                .draw()
        }

        function draw_bubbles(el, x, d3plus) {
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            console.log("SETTINGS\n", x.settings)
            var id = x.settings.data_names.id;
            var value = x.settings.data_names.value;
            var group = x.settings.data_names.group;
            var attributes = HTMLWidgets.dataframeToD3(x.settings.attributes);
            console.log("ATTRIBUTES\n", attributes)

            if (attributes.length > 0) {
                d3plus
                    .container("#" + vizId) // container DIV to hold the visualization
                    .data(sample_data) // data to use with the visualization
                    .type("bubbles") // visualization type
                    .id([group, id]) // nesting keys
                    .depth(1) // 0-based depth
                    .size(value) // key name to size bubbles
                    .attrs(attributes)
                    .color("color")
                    .draw()
            } else {
                d3plus
                    .container("#" + vizId) // container DIV to hold the visualization
                    .data(sample_data) // data to use with the visualization
                    .type("bubbles") // visualization type
                    .id([group, id]) // nesting keys
                    .depth(1) // 0-based depth
                    .size(value) // key name to size bubbles
                    .color(id) // color by each group
                    .draw()
            }
        }

        function draw_scatter(el, x, d3plus) {
            var sample_data = HTMLWidgets.dataframeToD3(x.data);
            var id = x.settings.id;
            var xAxis = x.settings.xAxis;
            var yAxis = x.settings.yAxis;
            var size = x.settings.size;
            d3plus
                .container("#" + vizId) // container DIV to hold the visualization
                .data(sample_data) // data to use with the visualization
                .type("scatter") // visualization type
                .id(id) // key for which our data is unique on
                .x(xAxis) // key for x-axis
                .y(yAxis) // key for y-axis
                .size(size)
                .draw()
        }

        function draw_network(el, x, d3plus) {
            var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
            console.log(x);
            var edges = HTMLWidgets.dataframeToD3(x.data.edges);
            var positions = x.data.positions;
            var vars = x.data.vars;
            if (nodes.group) {
                var text = {
                    "group": "group",
                    "id": "label"
                };
            } else {
                var text = "label"
            }
            var lang = x.settings.lang || "en_US"; // "zh_CN","en_US","es_ES","pt_BR"
            var focus = x.settings.focus || false;
            var showTooltip = x.settings.showTooltip;
            if(!showTooltip){
                focus = {"tooltip": false, "focus": focus};
            };
            var showLegend = x.settings.showLegend || false;
            var edgesProps = {
                "arrows": false,
                "label": "label",
                "size": "size",
                "color": "#CCC"
            };
            d3plus
                .container("#" + vizId)
                .type("network")
                .data(nodes)
                .nodes(positions)
                .edges(edges)
                .edges(edgesProps)
                .color("color")
                .size(vars.size)
                .id(["id"])
                // https://groups.google.com/forum/#!topic/d3plus/q4iXv0rpzQo
                // .text("label")
                // .id(["group","id"])
                .text(text)
                .tooltip(["id", "label"])
                .tooltip({
                    connections: true
                })
                .legend({
                    value: showLegend,
                    data: false,
                    text: "group"
                })
                .format(lang)
                .focus(focus, function(node_id) {
                    // console.log(node_id)
                    if (typeof Shiny != "undefined") {
                        Shiny.onInputChange('d3plus_clicked_node', node_id)
                    }
                })
                .draw()
        }

        function draw_rings(el, x, d3plus) {
            var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
            var edges = HTMLWidgets.dataframeToD3(x.data.edges);
            var positions = x.data.positions;
            var vars = x.data.vars;
            if (nodes.group) {
                var text = {
                    "group": "group",
                    "id": "label"
                };
            } else {
                var text = "label"
            }
            console.log(x.data)
            var focusDropdown = x.settings.focusDropdown;
            var lang = x.settings.lang || "en_US"; // "zh_CN","en_US","es_ES","pt_BR"
            var showLegend = x.settings.showLegend || false
            var ui = [];
            if (focusDropdown) {
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
                "label": "label",
                "size": "size",
                "color": "#CCC"
            };
            var focus = {
                "tooltip": true,
                "value": nodes[0].id
            };
            var tooltip = {
                "html": "<h1>Tootltip</h1>"
            };
            d3plus
                .container("#" + vizId)
                .type("rings")
                .data(nodes)
                .nodes(positions)
                .edges(edges)
                .edges(edgesProps)
                .color("color")
                .size(vars.size)
                .id(["id"])
                .focus(focus)
                .text(text)
                .tooltip(["id", "label"])
                .tooltip({
                    connections: true
                })
                .legend({
                    value: showLegend,
                    data: true,
                    text: "group"
                })
                .format(lang)
                .ui(ui)
                .draw()
        }

    }
});
