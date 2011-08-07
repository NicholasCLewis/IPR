/*  IPR_parts.scad
 *  Miscellaneous standard objects used in IPR (Integrated Parametric RepRap)
 *  Experimental file for a new simple version of Mendel/Huxley
 *  By Nicholas C Lewis 2010
 *
 *  http://www.thingiverse.com/thing:
 *  http://reprap.org/wiki/Integrated_Parametric_RepRap
 *
 *  Loosly based on "mendel_misc.inc" by Vik Olliver 29-03-2010.
 *  which used components of the OpenSCAD Shapes Library (www.openscad.at)
 *  Copyright (C) 2009  Catarina Mota <clifford@clifford.at>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
*/

include <IPR_DNA.inc>
use <IPR_func.scad>
use <IPR_guide_bearingsWithZ.scad>

*mMain_assy_testing();
*mX_motor_mount_clamp();
*mX_motor_mount();
*mY_motor_mount();
*mZ_guide_clamp();
*projection()rotate([0,90,0])mThick_sheet_side();
*mUpper_vertex();
*mLower_vertex();
*mClamp(dnaRod_R,dnaGuide_rod_R);
*mZ_lifter();
*mZ_axis_support_motor();
*mZ_axis_support_no_motor();
mEnd_stop_clamp();

dnaMotor_pulley_R = 6.5;

