/*  IPR_guide_bearings.scad
 *  Guide bearings used in IPR (Integrated Parametric RepRap)
 *  Experimental file for a new simple version of Mendel/Huxley
 *  By Nicholas C Lewis 2010
 */

include <IPR_DNA.inc>
use <IPR_func.scad>

upper = 0;		//sides
lower =1;
left = 0;		//hand
right = 1;
two = 0;		//types
three = 1;

%hardware(three);
*x_360guide_bearing(lower);
*xy_guide_bearing(right,lower,two);		//use this module to get x or y guides
z_guide_bearing(lower,two);			//use this to get z guides

module x_360guide_bearing(side){
	union(){
		mirror([0,side,0]){
			xy_guide_bearing(right,side,side);
			translate([-((calXY_guide_mount_hole_spacing)*2-calGuide_bearing_from_end*2)+calScrew_part_T,0,0])
			mirror([1,0,0]){
				xy_guide_bearing(right,side,side);
			}
		}
	}
}

module xy_guide_bearing(hand,side,type){
	mirror([0,hand,0]){
		guide_bearing(type, side, calScrew_part_T, xy_spring_hole_r, calXY_guide_mount_hole_spacing);
	}
}

module z_guide_bearing(side,type){
	union(){
		mirror([0,side,0]){
			guide_bearing(type, side, z_type_T, z_spring_hole_r, calZ_guide_mount_hole_spacing);
			translate([-((calZ_guide_mount_hole_spacing)*2-calGuide_bearing_from_end*2)+z_type_T-dnaRod_R*2-dnaGuide_rod_R*2,0,0])
			mirror([1,0,0]){
				guide_bearing(type, side, z_type_T, z_spring_hole_r, calZ_guide_mount_hole_spacing);
			}
			translate([calGuide_bearing_from_end-calZ_guide_mount_hole_spacing-(dnaRod_R-dnaGuide_rod_R)/2,-calAxis_bearing_center_spacing/2,-z_type_T/2-dnaAxis_bearing_W/2])
				cube([z_type_T-z_spring_hole_r*2,calOne_eighty_mount_W,z_type_T],center=true);
		}
	}
}

module guide_bearing(type, side, thickness, spring_hole_r,overall_length){
	union(){
		difference(){
			union(){
				guide_bearing_main_body(thickness,overall_length);
				if(type == two){
					guide_bearing_mount(dnaAxis_bearing_OR*2+dnaMin_around_hole*2,calOne_eighty_mount_W,thickness);
				}
				if(type == three){
					difference(){
						intersection(){
							translate([-dnaAxis_bearing_IR,-(calAxis_bearing_center_spacing+calOne_eighty_mount_W)/2+((calOne_eighty_mount_W+calAxis_bearing_center_spacing)/2-dnaGuide_rod_R)/2,0])
								cube([dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*2+dnaMin_around_hole*2,(calOne_eighty_mount_W+calAxis_bearing_center_spacing)/2-dnaGuide_rod_R,thickness*2+dnaAxis_bearing_W],center=true);
							*union(){
								rotate([-60,0,0])
									translate([-dnaAxis_bearing_IR*2,0,0])
										guide_bearing_mount(dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*6,dnaAxis_bearing_OR*2+dnaGuide_rod_R*2,thickness/2);
								mirror([0,0,1])
								rotate([-60,0,0])
									guide_bearing_mount(dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*6,dnaAxis_bearing_OR*2+dnaGuide_rod_R*2,thickness/2);
								//translate([0,-calAxis_bearing_center_spacing/2-(thickness/2-(thickness-0.9*dnaAxis_bearing_OR*2)/2),(-thickness-thickness/3)/2-dnaAxis_bearing_W/2])
								//	cube([dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*2+2,calOne_eighty_mount_W,thickness/3],center=true);
							}
						}
						if(dnaAxis_bearing_type==0){
							rotate([-60,0,0])
								translate([0,-(dnaAxis_bearing_OR+2),0])
									cube([100,thickness*2+dnaAxis_bearing_W,dnaAxis_bearing_W],center=true);
	//						mirror([0,0,1])
	//							rotate([-60,0,0])
	//								translate([0,-(dnaAxis_bearing_OR+2),0])
	//									cube([100,dnaAxis_bearing_OR*2+dnaGuide_rod_R*2,dnaAxis_bearing_W],center=true);
							//rotate([60,0,0])translate([0,-calAxis_bearing_center_spacing/2,-thickness/2-dnaAxis_bearing_W/2])rotate([180,0,0])
							//	#mHole_vert_with_hex(dnaAxis_bearing_IR,dnaAxis_bearing_IR*2,100);
						}
							
					}
				}
			}
				if(type == two){
					guide_bearing_mount_cuts(dnaAxis_bearing_OR*2+dnaMin_around_hole*2,calOne_eighty_mount_W,thickness);
				}
				if(type == three){
					union(){
						rotate([-60,0,0])
							translate([-dnaAxis_bearing_IR*2,0,0])
								guide_bearing_mount_cuts(dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*6,dnaAxis_bearing_OR*2+dnaGuide_rod_R*2,thickness/2.5);
						mirror([0,0,1])
							rotate([-60,0,0])
								guide_bearing_mount_cuts(dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*6,dnaAxis_bearing_OR*2+dnaGuide_rod_R*2,thickness/2.5);
					}
				}
			guide_bearing_main_body_cuts(side,thickness,spring_hole_r,overall_length);
		}
	}

}

