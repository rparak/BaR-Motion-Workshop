/**

 * MIT License

 * Copyright(c) 2020 Roman Parak
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/**
 * Author   : Roman Parak
 * Email    : Roman.Parak@outlook.com
 * Date     : 12.12.2020
 * File Name: axCtrl_T.c
 */

/** < Include B&R Automation libraries (declarations for B&R ANSI C extensions) */
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

/** < Include header file with specified structures / enums, etc. */
#include "ax_ctrl.h"

/// Switches on the axis controller.
_LOCAL struct MC_Power MC_Power_0;
/// Homes an axis.
_LOCAL struct MC_Home MC_Home_0;
/// This function block starts a controlled movement to a specified absolute position. 
_LOCAL struct MC_MoveAbsolute MC_MoveAbsolute_0;
// These function blocks read the position/velocity of the axis.
_LOCAL struct MC_ReadActualPosition MC_ReadActualPosition_0;
_LOCAL struct MC_ReadActualVelocity MC_ReadActualVelocity_0;

/// Custom structure for axis control and data collection (more in the header file -> axCtrl_T.h)
_LOCAL struct motion_ctrl_main ctrl_lin_ax_0;

/**
 * Program Intitialization
 */
void _INIT ProgramInit(void)
{

	/**
	* Declaration of function block inputs
	*
	* a) gAxis01 -> Axis reference
	* b) 1       -> Enables the function block
	*/
	MC_Power_0.Axis = &gAxis01;
	MC_Home_0.Axis  = &gAxis01;
	MC_MoveAbsolute_0.Axis = &gAxis01;
	MC_ReadActualPosition_0.Axis   = &gAxis01;
	MC_ReadActualPosition_0.Enable = 1;
	MC_ReadActualVelocity_0.Axis = &gAxis01;
	MC_ReadActualVelocity_0.Enable = 1;

	/// Set initialization state to default
	ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_ACTIVE;
}	

/**
 * Program Cyclic 
 * 
 * Duration (Cycle Time): 2000 [µs] 
 * Tolerance            : 0    [µs]
 */
void _CYCLIC ProgramCyclic(void)
{
	/**
	 * Main state machine for control of a single axis.
	 *
	 * Number of states: 8 (for more information -> axCtrl_T.h)
	 */
	switch(ctrl_lin_ax_0.actual_state){
		case LIN_AX_CTRL_ACTIVE: ///< The Function block is active.
			{
				if(ctrl_lin_ax_0.read.is_active == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_POWER;
				}	
			}
			break;
		case LIN_AX_CTRL_POWER: ///< Axis is power on.
			{
				if(ctrl_lin_ax_0.read.power_on == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_HOME;
				}
			}
			break;
		case LIN_AX_CTRL_HOME: ///< Axis is homed.
			{
				if(ctrl_lin_ax_0.read.is_homed == 1){
					MC_Home_0.Execute = 0;
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_WAIT;
				}
			}
			break;
		case LIN_AX_CTRL_WAIT: ///< Wait for the command.
			{
				if(ctrl_lin_ax_0.cmd.move_absolute_position == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_MOVE_1;
				}
			}
			break;
		case LIN_AX_CTRL_MOVE_1: ///< Move Axis (1) -> Set Parameters.
			{	
				ctrl_lin_ax_0.cmd.move_absolute_position = 0;
				
				MC_MoveAbsolute_0.Position     = ctrl_lin_ax_0.write.position;
				MC_MoveAbsolute_0.Velocity     = ctrl_lin_ax_0.write.velocity;
				MC_MoveAbsolute_0.Acceleration = ctrl_lin_ax_0.write.acceleration;
				MC_MoveAbsolute_0.Deceleration = ctrl_lin_ax_0.write.deceleration;

				ctrl_lin_ax_0.read.set_position = ctrl_lin_ax_0.write.position;
				
				/**
				 * Check the direction of movement of the axis from the actual position.
				 *
				 * Set Position >= Actual Position -> Velocity (+)
				 * Set Position < Actual Position  -> Velocity (-)
				 */
				if(ctrl_lin_ax_0.read.set_position >= ctrl_lin_ax_0.read.actual_position){
					ctrl_lin_ax_0.read.set_velocity = ctrl_lin_ax_0.write.velocity;	
				}else if(ctrl_lin_ax_0.read.set_position < ctrl_lin_ax_0.read.actual_position){
					ctrl_lin_ax_0.read.set_velocity = (-1)*ctrl_lin_ax_0.write.velocity;
				}
				
				MC_MoveAbsolute_0.Execute = 1;
					
				if(MC_MoveAbsolute_0.Busy == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_MOVE_2;
				}
			}
			break;
		case LIN_AX_CTRL_MOVE_2: ///< Move Axis (2) -> Wait until the axis is in specified position.
			{
				if(MC_MoveAbsolute_0.Done == 1){
					ctrl_lin_ax_0.read.set_velocity = 0.0;
					MC_MoveAbsolute_0.Execute = 0;
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_WAIT;
				}
			}
			break;
		case LIN_AX_CTRL_ERROR: ///< The function block is in an error state, wait for reset.
			{
				/// Reset Move Absolute function block
				MC_MoveAbsolute_0.Execute = !ctrl_lin_ax_0.cmd.reset_error;
			
				ctrl_lin_ax_0.write.position     = 0.0;
				ctrl_lin_ax_0.write.velocity     = 0.0;
				ctrl_lin_ax_0.write.acceleration = 0.0;
				ctrl_lin_ax_0.write.deceleration = 0.0;
			
				if(ctrl_lin_ax_0.read.error == 0){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_WAIT;
				}
			}
			break;
	}
	
	/// write inputs to the function block
	MC_Power_0.Enable  = ctrl_lin_ax_0.cmd.power;
	MC_Home_0.Execute  = ctrl_lin_ax_0.cmd.home;
	
	/// call axis control function blocks
	MC_Power(&MC_Power_0);
	MC_Home(&MC_Home_0);
	MC_MoveAbsolute(&MC_MoveAbsolute_0);
	MC_ReadActualPosition(&MC_ReadActualPosition_0);
	MC_ReadActualVelocity(&MC_ReadActualVelocity_0);
	
	/// read outputs from the function block for position control
	ctrl_lin_ax_0.read.error = MC_MoveAbsolute_0.Error;

	/// read outputs from the function blocks for other parameters
	ctrl_lin_ax_0.read.power_on         = MC_Power_0.Status;
	ctrl_lin_ax_0.read.is_homed         = MC_Home_0.Done;
	ctrl_lin_ax_0.read.actual_position  = MC_ReadActualPosition_0.Position;
	ctrl_lin_ax_0.read.actual_velocity  = MC_ReadActualVelocity_0.Velocity;
	/// Is the function block active? Y -> Start controlling the axis; N -> Nothing, wait for the active is True.
	if(MC_ReadActualPosition_0.Error == 0 && MC_ReadActualVelocity_0.Error == 0){
		ctrl_lin_ax_0.read.is_active = 1;
	}
	/**
	 * Digital twin (scene viewer) -> reading the actual position and 
	 * transforming the specified axis units into millimeters.
	 */
	
	ctrl_lin_ax_0.write.dT.position = MC_ReadActualPosition_0.Position/10;
	
	/**
	 * Error detection (cyclic reading in time).
	 * 
	 * After detecting one or more errors, change the state on the main 
	 * state machine and wait for the error reset command.
	 */
	if(ctrl_lin_ax_0.read.error == 1){
		ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_ERROR;	
	}
}