module mMain_assy_testing(){
	echo(calX_car_L);
	function fPythagoras(a,b) = sqrt(pow(a,2)+pow(b,2));
	calZ_belt_L = 6*dnaZ_drive_pulley_R+ calZ_drive_rod_spacing +2*dnaMotor_pulley_R+ fPythagoras(calZ_drive_rod_to_motor_spacing_x+dnaZ_drive_pulley_R-dnaMotor_pulley_R,calZ_drive_rod_to_motor_spacing_y-dnaZ_drive_pulley_R+dnaMotor_pulley_R)+ fPythagoras(calZ_drive_rod_to_motor_spacing_x+dnaZ_drive_pulley_R-dnaMotor_pulley_R,calZ_drive_rod_spacing-calZ_drive_rod_to_motor_spacing_x+dnaZ_drive_pulley_R-dnaMotor_pulley_R);
	echo("z belt");
	echo(calZ_belt_L);
	echo(calZ_drive_rod_spacing);
	echo(calZ_drive_rod_to_motor_spacing_y);
	echo(calZ_drive_rod_to_motor_spacing_x);
	echo(dnaZ_drive_pulley_R);
	color([ 100/255, 100/255, 120/255, 1])linear_extrude(height=10)
		polygon(points=[[-dnaZ_drive_pulley_R,-dnaZ_drive_pulley_R],[-dnaZ_drive_pulley_R,dnaZ_drive_pulley_R],[calZ_drive_rod_spacing+dnaZ_drive_pulley_R,dnaZ_drive_pulley_R],[calZ_drive_rod_spacing+dnaZ_drive_pulley_R,-dnaZ_drive_pulley_R],[calZ_drive_rod_to_motor_spacing_x+dnaMotor_pulley_R,-calZ_drive_rod_to_motor_spacing_y-dnaMotor_pulley_R],[calZ_drive_rod_to_motor_spacing_x-dnaMotor_pulley_R,-calZ_drive_rod_to_motor_spacing_y-dnaMotor_pulley_R]], paths=[[0,1,2,3,4,5]]);
	mBOM();
	color([ 20/255, 20/255, 200/255, 1]){
		translate([0,0,-dnaBelt_W])
			cylinder(r=dnaZ_drive_pulley_R+dnaBelt_T,h=dnaBelt_W+2,center=true);
	}
	translate([(calZ_drive_rod_spacing-calVertex_spacing_x)/2-calRod_part_T,0,60])
	rotate([0,90,0])
	z_guide_bearing(0,0);
	//for(i=[calRod_part_T/2+2*dnaRod_R-calScrew_part_T/2,calZ_guide_rod_L-calRod_part_T/2]){
	//translate([(calZ_drive_rod_spacing-calVertex_spacing_x)/2-calRod_part_T,0,i])
	//	mZ_guide_clamp();
	//}
	translate([-calZ_drive_rod_to_guide_rod_spacing-calRod_part_T/2+dnaRod_R,0,calZ_guide_rod_L-calRod_part_T/2])
		mZ_guide_clamp();
	translate([-calZ_drive_rod_to_guide_rod_spacing+2*dnaRod_R,0,2*dnaRod_R])rotate([0,180,90])
		mClamp(dnaRod_R,dnaGuide_rod_R);
	if(dnaVertex_type == 1){
		%mThick_sheet_side();
	}
	if(dnaVertex_type == 0){
		for(i=[(calZ_drive_rod_spacing-calVertex_spacing_x)/2,(calZ_drive_rod_spacing+calVertex_spacing_x)/2]){
			translate([i,0,calY_support_to_lower_support_z+calY_support_to_upper_support_z])
				mUpper_vertex();
			translate([i,calVertex_spacing_y/2,0])
				mLower_vertex();
			translate([i,-calVertex_spacing_y/2,0])
				mirror([0,1,0])mLower_vertex();
		}
	}
	mFrame();
translate([calZ_drive_rod_spacing/2, -calVertex_spacing_y/2-calY_support_to_lower_support_y-dnaMotor_w/2-dnaRod_R, calY_support_to_lower_support_z-dnaMotor_w/2+dnaIdler_pulley_R])rotate([0,90,0])
	mY_motor_mount();
translate([calZ_drive_rod_spacing+calZ_drive_rod_to_guide_rod_spacing+dnaMotor_w/2+dnaRod_R,calX_guide_rod_spacing/2+(calMin_rod_from_edge-dnaMotor_mount_T),(calZ_drive_rod_L-calRod_part_T)/2-dnaRod_R*2])rotate([-90,180,0])
	mX_motor_mount();
translate([calZ_drive_rod_spacing+calZ_drive_rod_to_guide_rod_spacing+dnaMotor_w/2+dnaRod_R,calX_guide_rod_spacing/2+(calMin_rod_from_edge-dnaMotor_mount_T),(calZ_drive_rod_L-calRod_part_T)/2-dnaRod_R*2])rotate([-90,180,0])
	mX_motor_mount_clamp();
	mZ_axis_support_no_motor();
	translate([calZ_drive_rod_spacing,0,0])rotate([0,0,180])mZ_axis_support_motor();
	translate([0,0,(calZ_drive_rod_L-calRod_part_T)/2])
		mZ_lifter();
	translate([calZ_drive_rod_spacing/2-calY_guide_rod_spacing/2, calVertex_spacing_y/2+calY_support_to_lower_support_y, calY_support_to_lower_support_z])
			rotate([-90,0,0])
				mClamp(dnaRod_R,dnaGuide_rod_R);
	
	//end testing******
}

module mX_motor_mount(){
translate([0,0,dnaMotor_mount_T/2])
	difference(){
		union(){
			cube([dnaMotor_w,dnaMotor_w,dnaMotor_mount_T],center =true);
			translate([dnaMotor_w/2+(calRod_part_T+2*dnaGuide_rod_R+dnaRod_R)/2,(dnaMotor_w+calRod_part_T)/4-calRod_part_T/2,0])
				cube([calRod_part_T+2*dnaGuide_rod_R+dnaRod_R,(dnaMotor_w+calRod_part_T)/2,dnaMotor_mount_T],center =true);
		}
		mMotor_holes(0,30);
		translate([0,dnaGuide_rod_R+dnaRod_R,dnaMotor_mount_T/2-calMin_rod_from_edge])rotate([0,90,0])
			mHole_horiz(dnaGuide_rod_R,200);
		translate([dnaMotor_w/2+(calRod_part_T/2+2*dnaGuide_rod_R+dnaRod_R),0,dnaMotor_mount_T/2-calMin_rod_from_edge])
			mHole_horiz(dnaRod_R,200);
		translate([dnaMotor_w/2+(calRod_part_T/2+2*dnaGuide_rod_R+dnaRod_R),2*dnaGuide_rod_R+dnaRod_R+dnaScrew_R,dnaMotor_mount_T/2-calMin_rod_from_edge])
			mHole_horiz(dnaScrew_R,200);
		translate([dnaMotor_w/2+calMin_screw_from_edge,2*dnaGuide_rod_R+dnaRod_R+dnaScrew_R,dnaMotor_mount_T/2-calMin_rod_from_edge])
			mHole_horiz(dnaScrew_R,200);
	}
}

