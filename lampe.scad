$fn=100;

t_height = 300;
t_dia = 150;

thickness = 6;

length = 10;


// get the number of elements by filling the circumference
elements = floor((t_dia * PI) / (thickness + 4));



R = t_dia / 2;
h = thickness;
x = cos(360/elements) * R;
y = sin(360/elements) * R;
// Now for some "magic":
v = 2 * atan((sqrt(-h*h + R*R - 2*R*x + x*x + y*y) + R - x) / (h + y));
// This is the solution of finding the angle v when intersecting the line
// tan(v)(x - R - h / sin(v))
// with the point [cos(gamma)*R, sin(gamma)*R]
// which is the solution to the problem of requiring that the "fins"
// do touch each other

echo(R, h, x, y);
echo(v);




echo(elements);

module fins() {
    color("green", 0.25)
    for ( i = [0:(360 / elements):360] ) {
        rotate([0,0,i]) translate([t_dia/2, 0, 0]) rotate([0,0,v]) cube([length, thickness, t_height-25 + 25 * (sin((i*i)/(360)) + 1/8*cos(i*i*i))]);
    };
}

module fins_d() {
    color("green", 0.25)
    for ( i = [0:(360 / elements):360] ) {
        rotate([0,0,i]) translate([t_dia/2, 0, 0]) rotate([0,0,v]) translate([0,-10,0]) cube([length, thickness+10, t_height-25 + 25 * (sin((i*i)/(360)) + 1/8*cos(i*i*i))]);
    };
}


module plate(){
    difference(){
    cylinder(h=thickness, r=t_dia/2 + thickness/2);
    translate([0,0,-10]) fins_d();
    }
}

fins();

translate([0, 0, 10]) plate();


translate([0, 0, t_height - 80]) plate();

