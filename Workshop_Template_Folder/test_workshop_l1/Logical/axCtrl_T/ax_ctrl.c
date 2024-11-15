/** < Include B&R Automation libraries (declarations for B&R ANSI C extensions) */
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

/** < Include header file with specified structures / enums, etc. */
#include "ax_ctrl.h"

/// Custom structure for axis control and data collection (more in the header file -> axCtrl_T.h)
_LOCAL struct motion_ctrl_main ctrl_lin_ax_0;

/**
 * Program Intitialization
 */
void _INIT ProgramInit(void)
{

}	

/**
 * Program Cyclic 
 * 
 * Duration (Cycle Time): 2000 [µs] 
 * Tolerance            : 0    [µs]
 */
void _CYCLIC ProgramCyclic(void)
{
	
}