module mX_motor_mount_clamp(){
mirror([0,0,1])
translate([0,0,dnaMotor_mount_T/2])
	difference(){
		translate([dnaMotor_w/2+(calRod_part_T+2*dnaGuide_rod_R+dnaRod_R)/2,(dnaMotor_w+calRod_part_T)/4-calRod_part_T/2,0])
			cube([calRod_part_T+2*dnaGuide_rod_R+dnaRod_R,(dnaMotor_w+calRod_part_T)/2,dnaMotor_mount_T],center =true);
		translate([0,dnaGuide_rod_R+dnaRod_R,dnaMotor_mount_T/2-calMin_rod_from_edge])rotate([0,90,0])
			mHole_horiz(dnaGuide_rod_R,200);
		translate([dnaMotor_w/2+(calRod_part_T/2+2*dnaGuide_rod_R+dnaRod_R),0,dnaMotor_mount_T/2-calMin_rod_from_edge])
			mHole_horiz(dnaRod_R,200);
		translate([dnaMotor_w/2+(calRod_part_T/2+2*dnaGuide_rod_R+dnaRod_R),2*dnaGuide_rod_R+dnaRod_R+dnaScrew_R,dnaMotor_mount_T/2-calMin_rod_from_edge])
			mHole_horiz(dnaScrew_R,200);
		translate([dnaMotor_w/2+calMin_screw_from_edge,2*dnaGuide_rod_R+dnaRod_R+dnaScrew_R,dnaMotor_mount_T/2-calMin_rod_from_edge])
			mHole_horiz(dnaScrew_R,200);
		translate([0,0,-dnaMotor_mount_T+1])
			cube([100,100,dnaMotor_mount_T],center =true);
	}
}

module mY_motor_mount(){
	difference(){
		union(){
			cube([dnaMotor_w,dnaMotor_w,dnaMotor_mount_T],center =true);
			translate([-dnaMotor_w/2+dnaIdler_pulley_R,dnaMotor_w/2+dnaRod_R,0]){
				translate([calVertex_L_to_center,0,0])rotate([0,0,120])
				intersection(){
					difference(){
						//polygon body
						translate([calVertex_poly_size-calVertex_W/(2*cos(30)),0,0])rotate([0,0,0])
							mPolygon(6,calVertex_poly_size,dnaMotor_mount_T);
						//polygon cut
						translate([calVertex_poly_size+2+calVertex_W/(2*cos(30)),0,0])rotate([0,0,0])
							mPolygon(6,calVertex_poly_size+2,100);
					}
					//polygon filler
					rotate([0,0,30])rotate([0,0,0])mPolygon(6,(calVertex_L_to_center+calRod_part_T/2)/cos(30),100);
				}
			}

		}
		mMotor_holes(0,30);
		translate([-dnaMotor_w/2+dnaIdler_pulley_R,dnaMotor_w/2+dnaRod_R,0]){
			cylinder(r=dnaRod_R,h=30,center=true);
			translate([calY_support_to_lower_support_z,calY_support_to_lower_support_y,0])
				cylinder(r=dnaRod_R,h=30,center=true);
		}

	}
}

