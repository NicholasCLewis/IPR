/*  caseIPR_parts.scad
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

$t=0;
$t=1;

xLoc=100+dnaMotor_w/2+200*$t;
yLoc=95+275*$t;
zLoc=25+205*$t;

translate([0,0,-10])
	cube([280,280,10]);
translate([dnaMotor_w/2,0,0])
	%cube([200,275,210]);
translate([-100,-115-8,0]){
	%cube([100,440,305]);
	//y axis
	translate([15,440/2,15])rotate([90,0,0])
		cylinder(r=4,h=440,center=true);
	translate([15,440/2,305-15])rotate([90,0,0])
		cylinder(r=4,h=440,center=true);
	translate([15+10,dnaMotor_w/2,dnaMotor_w])rotate([0,90,0])
		mMotor();

	//z axis
	translate([15+10,yLoc-40,305/2])rotate([0,0,0])
		cylinder(r=4,h=305,center=true);
	translate([15+10,yLoc+40,305/2])rotate([0,0,0])
		cylinder(r=4,h=305,center=true);
	translate([100-40,yLoc,305/2])rotate([0,0,0])
		cylinder(r=4,h=305,center=true);
	//gears/motor
	translate([100-40,yLoc,zLoc])rotate([0,0,0])
		cylinder(r=20,h=6,center=true);
	translate([100-40,yLoc,zLoc-6])rotate([0,0,0])
		cylinder(r=10,h=6,center=true,$fn=6);
	translate([100-40-cos(80)*(30+10),yLoc+sin(80)*(30+10),zLoc+10])rotate([0,0,0])
		mMotor();
	translate([100-40-cos(80)*(30+10),yLoc+sin(80)*(30+10),zLoc])
		cylinder(r=20,h=6,center=true);
	//supports
	translate([(100-40)/2,yLoc,10/2])rotate([0,0,0])
		cube([100-40,100,10],center=true);
	translate([(100-40)/2,yLoc,305-10/2])rotate([0,0,0])
		cube([100-40,100,10],center=true);
	translate([(80)/2,yLoc,zLoc+(10+6)/2])rotate([0,0,0])
		cube([80,100,10],center=true);


	//x axis
	translate([(280+100)/2,yLoc+10,zLoc+dnaMotor_w/2+35])rotate([0,90,0])
		cylinder(r=4,h=280+100,center=true);
	translate([(280+100)/2,yLoc+10,zLoc-dnaMotor_w/2+35])rotate([0,90,0])
		cylinder(r=4,h=280+100,center=true);
	translate([100-15,yLoc,zLoc+35])rotate([90,0,0])rotate([0,0,0]){
		mMotor();
		translate([0,0,-10])
			cylinder(r=10,h=20,center=true);
	}
	//x car
	translate([xLoc,yLoc+20,zLoc+35]){
		cube([dnaMotor_w,10,dnaMotor_w],center=true);
		translate([0,8,0])
			cylinder(r=8,h=35,center=true);
		translate([0,8,-30])
			cylinder(r=3,h=35,center=true);
	}


}