module hardware(type){
	translate([0,0,0])
		rotate([0,90,0])
			mGuide_rod(100);
	if(type == two){	
		translate([0,-calAxis_bearing_center_spacing/2,0])
			mAxis_bearing();
	}
	translate([0,calAxis_bearing_center_spacing/2,0])
		mAxis_bearing();
	if(type == three){
		rotate([60,0,0])
			translate([0,-calAxis_bearing_center_spacing/2,0])
				mAxis_bearing();
		rotate([-60,0,0])
			translate([-dnaAxis_bearing_IR*2,-calAxis_bearing_center_spacing/2,0])
				mAxis_bearing();
	}
}

module guide_bearing_mount(length,width,thickness){
	translate([0,-calAxis_bearing_center_spacing/2,-thickness/2-dnaAxis_bearing_W/2])
		cube([length,width,thickness],center=true);
}

module guide_bearing_mount_cuts(length,width,thickness){
	translate([0,-calAxis_bearing_center_spacing/2,-thickness/2-dnaAxis_bearing_W/2])
		mHole_vert(dnaAxis_bearing_IR,100);
	if(dnaAxis_bearing_type==0){
		translate([0,-calAxis_bearing_center_spacing/2,dnaAxis_bearing_W/2])
			//mHole_vert(dnaAxis_bearing_OR+1,20);
			cube([2*dnaAxis_bearing_OR+2,4*dnaAxis_bearing_OR+2,2*dnaAxis_bearing_W], center= true);
	}
	translate([0,-calAxis_bearing_center_spacing/2,-thickness-dnaAxis_bearing_W/2-11])
		mHole_vert(dnaAxis_bearing_nut,20);

}


module guide_bearing_main_body(thickness, overall_length){
	translate([-overall_length+calGuide_bearing_from_end+thickness/2,-(calOne_eighty_mount_W+calAxis_bearing_center_spacing)/4,-thickness/2-dnaAxis_bearing_W/2])
		union(){
			cube([thickness,(calOne_eighty_mount_W+calAxis_bearing_center_spacing)/2,thickness],center=true);
			translate([(overall_length-thickness)/2,-(calOne_eighty_mount_W+calAxis_bearing_center_spacing)/4+calOne_eighty_mount_W/2,0])
				cube([overall_length,calOne_eighty_mount_W,thickness],center=true);
		}
}

module guide_bearing_main_body_cuts(side,thickness,hole_r, overall_length){
	translate([calGuide_bearing_from_end-calMin_screw_from_edge,-calAxis_bearing_center_spacing/2,-thickness/2-dnaAxis_bearing_W/2])
		rotate([0,-90,90])
			mHole_horiz(dnaScrew_R,100);
	translate([-overall_length+calGuide_bearing_from_end+thickness/2,0,-thickness/2-dnaAxis_bearing_W/2])
		union(){
			rotate([0,-90,90])
				mHole_horiz(hole_r,100);
			if(side==lower){
				translate([thickness/2+calOne_eighty_mount_W/3,-calAxis_bearing_center_spacing/2-calOne_eighty_mount_W/2,-calOne_eighty_mount_W/2-dnaAxis_bearing_W/2]){
					mHole_vert(calOne_eighty_mount_W/3,100);
					translate([0,calOne_eighty_mount_W,0]){
						mHole_vert(calOne_eighty_mount_W/3,100);
					}
				}
			}
		}
}