module mEnd_stop_clamp(){
	difference() {
		union() {
			cube([calGuide_rod_part_T,dnaEndstop_mount_spacing+calEndstop_mount_T,calEndstop_mount_T],center=true);
			//translate([0, 0,calEndstop_mount_T]) 
			//	cylinder(r = calGuide_rod_part_T/2, h = calEndstop_mount_T, center= true);
		}
		union() {
			mHole_vert(dnaRod_R,100);
			translate([0, -dnaEndstop_mount_spacing/2, 0]) 
				rotate([0,-90,0])mHole_horiz(dnaEndstop_screw_R,100);
			translate([0, dnaEndstop_mount_spacing/2, 0]) 
				rotate([0,-90,0])mHole_horiz(dnaEndstop_screw_R,100);
			translate([0, (dnaEndstop_mount_spacing+calEndstop_mount_T)/2, 0]) 
				cube([(2*dnaRod_R), dnaEndstop_mount_spacing+calEndstop_mount_T,dnaEndstop_mount_spacing+calEndstop_mount_T], center = true);
		}
	}


}


module mZ_guide_clamp(){
	if(dnaVertex_type == 1){
		difference(){
			cube([calGuide_rod_part_T-3,(2*(dnaGuide_rod_R+dnaScrew_R)+calScrew_part_T)+dnaScrew_R*6,calScrew_part_T],center=true);
			mZ_guide_clamp_cuts();
		}
	}
	if(dnaVertex_type != 1){
		difference(){
			cube([calGuide_rod_part_T-3,2*(dnaGuide_rod_R+dnaScrew_R)+calScrew_part_T,calScrew_part_T],center=true);
			mZ_guide_clamp_cuts();
		}
	}
}

module mZ_guide_clamp_cuts(){
	color([ 200/255, 0/255, 0/255, 1]){
		if(dnaVertex_type == 1){
			union(){
				for(i=[-3*dnaScrew_R-(dnaGuide_rod_R+dnaScrew_R),3*dnaScrew_R+(dnaGuide_rod_R+dnaScrew_R)]){
					translate([calGuide_rod_part_T/2-dnaGuide_rod_R,i,0])
						rotate([0,-90,0])mHole_horiz(dnaScrew_R,100);						//Screw holes
				}
				for(i=[-1.5*dnaScrew_R-(dnaGuide_rod_R+dnaScrew_R),1.5*dnaScrew_R+(dnaGuide_rod_R+dnaScrew_R)]){
					translate([calGuide_rod_part_T/2-dnaGuide_rod_R,i,0])
						cube([100,3*(dnaScrew_R),2*dnaScrew_R],center=true);	//Screw hole relief
				}
			}
		}
		union(){
			translate([calGuide_rod_part_T/2-dnaGuide_rod_R,0,0])
				rotate([0,0,0])mHole_vert(dnaGuide_rod_R,100);						//Main rod hole
			translate([calGuide_rod_part_T/2,0,0])
				rotate([0,0,0])cube([2*dnaGuide_rod_R,2*dnaGuide_rod_R,100],center=true);	//Main rod hole (extra material removal)
			for(i=[-(dnaGuide_rod_R+dnaScrew_R),dnaGuide_rod_R+dnaScrew_R]){
				translate([calGuide_rod_part_T/2-dnaGuide_rod_R,i,0])
					rotate([0,-90,0])mHole_horiz(dnaScrew_R,100);						//Screw holes
			}
			translate([calRod_part_T/2,0,0])
				rotate([0,0,0])cube([4*dnaGuide_rod_R,2*(dnaGuide_rod_R+dnaScrew_R),2*dnaScrew_R],center=true);	//Screw hole relief
		}
	}
}

module mThick_sheet_side(){
	difference(){
		color([ 183/255, 128/255, 11/255, 1])	
		translate([(calZ_drive_rod_spacing-calVertex_spacing_x)/2,0,(calThick_sheet_side_H-calRod_part_T)/2]){
			difference(){
				cube([calVertex_T,calThick_sheet_side_W,calThick_sheet_side_H],center = true);
				translate([0,0,calVertex_W/2])
					cube([2*calVertex_T,calX_support_rod_L+2,calThick_sheet_side_H-calY_support_to_lower_support_z-calVertex_W],center=true);
				translate([0,0,-(calThick_sheet_side_H/2-calVertex_W/2)-1])
					cube([2*calVertex_T,2*(dnaZ_drive_pulley_R+dnaBelt_T),calVertex_W],center=true);
			}
		}
		mThick_sheet_side_cuts();
	}
}

