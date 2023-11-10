#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "ax_ctrl.h"

_LOCAL struct MpAxisBasic MpAxisBasic_0;
_LOCAL struct MpAxisBasicParType AxisParameters;
_LOCAL struct motion_ctrl_main ctrl_lin_ax_0;

void _INIT ProgramInit(void)
{
	MpAxisBasic_0.Enable     = 1;
	MpAxisBasic_0.MpLink     = &gAxis_2;
	MpAxisBasic_0.Parameters = &AxisParameters;
	
	ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_ACTIVE;
}	

void _CYCLIC ProgramCyclic(void)
{
	switch(ctrl_lin_ax_0.actual_state){
		case LIN_AX_CTRL_ACTIVE:
			{	
				if(ctrl_lin_ax_0.read.is_active == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_POWER;
				}
			}
			break;
		case LIN_AX_CTRL_POWER:
			{
				if(ctrl_lin_ax_0.read.power_on == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_HOME;
				}
			}
			break;
		case LIN_AX_CTRL_HOME:
			{
				if(ctrl_lin_ax_0.read.is_homed == 1){
					MpAxisBasic_0.Home = 0;
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_WAIT;
				}
			}
			break;
		case LIN_AX_CTRL_WAIT:
			{
				if(ctrl_lin_ax_0.cmd.move_absolute_postion == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_MOVE_1;
				}
			}
			break;
		case LIN_AX_CTRL_MOVE_1:
			{
				ctrl_lin_ax_0.cmd.move_absolute_postion = 0;
				
				AxisParameters.Position = ctrl_lin_ax_0.write.position;
				AxisParameters.Velocity = ctrl_lin_ax_0.write.velocity;
				AxisParameters.Acceleration = ctrl_lin_ax_0.write.acceleration;
				AxisParameters.Deceleration = ctrl_lin_ax_0.write.deceleration;
				
				MpAxisBasic_0.MoveAbsolute = 1;
				
				if(MpAxisBasic_0.MoveActive == 1){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_MOVE_2;
				}
			}
			break;
		case LIN_AX_CTRL_MOVE_2:
			{
				if(MpAxisBasic_0.InPosition == 1 && MpAxisBasic_0.MoveDone){
					MpAxisBasic_0.MoveAbsolute = 0;
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_WAIT;
				}
			}
			break;
		case LIN_AX_CTRL_ERROR:
			{
				MpAxisBasic_0.MoveAbsolute = 0;
				
				AxisParameters.Position = 0.0;
				AxisParameters.Velocity = 0.0;
				AxisParameters.Acceleration = 0.0;
				AxisParameters.Deceleration = 0.0;
				
				if(ctrl_lin_ax_0.read.error == 0){
					ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_WAIT;
				}
			}
			break;
	}
	
	MpAxisBasic_0.Power = ctrl_lin_ax_0.cmd.power;
	MpAxisBasic_0.Home = ctrl_lin_ax_0.cmd.home;
	MpAxisBasic_0.ErrorReset = ctrl_lin_ax_0.cmd.reset_error;
		
	MpAxisBasic(&MpAxisBasic_0);	
	
	ctrl_lin_ax_0.read.is_active = MpAxisBasic_0.Active;
	ctrl_lin_ax_0.read.power_on = MpAxisBasic_0.PowerOn;
	ctrl_lin_ax_0.read.is_homed = MpAxisBasic_0.IsHomed;
	ctrl_lin_ax_0.read.actual_position = MpAxisBasic_0.Position;
	ctrl_lin_ax_0.read.actual_velocity = MpAxisBasic_0.Velocity;
	ctrl_lin_ax_0.read.error = MpAxisBasic_0.Error;
	
	if(MpAxisBasic_0.Error == 1){
		ctrl_lin_ax_0.actual_state = LIN_AX_CTRL_ERROR;
	}
}


