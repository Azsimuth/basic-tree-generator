///draw_pinkcherry(int tree_height)
// input

var height; height = argument0;

// setup
    draw_set_color($314051);
    major_branches = ds_list_create();
    draw_primitive_begin(pr_trianglelist);
// canvas
var canvas_width, canvas_height, c1;
    // The dimension of the canvas will be the dimensions of the generated sprite.

    canvas_height = height * 1.5;
    c1 = 7/12; // This const is the ratio of canvas width to height
    canvas_width = canvas_height * c1;
    
    /*
    if (room_height != canvas_height)
        room_set_height(room, canvas_height);
    if (room_width != canvas_width)
        room_set_width(room, canvas_width);
    */
    
// bark generation
var min_bark_width, max_bark_width, bark_width c2;

    min_bark_width = 1;
    max_bark_width = 16;
    c2 = 1/5;
    if (height <= 80) bark_width = height * c2;
    else bark_width = max_bark_width;
    
var midx, midy;

    midx = round(room_width / 2);
    midy = round(room_height / 2);
    
var stump_height, root_x, root_y;

    stump_height = irandom(3);
    root_y = midy + 64 + stump_height;
    root_x = midx;
    
var root_lx, root_ly, root_rx, root_ry, hw;
// lx = left-x, ..., ry = rigth y, hw = half-width

    hw = round(bark_width / 2);
    root_lx = root_x - hw;
    root_rx = root_x + hw;
    root_ly = root_y; root_ry = root_y;
    
var stump_lx, stump_ly, stump_rx, stump_ry, growth_max1;
// stums should grow be inwards.

    growth_max1 = 5;
    
    stump_lx = root_lx + irandom_range(1, growth_max1);
    stump_ly = root_ly + irandom_range(1, stump_height);
    
    stump_rx = root_rx - irandom_range(1, growth_max1);
    stump_ry = root_ry + irandom_range(1, stump_height);
    
// add the first vertex of the "model"
    draw_vertex(root_lx, root_ly);
    draw_vertex(stump_lx, stump_ly);
    draw_vertex(root_rx, root_ry);
    
// add the other half of the stump
    draw_vertex(stump_lx, stump_ly);
    draw_vertex(stump_rx, stump_ry);
    draw_vertex(root_rx, root_ry);
    
// now, upwards to the skies!!!
// maybe cut the tree into like 5 triangles?
// as with the stumps, these grow inward.

var lside_sec1_x, lside_sec1_y, lside_sec2_x, lside_sec2_y;
var rside_sec1_x, rside_sec1_y, rside_sec2_x, rside_sec2_y;
var topping_height, section_height;
// okay so here's how its gonna go:
// 2 points on the left, 2 on the right,
// 1 to top as the "crown" of it all. where the 2 sides will meet.

    topping_height = irandom_range(3, 6);
    // this defines how tall is the crown, where the two lines unify.
    section_height = round((height - topping_height) / 2);
    
    lside_sec1_x = root_lx + irandom_range(1, growth_max1);
    lside_sec1_y = root_ly - section_height;
    lside_sec2_x = lside_sec1_x + irandom_range(1, growth_max1);
    lside_sec2_y = lside_sec1_y - section_height;
    
    rside_sec1_x = root_rx - irandom_range(1, growth_max1);
    rside_sec1_y = root_ry - section_height;
    rside_sec2_x = rside_sec1_x - irandom_range(1, growth_max1);
    rside_sec2_y = rside_sec1_y - section_height;
    
var top_x, top_y;

    top_x = midx; top_y = lside_sec2_y - topping_height;
    
// adding them to the triangle list

    draw_vertex(root_lx, root_ly);
    draw_vertex(root_rx, root_ry);
    draw_vertex(lside_sec1_x, lside_sec1_y);
    
    draw_set_color($283747);
    
    draw_vertex(root_rx, root_ry);
    draw_vertex(lside_sec1_x, lside_sec1_y);
    draw_vertex(rside_sec1_x, rside_sec1_y);
    
    draw_vertex(lside_sec1_x, lside_sec1_y);
    draw_vertex(rside_sec1_x, rside_sec1_y);
    draw_vertex(lside_sec2_x, lside_sec2_y);
    
    draw_vertex(lside_sec2_x, lside_sec2_y);
    draw_vertex(rside_sec1_x, rside_sec1_y);
    draw_vertex(rside_sec2_x, rside_sec2_y);
    
    draw_vertex(lside_sec2_x, lside_sec2_y);
    draw_vertex(rside_sec2_x, rside_sec2_y);
    draw_vertex(top_x, top_y);
    