module mThick_sheet_side_cuts(){
	color([ 200/255, 0/255, 0/255, 1]){
		translate([0,calVertex_spacing_y/2,0])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0,-calVertex_spacing_y/2,0])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0, calVertex_spacing_y/2+calY_support_to_lower_support_y, calY_support_to_lower_support_z])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0, -calVertex_spacing_y/2-calY_support_to_lower_support_y, calY_support_to_lower_support_z])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0, calFrame_top_spacing/2, calY_support_to_lower_support_z+calY_support_to_upper_support_z])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0, -calFrame_top_spacing/2, calY_support_to_lower_support_z+calY_support_to_upper_support_z])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0, -calZ_drive_rod_to_support_rod_spacing, 0])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0, calZ_drive_rod_to_support_rod_spacing, 0])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);
		translate([0,(calRod_part_T+dnaMotor_w+dnaZ_motor_adjust_L)/2+(calZ_drive_rod_to_motor_spacing_y+dnaZ_motor_adjust_L/2), 0])
			rotate([0,90,0])mHole_vert(dnaRod_R,100);


	}
}

module mUpper_vertex(){
	difference(){
		union(){
			//cross member
			cube([calVertex_T,calFrame_top_spacing+calRod_part_T,calVertex_W],center =true);
			intersection(){
				//lower filler
				translate([0,0,-calVertex_middle_W*cos(30)/2])
					cube([calVertex_T,calFrame_top_spacing+2*dnaRod_R,calRod_part_T+calVertex_middle_W*cos(30)],center =true);
				//polygon body
				translate([0,0,calVertex_poly_size-calVertex_W/(2*cos(30))-calVertex_offset_to_center])rotate([0,90,0])
					mPolygon(6,calVertex_poly_size,calVertex_T);
			}
		}
		//polygon cut
		translate([0,0,calVertex_poly_size+2+calVertex_W/(2*cos(30))-calVertex_offset_to_center])rotate([0,90,0])
			mPolygon(6,calVertex_poly_size+2,100);
		//holes
		mUpper_vertex_cuts();
	}
}

module mUpper_vertex_cuts(){
	color([ 200/255, 0/255, 0/255, 1]){
		translate([0,calFrame_top_spacing/2,0])rotate([0,90,0])
			mHole_vert(dnaRod_R,100);
		translate([0,-calFrame_top_spacing/2,0])rotate([0,90,0])
			mHole_vert(dnaRod_R,100);
		translate([0,-(calY_support_to_lower_support_min/2-dnaRod_R*2*sin(60)),-dnaRod_R*2*cos(60)])rotate([90+60,0,0])
			mHole_horiz(dnaRod_R,100);
		translate([0,(calY_support_to_lower_support_min/2-dnaRod_R*2*sin(60)),-dnaRod_R*2*cos(60)])rotate([90-60,0,0])
			mHole_horiz(dnaRod_R,100);
		for(i=[-(dnaGuide_rod_R+dnaScrew_R),dnaGuide_rod_R+dnaScrew_R]){
			translate([calRod_part_T/2-dnaGuide_rod_R,i,-calVertex_W/2])
				rotate([0,-90,0])mHole_vert(dnaScrew_R,100);
		}
		translate([-dnaRod_R-dnaGuide_rod_R,0,0])rotate([0,0,0])
			mHole_vert(dnaGuide_rod_R,100);
	}
}


module mLower_vertex(){
	difference(){
		union(){
			translate([0,0,calVertex_L_to_center])rotate([-120,0,0]){
				intersection(){
					difference(){
						//polygon body
						translate([0,0,calVertex_poly_size-calVertex_W/(2*cos(30))])rotate([0,90,0])
							mPolygon(6,calVertex_poly_size,calVertex_T);
						//polygon cut
						translate([0,0,calVertex_poly_size+2+calVertex_W/(2*cos(30))])rotate([0,90,0])
							mPolygon(6,calVertex_poly_size+2,100);
					}
				//polygon filler
				rotate([30,0,0])rotate([0,90,0])mPolygon(6,(calVertex_L_to_center+calRod_part_T/2)/cos(30),100);
				}
			}
			//foot
			translate([0,0,-dnaVertex_foot_H])
				cube([calVertex_T,calVertex_W,dnaVertex_foot_H],center = true);
		}
	//holes		
	mLower_vertex_cuts();	
	}
}

