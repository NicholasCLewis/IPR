/*  IPR_DNA.inc
 *  Miscellaneous constants used in IPR (Integrated Parametric RepRap)
 *  Experimental file for a new simple version of Mendel/Huxley
 *  By Nicholas C Lewis 2010
 *
 *  http://www.thingiverse.com/thing:
 *  http://reprap.org/wiki/Integrated_Parametric_RepRap
 *
 *  Loosly based on "mendel_misc.inc" by Vik Olliver 29-03-2010.
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

// All dimensions are in mm for inches "*25.4"
// dna*** indicates an constant that will define the "DNA" of the robot
// cal*** indicates a calculated value made up of "DNA" values.


// General settings
	dnaUse_teardrop = true;		// use teardrop holes?
	dnaVertex_type = 1;				// 0 use vertex parts or 1 use thicksheet sides

// Build Space
	dnaX_build_space = 200;			// build space in X
	dnaY_build_space = 200;			// build space in Y
	//dnaZ_build_space = 200;			// build space in Z
		
// Motor
	dnaMotor_w=43;					// Nema17 = 43
	dnaMotor_h=47;					// Nema17 = 47
	dnaMotor_hub_R=11;				// Nema17 = 11
	dnaMotor_hub_H=2;				// Nema17 = 2
	dnaMotor_shaft_R = 2.5;			// Radius of shaft - Nema17 = 2.5
	dnaMotor_shaft_L = 24;			// Radius of shaft - Nema17 = 20
	dnaMotor_mount_spacing=31;		// Nema17 = 31
	dnaMotor_screw_R = 1.9;			// Radius of shaft - m3 = 1.9
	dnaMotor_screw_head_R = 2.7;	// Radius of head - m3 = 2.7
	dnaMotor_screw_head_H = 4;		// height of head  - m3 = 4
	dnaMotor_mount_T = 5;			// thickness of mount plate
	dnaZ_motor_adjust_L = 20;			// adjustment amount for z motor
	
// Bearings
	dnaZ_drive_bearing_IR = 4;		// 608 = 4
	dnaZ_drive_bearing_OR = 11.8;	// 608 = 11.8??
	dnaZ_drive_bearing_W = 7;		// 608 = 7
	dnaAxis_bearing_IR = 2.5;			// 624 = 2
	dnaAxis_bearing_OR = 4;		// 624 = 6.5
	dnaAxis_bearing_W = 5+4;		// 624 = 5

// Fasteners
	dnaMin_around_hole = 3;			// 3mm between a hole and the edge of a part
	dnaScrew_R = 2.2;				// Radius of shaft - m4 = 2.2
	dnaScrew_head_R = 3.7;			// Radius of head - m4 = 3.7
	dnaScrew_head_H = 5;			// height of head - m4 = 5
	dnaScrew_nut_W = 6.9;			// distance between flats -> m4 = 6.9
	dnaScrew_nut_T = 3.2;			// thickness -> m4 = 3.2
	dnaRod_R = 4.5;					// Radius of shaft - m8 = 4.5
	dnaRod_nut_W = 12.8;			// distance between flats -> m8 = 12.8
	dnaRod_nut_T = 6.5;				// thickness -> m8 = 6.5 
	dnaZ_drive_rod_R = 4.5;			// Radius of shaft - m8 = 4.5
	dnaZ_drive_rod_nut_W = 12.8;	// distance between flats -> m8 = 12.8 
	dnaZ_drive_rod_nut_T = 6.5;		// thickness -> m8 = 6.5
	dnaGuide_rod_R=4.3;				// Radius of the guide rods m8 = 4.3
	dnaBed_Spring_H=10;				// compressed height of bed springs

// Thick Sheet
	dnaThin_sheet_T = 0.25*25.4;	// 1/4" plywood ~ 6mm
	dnaThick_sheet_T = 0.75*25.4;	// 3/4" plywood ~ 6mm
	
	
// Robot settings
// X carriage design
	dnaX_car_L=10;						// prefered L of the X carriage
	dnaX_guide_rod_spacing = 0;		// x-axis guide rod distance (center to center) ###REQUESTED###
	
// Extruder
	dnaExtruder_z = 60;					// Wades = 60 (max size in z direction)
	dnaExtruder_y = 75;					// Wades = 75 (max size in y direction pos or neg from filament axis)
	dnaExtruder_mount_hole_spacing=50;	// extruder mount hole spacing(center to center)

// Pulleys
	dnaMotor_pulley_R = 4.84;			// to inner surface of belt
	dnaZ_drive_pulley_R = 14;			// to inner surface of belt
	dnaBelt_W = 0.25*25.4;				// width
	dnaBelt_T = 3;						// thickness
	
// Frame
	dnaFrame_top_spacing = 100;			// 0 gives same as lower vertex spaceing
	dnaVertex_W = 0;					// 0 defaults to calRod_part_T
	
// #####IPR calculated diminsions#####
	calAxis_bearing_center_spacing = (dnaAxis_bearing_OR+dnaGuide_rod_R)*2;		// axis bearing distance(center to center)

// basic structure dimensions
	calMin_screw_from_edge = dnaScrew_R+dnaMin_around_hole;				// distance from edge of part to center of screw hole
	calMin_rod_from_edge = dnaRod_R+dnaMin_around_hole;					// distance from edge of part to center of rod hole
	calScrew_part_T = (calMin_screw_from_edge)*2;						// thickness of X & Y guide bearing parts
	calRod_part_T = (calMin_rod_from_edge)*2;							// thickness of Z guide bearing parts
	calVertex_W = max(dnaVertex_W, calRod_part_T);						// width of vertex parts (in y direction)
	
// ###Guide Bearing Calculations###
// calculate some basic dimensions related to the guide bearing parts
	calOne_eighty_mount_W = 2*(dnaAxis_bearing_IR+dnaMin_around_hole);	// vWidth of 180 degree guide bearing mount
	calThree_sixty_mount_W = 2*(dnaAxis_bearing_OR+dnaRod_R);			// vWidth of 360 degree guide bearing mount
	calGuide_bearing_from_end = dnaScrew_R+dnaAxis_bearing_OR+1;		// distance from center of adjust screw to center of bearing
// overall guide mount distances (center to center)
	calGuide_mount_hole_base_spacing = calGuide_bearing_from_end+dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*2+calOne_eighty_mount_W/3; // Guide mount distance from adjust screw to spring
	calXY_guide_mount_hole_spacing = calGuide_mount_hole_base_spacing+calScrew_part_T;	// XY guide mount distance(center to center)
	calZ_guide_mount_hole_spacing = calGuide_mount_hole_base_spacing+calRod_part_T;		// Z guide mount distance(center to center)

// ###X-axis###
// calculate the actual L of the X carriage max of requested size and minimum size (based on overall guide mount distances (center to center))
	calX_car_L=max(dnaX_car_L,(calXY_guide_mount_hole_spacing+calMin_screw_from_edge)*2); // actual L of the X carriage

	calX_guide_rod_spacing = max(dnaX_guide_rod_spacing,calAxis_bearing_center_spacing+calOne_eighty_mount_W+dnaRod_R*2);		// x-axis guide rod distance (center to center) ###ACTUAL###
	
// ###Y-axis###
// calculate distance from y-guide rod support rod to lower support rods/z-belt (center to center)
// two halves of Rod + Max of (Full guide rod and Full bearing OR Full guide rod, half bearing, half bracket, and nut)
	//calY_support_to_lower_support_z = dnaRod_R*2+max(2*(dnaGuide_rod_R+dnaAxis_bearing_OR),2*dnaGuide_rod_R+dnaAxis_bearing_OR+calOne_eighty_mount_W/2+dnaScrew_nut_T);
	//calY_support_to_lower_support_y = calY_support_to_lower_support_z*tan(30);
	calY_support_to_lower_support_z_bearing_based = 2*dnaRod_R+max(2*(dnaGuide_rod_R+dnaAxis_bearing_OR),2*dnaGuide_rod_R+dnaAxis_bearing_OR+calOne_eighty_mount_W/2+dnaScrew_nut_T);
	calY_support_to_lower_support_z_vertex_based = 2*dnaRod_R+dnaRod_nut_W/1.5+(calVertex_W/2+dnaRod_nut_T)*cos(30)+(2*dnaRod_R+dnaRod_nut_W/1.5)*sin(30);
	calY_support_to_lower_support_z = max(calY_support_to_lower_support_z_bearing_based,calY_support_to_lower_support_z_vertex_based);
	calY_support_to_lower_support_y = calY_support_to_lower_support_z*tan(30);
	calY_support_to_lower_support_min = calY_support_to_lower_support_z/cos(30);
	
	
	calY_support_to_print_bed = (-dnaRod_R-dnaGuide_rod_R)+calAxis_bearing_center_spacing/2+calOne_eighty_mount_W+dnaThin_sheet_T/2+dnaBed_Spring_H; //center of support to center of print bed
	// calculate the actual L of the Y carriage max of requested build size and minimum size (based on overall guide mount distances (center to center))
	calY_car_L = max(dnaY_build_space/2.3,(calXY_guide_mount_hole_spacing+calMin_screw_from_edge)*2); // actual L of the Y carriage
// calculate the actual L of the Y carriage guide rods
	calY_guide_rod_mount_spacing = calY_car_L+dnaY_build_space+2*dnaRod_R;  // based on overall guide mount distances (center to center)
	calY_guide_rod_L = calY_guide_rod_mount_spacing+calRod_part_T;		
	calY_guide_rod_spacing = dnaX_build_space-10;			//NEED TO ADJUST############### // y-axis guide rod distance(center to center)

// ###Vertex###
	calVertex_spacing_y = calY_guide_rod_mount_spacing-calY_support_to_lower_support_y*2;		// (center to center)
	calVertex_T = max(abs((dnaVertex_type-1)*calRod_part_T),dnaVertex_type*dnaThick_sheet_T);
	
	
// ###Z-axis###
	calZ_lifter_W = dnaZ_drive_rod_nut_W/sin(60);
// calculate distance between the z-drive rods (center to center)
	calZ_drive_rod_spacing = dnaX_build_space+calX_car_L+calZ_lifter_W;
// calculate distance between the z-drive rods and guide rods (center to center)
	calZ_drive_rod_to_guide_rod_spacing = max(dnaZ_drive_bearing_OR+1+calVertex_T+dnaGuide_rod_R, calZ_lifter_W/2+calRod_part_T);
// calculate distance between the z-drive rod and support that runs in x (center to center)
	calZ_drive_rod_to_support_rod_spacing = max(dnaZ_drive_bearing_OR+calScrew_part_T, dnaZ_drive_pulley_R+dnaBelt_T*2)+dnaRod_R;
	calZ_drive_rod_to_motor_spacing_y = max(dnaZ_drive_bearing_OR+calScrew_part_T, dnaZ_drive_pulley_R+dnaBelt_T*2)+dnaMotor_screw_head_R+dnaMotor_mount_spacing/2;
	calZ_drive_rod_to_motor_spacing_x = dnaMotor_w/2-(calZ_drive_rod_to_guide_rod_spacing-calVertex_T-dnaGuide_rod_R);
	calZ_drive_support_x = (calZ_drive_rod_to_guide_rod_spacing-dnaGuide_rod_R)-calVertex_T+dnaZ_drive_bearing_OR+calScrew_part_T/2;
	calZ_drive_support_y = (calRod_part_T/2+calZ_drive_rod_to_support_rod_spacing)+(calZ_drive_rod_to_motor_spacing_y-dnaMotor_w/2);
	calZ_drive_support_z = dnaZ_drive_bearing_W;
	
// ###Frame###
	calVertex_spacing_x = calZ_drive_rod_spacing+calZ_drive_rod_to_guide_rod_spacing*2-dnaGuide_rod_R*2-calVertex_T;
	calY_support_L = calVertex_spacing_x + calVertex_T + 2*dnaRod_nut_T;
	
// ###x-axis###
	calX_guide_rod_L = calY_support_L;						//NEED TO ADJUST FOR MOTOR###############
	calX_support_rod_L = calX_guide_rod_spacing+calRod_part_T+2*(2*dnaRod_nut_T+dnaBelt_W);
	
// calculate the actual top rod spacing from the max of requested and minimum size (based on lower vertex (center to center))
	calFrame_top_spacing = max(dnaFrame_top_spacing,calY_support_to_lower_support_min);

// ###Frame###
	calVertex_rod_to_mount_rod_spacing = dnaRod_R*2;
	calY_support_to_upper_support_z = calVertex_spacing_y*cos(30);
	calDelta_size = calVertex_spacing_y+2*(calY_support_to_lower_support_z-calVertex_rod_to_mount_rod_spacing-calVertex_rod_to_mount_rod_spacing*cos(60))/cos(30);
	calDelta_rod_L = calVertex_spacing_y+calVertex_W+2*dnaRod_nut_T;
	calVertex_outer_L = dnaRod_R+calRod_part_T/2+calVertex_W*tan(30);
	calVertex_middle_W = calVertex_W/cos(30);
	calVertex_middle_L = (calY_support_to_lower_support_z-(dnaRod_R+calVertex_outer_L)-(dnaRod_R+calVertex_outer_L)*cos(60)+calVertex_W/2*sin(60))/cos(30);
	
	
// ###Z-axis###
	calZ_guide_rod_L = calY_support_to_lower_support_z+calY_support_to_upper_support_z+calRod_part_T;
	calZ_drive_rod_L = calZ_guide_rod_L-20;					//NEED TO ADJUST FOR PULLEY###############
	
	calVertex_cut = ((calDelta_size-calDelta_rod_L)/2+dnaRod_nut_T)/cos(30);
	calThick_sheet_side_H =calY_support_to_lower_support_z+calY_support_to_upper_support_z+calRod_part_T;
	calThick_sheet_side_W =calY_guide_rod_mount_spacing+calRod_part_T;
	
//Old Leaving until guides are updated to new calculations
//xy_type_T = (dnaScrew_R+dnaMin_around_hole)*2;											//calScrew_part_T
//xy_spring_hole_r = dnaScrew_R;
//z_type_T = (dnaRod_R+dnaMin_around_hole)*2;
//z_spring_hole_r = dnaRod_R;																//calRod_part_T
//arm_H = (dnaAxis_bearing_IR+dnaMin_around_hole)*2;										//calOne_eighty_mount_W
//three_sixty_arm_h = 2*(dnaAxis_bearing_OR+dnaRod_R);										//calThree_sixty_mount_W
//gap_H = (dnaAxis_bearing_OR+dnaGuide_rod_R)*2;											//calAxis_bearing_center_spacing
//screw_from_end = dnaScrew_R+dnaMin_around_hole;											//calMin_screw_from_edge
//bearing_from_end = screw_from_end+dnaScrew_R+dnaAxis_bearing_OR+1;						//calGuide_bearing_from_end
//xy_L = bearing_from_end+dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*2+arm_H/3+xy_type_T;	//calXY_guide_mount_hole_spacing
//z_L = bearing_from_end+dnaAxis_bearing_OR*2+dnaAxis_bearing_IR*2+arm_H/3+z_type_T;	//calZ_guide_mount_hole_spacing
