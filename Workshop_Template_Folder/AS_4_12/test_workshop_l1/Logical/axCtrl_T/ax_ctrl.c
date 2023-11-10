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
	MpAxisBasic_0.MpLink     = &gAxis_1;
	MpAxisBasic_0.Parameters = &AxisParameters;
}	

void _CYCLIC ProgramCyclic(void)
{
	MpAxisBasic(&MpAxisBasic_0);	
}