module mLower_vertex_cuts(){
	color([ 200/255, 0/255, 0/255, 1]){
		translate([0,0,0])rotate([0,90,0])
			mHole_vert(dnaRod_R,100);
		translate([0,calY_support_to_lower_support_y,calY_support_to_lower_support_z])rotate([0,90,0])
			mHole_vert(dnaRod_R,100);
		translate([0,0,dnaRod_R*2])rotate([90,0,0])
			mHole_horiz(dnaRod_R,100);
		translate([0,(calY_support_to_lower_support_y-dnaRod_R*2*sin(60)),(calY_support_to_lower_support_z-dnaRod_R*2*cos(60))])rotate([90-60,0,0])
			mHole_horiz(dnaRod_R,100);
	}
}

module mClamp(vThread_rod_R, vClamped_rod_R){
	difference() {
		union() {
			translate([0,vClamped_rod_R*2,0])
				cylinder(r = vClamped_rod_R+dnaMin_around_hole, h = 2*(vThread_rod_R+dnaMin_around_hole), center= true);
			translate([0,-(vThread_rod_R+dnaMin_around_hole)/2,0])	
				cube([2*(vClamped_rod_R+dnaMin_around_hole),(vThread_rod_R+dnaMin_around_hole),2*(vThread_rod_R+dnaMin_around_hole)], center= true);
			rotate([0,90,0])
				cylinder(r = vThread_rod_R+dnaMin_around_hole, h = 2*(vClamped_rod_R+dnaMin_around_hole), center= true);
		}
		union() {
			color([ 200/255, 0/255, 0/255, 1])
				translate([0,vClamped_rod_R*2,0])
					mHole_vert(vClamped_rod_R,100);
			color([ 0/255,200/255, 0/255, 1])
				rotate([0,-90,0])
					mHole_horiz(vThread_rod_R,100);
			translate([0, -vClamped_rod_R, 0]) 
				cube([( vClamped_rod_R+dnaMin_around_hole)*sin(45), vThread_rod_R*5, vThread_rod_R*5], center = true);
		}
	}
}

module mZ_lifter(){
	difference(){
		cube([dnaZ_drive_rod_nut_W/sin(60),calX_guide_rod_spacing+dnaGuide_rod_R*2,dnaGuide_rod_R*2+dnaMin_around_hole*2], center = true);
		//nut cut
		cube([100,dnaZ_drive_rod_nut_W,dnaZ_drive_rod_nut_T], center = true);
		mHole_horiz(dnaZ_drive_rod_R+0.5,100);
		//rear cut
		translate([0,calX_guide_rod_spacing/2,0]){
			translate([0,dnaGuide_rod_R,0])
				cube([100,dnaGuide_rod_R*2,dnaGuide_rod_R*2], center = true);
			rotate([0,90,0])
				cylinder(r=dnaGuide_rod_R, h = 100, center = true);
		}
		//front cut
		mirror([0,1,0])
		translate([0,calX_guide_rod_spacing/2,0]){
			translate([0,dnaGuide_rod_R,0])
				cube([100,dnaGuide_rod_R*2,dnaGuide_rod_R*2], center = true);
			rotate([0,90,0])
				cylinder(r=dnaGuide_rod_R, h = 100, center = true);
		}
	}
}

module mZ_axis_support_motor(){
	mZ_axis_support(true);
}

module mZ_axis_support_no_motor(){
	union(){
		mZ_axis_support(false);
		mirror([0,1,0])mZ_axis_support(false);
	}
}