// now for the branches!
var branch_count;

    branch_count = 28;
    var i;
    for(i=0;i<branch_count;i+=1) {
        var bw; bw = irandom_range(2,4); // branch width
        var chb; chb = bw != 1; // can host (smaller) branches
        var ix, iy1, iy2; // internal x, internal y 1 ... 2; for the coordinates of the branch on the tree
        var ox, oy; // outer x, outer y, for ther coordinates of the branch out in the air.
        ix = midx;
        iy1 = irandom_range(top_y + 8, root_y - (height/3));
        iy2 = iy1 + irandom_range(-bw / 2, bw);
        
        var c3; c3 = (1/3) // c3 is the ratio of height to max branch size.
        var o; o = height * c3;
        ox = midx + irandom_range(-1.2*o, 1.2*o);
        oy = iy1 - irandom_range(4,20);
        
        draw_vertex(ix, iy1);
        draw_vertex(ix, iy2);
        draw_vertex(ox, oy);
        draw_line(ix, iy1, ox, oy);
        
        ds_list_add(major_branches, ox);
        ds_list_add(major_branches, oy);
        
        if (chb) {
            var j;
            for(j=0;j<irandom_range(0,1);j+=1) {
                var biw; biw = choose(1,2);
                var ibx, iby; // internal branch x, and y
                var len;
                ibx = round((ix + ox) / 2);
                iby = round((iy1 + oy) / 2);
                len = irandom_range(2, o / 5);
                ylen = irandom_range(2, o / 5);
                var obx, oby; // outer branch x, outer branch y
                obx = ibx + choose(-len, len);
                oby = iby + choose(0, ylen);
                
                //draw_vertex(ibx, iby + 1);
                //draw_vertex(ibx, iby - 1);
                //draw_vertex(obx, oby);
                draw_line_width(ibx, iby, obx, oby, biw);
            }
        }
    }
    
draw_primitive_end();    

var folliage_passes, folliage_count;

    folliage_passes = 12;
    folliage_count = 60;
    var m;
    for (m=0;m<ds_list_size(major_branches)/2;m+=2) {
        var outer_x, outer_y;
        outer_x = ds_list_find_value(major_branches, m);
        outer_y = ds_list_find_value(major_branches, m+1);
        var n;
        var used_spr; 
        for (n=0;n<folliage_passes;n+=1) {
                used_spr = choose(spr_pink_main, spr_pink_alt, spr_pink_dark, spr_folliage_greens, spr_pink_alter, spr_pink_alterer);
                var k;
                for (k=0;k<folliage_count;k+=1) {
                    var subimg; subimg = irandom(sprite_get_number(used_spr));
                    if (k==folliage_count-1) {used_spr = spr_pink_main}
                    var dx, dy; 
                    dy = irandom_range(top_y, root_y - height/4);
                    dx = midx + irandom_range(-o*2, o*2);
                    //draw_set_color(c_red);
                    //draw_point(outer_x, outer_y);
                    //draw_circle(outer_x, outer_y, o, true);
                    if point_in_circle(dx, dy, outer_x, outer_y, o/2)
                        draw_sprite(used_spr, subimg, dx, dy);
                }
        }
        
        var f;
        var used_spr; 
        for (f=0;f<folliage_passes/4;f+=1) {
                used_spr = choose(spr_pink_main, spr_pink_alt, spr_pink_dark, spr_folliage_greens, spr_pink_alter, spr_pink_alterer);
                var k;
                for (k=0;k<folliage_count/6;k+=1) {
                    var subimg; subimg = irandom(sprite_get_number(used_spr));
                    if (k==folliage_count-1) {used_spr = spr_pink_main}
                    var dx, dy; 
                    dy = irandom_range(top_y, root_y - height/4);
                    dx = midx + irandom_range(-o, o); 
                    //draw_set_color(c_red);
                    //draw_circle(midx, midy - height/1.5, o, true);
                    if point_in_circle(dx, dy, midx, midy - height/1.5, o)
                        draw_sprite(used_spr, subimg, dx, dy);
                }
        }
    }
    
