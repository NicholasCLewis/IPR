/*  IPR_func.inc
 *  Miscellaneous standard objects used in IPR (Integrated Parametric RepRap)
 *  Experimental file for a new simple version of Mendel/Huxley
 *  By Nicholas C Lewis 2010
 *
 *  http://www.thingiverse.com/thing:4960
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

include <IPR_DNA_PRE_1.inc>

//testing******
mBOM();
mFrame();
*mMotor();
*for(i=[-dnaMotor_mount_spacing/2,dnaMotor_mount_spacing/2],j=[-dnaMotor_mount_spacing/2,dnaMotor_mount_spacing/2]){
			translate([i,j,-10])
			rotate([180,0,0])
			mScrew(dnaMotor_screw_R,dnaMotor_screw_head_R,dnaMotor_screw_head_H,20);
		}
*difference(){
	translate([0,0,-5])
	cube([100,100,10],center = true);
	mMotor_holes(10,50);
}
//end testing******

module mPolygon(vSides,vSideL,vLength) {
	cylinder(r=vSideL/(2*cos((vSides-2)*180/vSides/2)),h=vLength,$fn=vSides, center =true);
}

module mHexagon(vWidth, vDepth) {
	mPolygon(6,vWidth*tan(30),vDepth);
}

module mHole_horiz(vRadius,vLength) {
	cylinder(r = vRadius, h = vLength,center=true);
	if(gbl_use_teardrop){
		translate ([vRadius*sin(45),0,0]) rotate ([0,0,45])
			cube([vRadius,vRadius,vLength],center=true);
	}
}

module mHole_vert(vRadius,vLength) {
	cylinder(r = vRadius, h = vLength,center=true);
}

// For nut cavities, "height" is the max distance between two flats on the hex.
module mNut_cavity(vWidth,vLength) {
	mHexagon(vWidth=vWidth,vDepth=vLength);
}

module mHole_vert_with_hex(vRadius,vWidth,vLength) {
	union () {
		mHole_vert(vRadius,vLength);
		translate ([0,0,-vLength/4]) rotate ([0,0,30]) scale ([1.1,1.1,1]) mNut_cavity(vWidth,vLength/2);
	}
}

module mHole_horiz_with_hex(vRadius,vWidth,vLength) {
	union () {
		mHole_horiz(vRadius,vLength);
		translate ([0,0,-vLength/4]) rotate ([0,0,0]) mNut_cavity(vWidth,vLength/2);
	}
}


//Hardware

module mGuide_rod(vLength){
	color([ 0/255, 127/255, 0/255, 1])
	cylinder(r=dnaGuide_rod_R,h=vLength,center=true);
}

module mRod(vLength){
	color([ 127/255, 127/255, 127/255, 1])
	cylinder(r=dnaRod_R,h=vLength,center=true);
}

module mZ_drive_rod(vLength){
	color([ 127/255, 0/255, 0/255, 1]){
		cylinder(r=dnaZ_drive_rod_R,h=vLength,center=true);
		mNut_cavity(dnaZ_drive_rod_nut_W,dnaZ_drive_rod_nut_T);
	}
}

module mAxis_bearing(){
	color([ 0/255, 167/255, 0/255, 1])
	difference(){
		cylinder(r=dnaAxis_bearing_OR,h=dnaAxis_bearing_W,center=true);
		cylinder(r=dnaAxis_bearing_IR,h=dnaAxis_bearing_W+2,center=true);
	}
}

module mScrew(vShaftR,vHeadR,vHeadH,vLength){
	color([ 167/255, 167/255, 0/255, 1])
	union(){
		translate([0,0,-vLength/2])
		cylinder(r=vShaftR,h=vLength,center=true);
		translate([0,0,vHeadH/2])
		cylinder(r=vHeadR,h=vHeadH,center=true);
	}
}

// Drive bearing with supports
module mDrive_bearing(vHeight){
	union(){
		cylinder(h=vHeight,r=dnaZ_drive_bearing_OR,center=true);
		// Bearing supports
		for(i=[0,120,240]){
			rotate ([0,0,i]){
				translate ([dnaZ_drive_bearing_OR+dnaScrew_R,0,0])
					 mHole_vert(dnaScrew_R,vHeight);
				translate ([dnaZ_drive_bearing_OR+dnaScrew_R-2,0,0])
					cube([2*dnaScrew_R,1.5*dnaScrew_R,vHeight], center=true);
			}
		}
	}
}

// motors
module mMotor(){
	difference(){
		union(){
			color([ 67/255, 67/255, 67/255, 1]){
				translate([0,0,dnaMotor_h/2])
					cube([dnaMotor_w,dnaMotor_w,dnaMotor_h],center = true);
				cylinder(r=dnaMotor_hub_R, h=dnaMotor_hub_H*2,center=true);
			}
			color([ 127/255, 127/255, 127/255, 1]){
				cylinder(r=dnaMotor_shaft_R, h=dnaMotor_shaft_L*2,center=true);
			}
			color([ 255/255, 255/255, 255/255, 1]){
				translate([0,dnaMotor_w/2,dnaMotor_h-4])rotate([90,0,0])
				cube([8,6,6],center=true);
			}			
		}//	dnaMotor_screw_R	dnaMotor_screw_H
		for(i=[-dnaMotor_mount_spacing/2,dnaMotor_mount_spacing/2],j=[-dnaMotor_mount_spacing/2,dnaMotor_mount_spacing/2]){
			translate([i,j])
			cylinder(r=dnaMotor_screw_R, h=10,center=true);
		}
	}
}

module mMotor_holes(vLength, vHeight){
	color([ 167/255, 0/255, 167/255, 1]){
		union(){
			cube([vLength, dnaMotor_hub_R*2, vHeight],center=true);
			for(i=[-vLength/2,vLength/2]){
				translate([i,0])
					mHole_vert(dnaMotor_hub_R, vHeight);
			}			
			for(i=[-dnaMotor_mount_spacing/2,dnaMotor_mount_spacing/2],j=[-dnaMotor_mount_spacing/2,dnaMotor_mount_spacing/2],k=[-vLength/2,vLength/2]){
				translate([i+k,j,0])
				mHole_vert(dnaMotor_screw_R, vHeight);
				translate([i,j,0])
				cube([vLength, dnaMotor_screw_R*2, vHeight],center=true);
			}
		}
	}
}

module mFrame(){
echo(calX_guide_rod_spacing);
//z drive rods
	translate([0,0,calZ_guide_rod_L/2])
		mZ_drive_rod(calZ_guide_rod_L);
	translate([calZ_drive_rod_spacing,0,calZ_guide_rod_L/2])
		mZ_drive_rod(calZ_guide_rod_L);
//z guides
	for(i=[-calZ_drive_rod_to_guide_rod_spacing,calZ_drive_rod_spacing+calZ_drive_rod_to_guide_rod_spacing]){	
		translate([i,0,calZ_guide_rod_L/2])
			mGuide_rod(calZ_guide_rod_L);
	}
//y supports (run in x direction)
	translate([calZ_drive_rod_spacing/2,calVertex_spacing/2,0])
		rotate([0,90,0])mRod(calY_support_L);
	translate([calZ_drive_rod_spacing/2,-calVertex_spacing/2,0])
		rotate([0,90,0])mRod(calY_support_L);
	translate([calZ_drive_rod_spacing/2,calVertex_spacing/2+calY_support_to_lower_support_y,calY_support_to_lower_support_z])
		rotate([0,90,0])mRod(calY_support_L);
	translate([calZ_drive_rod_spacing/2,-calVertex_spacing/2-calY_support_to_lower_support_y,calY_support_to_lower_support_z])
		rotate([0,90,0])mRod(calY_support_L);
	translate([calZ_drive_rod_spacing/2,calFrame_top_spacing/2,calY_support_to_lower_support_z+calY_support_to_upper_support_z])
		rotate([0,90,0])mRod(calY_support_L);
	translate([calZ_drive_rod_spacing/2,-calFrame_top_spacing/2,calY_support_to_lower_support_z+calY_support_to_upper_support_z])
		rotate([0,90,0])mRod(calY_support_L);
//y guides
	for(i=[-calY_guide_rod_spacing/2,calY_guide_rod_spacing/2]){
		translate([i+calZ_drive_rod_spacing/2,0,calY_support_to_lower_support_z-dnaRod_R*2])
			rotate([0,90,90])mGuide_rod(calY_guide_rod_L);
	}
//x guides	
	for(i=[-calX_guide_rod_spacing/2,calX_guide_rod_spacing/2]){
		translate([calZ_drive_rod_spacing/2,i,calZ_guide_rod_L/2])
			rotate([90,0,90])mGuide_rod(calX_guide_rod_L);
	}
	for(i=[-calZ_drive_rod_to_guide_rod_spacing+calRod_part_T,calZ_drive_rod_spacing+calZ_drive_rod_to_guide_rod_spacing-calRod_part_T]){
		translate([i,0,calZ_guide_rod_L/2+dnaRod_R*2])
			rotate([0,90,90])mRod(calX_support_rod_L);
	}

//frame
for(i=[-calVertex_T/2-dnaZ_drive_bearing_OR,calZ_drive_rod_spacing+calVertex_T/2+dnaZ_drive_bearing_OR]){
	translate([i,0,dnaRod_R*2])
		rotate([0,90,90])mRod(calDelta_size);
	translate([i,0,calDelta_size/2*tan(30)+dnaRod_R*2])
		rotate([60,0,0])
			translate([0,0,calDelta_size/2*tan(30)])
				rotate([0,90,90])mRod(calDelta_size);
	translate([i,0,calDelta_size/2*tan(30)+dnaRod_R*2])
		rotate([-60,0,0])
			translate([0,0,calDelta_size/2*tan(30)])
				rotate([0,90,90])mRod(calDelta_size);
}
// build platform
translate([calZ_drive_rod_spacing/2,0,calY_support_to_lower_support_z+calY_support_to_print_bed])
	cube([dnaX_build_space+20,dnaY_build_space+20,dnaThin_sheet_T],center = true);

//zmotor
translate([(dnaMotor_w/2-dnaZ_drive_bearing_OR),-(dnaMotor_w/2+dnaZ_drive_bearing_OR),dnaRod_R*3])
	mMotor();
translate([0,0,dnaRod_R+5])
mDrive_bearing(10);
%translate([-calVertex_T/2-dnaZ_drive_bearing_OR,0,calDelta_size/2*tan(30)+dnaRod_R*2])
	rotate([0,-90,0])
		mPolygon(3,calDelta_size,calVertex_T);

}

module mBOM(){
echo("6ea",  calY_support_L, "mm L, ",dnaRod_R*2 , "mm D Threaded Rod - Frame");
echo("2ea",  calY_guide_rod_L, "mm L, ",dnaGuide_rod_R*2 , "mm D  Smooth Rod - Y-guide rod");
echo("2ea",  calX_guide_rod_L, "mm L, ",dnaGuide_rod_R*2 , "mm D Smooth Rod - X-guide rod");
echo("6ea",  calDelta_size, "mm L, ",dnaRod_R*2 , "mm D Threaded Rod - Delta Frame");
echo("2ea",  calY_guide_rod_L, "mm L, ",dnaZ_drive_rod_R*2 , "mm D Threaded Rod - Z-drive rod");
echo("2ea",  calZ_guide_rod_L, "mm L, ",dnaGuide_rod_R*2 , "mm D Smooth Rod - Z-guide rod");
}