module mZ_axis_support(vMotor_side){
	translate([0,0,calRod_part_T/2+2*dnaRod_R]){
		difference(){
			union(){
				translate([-((calZ_drive_rod_to_guide_rod_spacing-dnaGuide_rod_R)-calVertex_T),-(calZ_drive_rod_to_motor_spacing_y-dnaMotor_w/2),-dnaZ_drive_plate_T]){
					cube([calZ_drive_support_x,calZ_drive_support_y,dnaZ_drive_plate_T]);
					translate([0,calZ_drive_support_y-calRod_part_T,-(calRod_part_T+2*dnaRod_R)+calMin_rod_from_edge-calRod_part_T/2+dnaZ_drive_plate_T]){
						cube([calZ_drive_support_x,calRod_part_T,calRod_part_T]);
					}
				}
				if(vMotor_side){
					translate([calZ_drive_rod_to_motor_spacing_x,-(calZ_drive_rod_to_motor_spacing_y+dnaZ_motor_adjust_L/2+calRod_part_T/2),-dnaZ_motor_mount_T/2]){
						cube([dnaMotor_w,dnaMotor_w+dnaZ_motor_adjust_L+calRod_part_T,dnaZ_motor_mount_T],center = true);
						translate([0,-(dnaMotor_w+dnaZ_motor_adjust_L)/2,-(calRod_part_T+2*dnaRod_R)+calMin_rod_from_edge+dnaZ_motor_mount_T/2]){
							cube([dnaMotor_w,calRod_part_T,calRod_part_T],center = true);
						}
						translate([(dnaMotor_w+calRod_part_T)/2,(dnaMotor_w+dnaZ_motor_adjust_L-calRod_part_T)/2,0]){
							cube([calRod_part_T,calRod_part_T,dnaZ_motor_mount_T],center = true);
							%translate([0,0,-(dnaZ_motor_mount_T+dnaBelt_W)/2])mIdler_pulley();
						}
					}
				}
			}
			union(){
				translate([-((calZ_drive_rod_to_guide_rod_spacing-dnaGuide_rod_R)-calVertex_T)/2,-(calZ_drive_rod_to_motor_spacing_y-dnaMotor_w/2)-0.01,-dnaZ_drive_plate_T-0.01]){
					cube([calZ_drive_support_x/2,calZ_drive_support_y+0.02,dnaZ_drive_plate_T/2+0.01]);
				}
				translate([0,0,-calZ_drive_support_z])rotate([180,0,0])
					mDrive_bearing(4*calZ_drive_support_z);
				translate([0,calZ_drive_support_y-calRod_part_T/2-(calZ_drive_rod_to_motor_spacing_y-dnaMotor_w/2),-(calRod_part_T+2*dnaRod_R)+calMin_rod_from_edge]){
					rotate([0,90,0])mRod(2*calZ_drive_support_y);
				}
				if(vMotor_side){
					translate([calZ_drive_rod_to_motor_spacing_x,-(calZ_drive_rod_to_motor_spacing_y+dnaZ_motor_adjust_L/2+calRod_part_T/2),-dnaZ_motor_mount_T/2]){
						translate([0,calRod_part_T/2,0])rotate([0,0,90])mMotor_holes(dnaZ_motor_adjust_L,2*dnaZ_motor_mount_T);
						translate([0,0,-dnaZ_motor_mount_T/4-0.01])
							cube([dnaMotor_hub_R*2,dnaMotor_w+dnaZ_motor_adjust_L+calRod_part_T+0.02,dnaZ_motor_mount_T/2],center=true);
						translate([0,-(dnaMotor_w+dnaZ_motor_adjust_L)/2,-(calRod_part_T+2*dnaRod_R)+calMin_rod_from_edge+dnaZ_motor_mount_T/2]){
							rotate([0,90,0])mRod(2*calZ_drive_support_y);
						}
						translate([(dnaMotor_w+calRod_part_T)/2,(dnaMotor_w+dnaZ_motor_adjust_L-calRod_part_T)/2,0]){
							mRod(2*calZ_drive_support_y);
						}
					}
				}
			}
		}
	}
}