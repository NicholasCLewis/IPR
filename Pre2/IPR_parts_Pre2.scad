/*  IPR_func_Pre2.inc
 *  Pre-Release 2
 *  Miscellaneous standard objects used in IPR (Integrated Parametric RepRap)
 *  Experimental file for a new simple version of Mendel/Huxley
 *  By Nicholas C Lewis 2010
 *
 *  http://www.thingiverse.com/thing:4912
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

include <IPR_DNA_Pre2.inc>
use <IPR_func_Pre2.scad>

calVertex_cut = ((calDelta_size-calDelta_rod_L)/2+dnaRod_nut_T)/cos(30);

//testing******
//mBOM();
mFrame();
translate([(calZ_drive_rod_spacing-calVertex_spacing_x)/2,0,calY_support_to_lower_support_z+calY_support_to_upper_support_z])
mUpper_vertex();
translate([(calZ_drive_rod_spacing-calVertex_spacing_x)/2,calVertex_spacing_y/2,0])
mLower_vertex();
mZ_axis_support_motor();
translate([calZ_drive_rod_spacing,0,0])mZ_axis_support_no_motor();
translate([0,0,(calZ_drive_rod_L-calRod_part_T)/2])
	mZ_lifter();
translate([calZ_drive_rod_spacing/2-calY_guide_rod_spacing/2, calVertex_spacing_y/2+calY_support_to_lower_support_y, calY_support_to_lower_support_z])
		rotate([-90,0,0])
			mClamp(dnaRod_R,dnaGuide_rod_R);


//end testing******

module mUpper_vertex(){
	difference(){
		union(){
			cube([calRod_part_T,calFrame_top_spacing+calRod_part_T,calVertex_W],center =true);
			intersection(){
				translate([0,0,-calVertex_middle_W*cos(30)/2])
					cube([calRod_part_T,calFrame_top_spacing+2*dnaRod_R,calRod_part_T+calVertex_middle_W*cos(30)],center =true);
				translate([0,0,(calVertex_W/2)/cos(30)+calVertex_cut/2])rotate([0,90,0])
					mPolygon(6,calVertex_cut+calVertex_middle_W,100);
			}
		}
		translate([0,0,(calVertex_W/2)/cos(30)+calVertex_cut/2])rotate([0,90,0])
			mPolygon(6,calVertex_cut,100);
	}
}

module mLower_vertex(){
	union(){
		cube([calRod_part_T,calVertex_W,calRod_part_T],center =true);
		translate([0,0,calVertex_outer_L/2+dnaRod_R])	
			cube([calRod_part_T,calVertex_W,calVertex_outer_L],center =true);
		translate([0,0,-calRod_part_T])	
			cube([calRod_part_T,calVertex_W,calRod_part_T],center =true);
		translate([0,calY_support_to_lower_support_y,calY_support_to_lower_support_z])
			rotate([120,0,0]){
			cube([calRod_part_T,calVertex_W,calRod_part_T],center =true);
			translate([0,0,calVertex_outer_L/2+dnaRod_R])	
				cube([calRod_part_T,calVertex_W,calVertex_outer_L],center =true);
		}
		translate([0,calVertex_middle_L/2*sin(30),calVertex_middle_L/2*cos(30)+calVertex_outer_L+dnaRod_R-calVertex_middle_W/2*sin(30)])	
			rotate([-30,0,0])
				cube([calRod_part_T,calVertex_middle_W,calVertex_middle_L],center =true);
	}
	
}

module mClamp(vThread_rod_R, vClamped_rod_R){
	difference() {
		union() {
			translate([0,vClamped_rod_R*2,0])
				cylinder(r = vClamped_rod_R*2, h = vThread_rod_R*4, center= true);
			translate([0,0,-vThread_rod_R])			
				cube([vClamped_rod_R*4,vThread_rod_R*4,vThread_rod_R*2], center = true);
			rotate([0,90,0])
				cylinder(r = vThread_rod_R*2, h = vClamped_rod_R*4, center= true);
		}
		union() {
			color([ 200/255, 0/255, 0/255, 1])
				translate([0,vClamped_rod_R*2,0])
					mHole_vert(vClamped_rod_R,100);
			color([ 0/255,200/255, 0/255, 1])
				rotate([0,90,0])
					mHole_vert(vThread_rod_R,100);
			translate([0, -vClamped_rod_R, 0]) 
				cube([vClamped_rod_R*2*sin(45), vThread_rod_R*5, vThread_rod_R*5], center = true);
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
		mirror([1,0,0]){
			mZ_axis_support(false);
			if(dnaVertex_type==1){
				mirror([0,1,0])mZ_axis_support(false);
			}
		}
	}
}

module mZ_axis_support(vMotor_side){
	translate([0,0,calRod_part_T/2+2*dnaRod_R]){
		difference(){
			union(){
				translate([-((calZ_drive_rod_to_guide_rod_spacing-dnaGuide_rod_R)-calVertex_T),-(calZ_drive_rod_to_motor_spacing_y-dnaMotor_w/2),-calZ_drive_support_z]){
					cube([calZ_drive_support_x,calZ_drive_support_y,calZ_drive_support_z]);
					if(dnaVertex_type==0){
						union(){
							translate([-calVertex_T,calZ_drive_support_y-calRod_part_T,calZ_drive_support_z-(calRod_part_T+2*dnaRod_R)]){
								cube([calVertex_T+calZ_drive_support_x,calRod_part_T,calRod_part_T+2*dnaRod_R]);
							}
							translate([-calVertex_T,0,-calRod_part_T+calZ_drive_support_z]){
								cube([calVertex_T,calZ_drive_support_y,calRod_part_T]);
							}
						}
					}
					if(dnaVertex_type==1){
						translate([0,calZ_drive_support_y-calRod_part_T,calZ_drive_support_z-(calRod_part_T)]){
							cube([calZ_drive_support_x,calRod_part_T,calRod_part_T]);
						}
					}
				}
				if(vMotor_side){
					translate([calZ_drive_rod_to_motor_spacing_x,-(calZ_drive_rod_to_motor_spacing_y+dnaZ_motor_adjust_L/2),-dnaMotor_mount_T/2]){
						difference(){
							cube([dnaMotor_w,dnaMotor_w+dnaZ_motor_adjust_L,dnaMotor_mount_T],center = true);
							rotate([0,0,90])mMotor_holes(dnaZ_motor_adjust_L,2*dnaMotor_mount_T);
						}
						if(dnaVertex_type==0){
							translate([-dnaMotor_w/2-calVertex_T/2,0,-calRod_part_T/2+dnaMotor_mount_T/2]){
								cube([calVertex_T,dnaMotor_w+dnaZ_motor_adjust_L,calRod_part_T],center = true);
							}
						}
						if(dnaVertex_type==1){
							translate([0,-(calRod_part_T+dnaMotor_w+dnaZ_motor_adjust_L)/2,-calRod_part_T/2+dnaMotor_mount_T/2]){
								cube([dnaMotor_w,calRod_part_T,calRod_part_T],center = true);
							}
						}
					}
				}
			}
			union(){
				mDrive_bearing(4*calZ_drive_support_z);
				translate([-((calZ_drive_rod_to_guide_rod_spacing-dnaGuide_rod_R)-calVertex_T),-(calZ_drive_rod_to_motor_spacing_y-dnaMotor_w/2),-calZ_drive_support_z]){
					if(dnaVertex_type==0){
						union(){
							translate([-calVertex_T,calZ_drive_support_y-calRod_part_T/2,calZ_drive_support_z-(calRod_part_T+2*dnaRod_R)+calMin_rod_from_edge]){
								rotate([0,90,0])mRod(2*(calVertex_T+calZ_drive_support_x));
							}
							translate([-calVertex_T+calMin_rod_from_edge,0,-calRod_part_T+calZ_drive_support_z+calMin_rod_from_edge]){
								rotate([90,0,0])mRod(2*(calZ_drive_support_y+dnaMotor_w+dnaZ_motor_adjust_L));
							}
						}
					}
					if(dnaVertex_type==1){
						translate([0,calZ_drive_support_y-calRod_part_T+calRod_part_T/2,calZ_drive_support_z-(calRod_part_T)+calMin_rod_from_edge]){
							rotate([0,90,0])mRod(2*calZ_drive_support_y);
						}
					}
				}
				if(vMotor_side){
					translate([calZ_drive_rod_to_motor_spacing_x,-(calZ_drive_rod_to_motor_spacing_y+dnaZ_motor_adjust_L/2),-dnaMotor_mount_T/2]){
						if(dnaVertex_type==1){
							translate([0,-(calRod_part_T+dnaMotor_w+dnaZ_motor_adjust_L)/2,-calRod_part_T/2+dnaMotor_mount_T/2]){
								rotate([0,90,0])mRod(2*calZ_drive_support_y);
							}
						}
					}
				}
			}
		}
	}
}