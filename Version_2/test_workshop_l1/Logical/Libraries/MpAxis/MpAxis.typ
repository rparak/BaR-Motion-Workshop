
TYPE
	MpAxisBasicParType : 	STRUCT 
		Position : LREAL := 0.0; (*Target position for the movement [measurement units]*)
		Distance : LREAL := 0.0; (*Traverse path for the movement [measurement units]*)
		Velocity : REAL := 5; (*Maximum velocity [measurement units / s]*)
		Acceleration : REAL := 50; (*Maximum acceleration [measurement units / s²]*)
		Deceleration : REAL := 50; (*Maximum deceleration [measurement units / s²]*)
		Direction : McDirectionEnum := mcDIR_POSITIVE; (*Direction of movement *)
		Homing : MpAxisHomingType; (*Homing parameter*)
		Jog : MpAxisJogType; (*Jog parameter*)
		Stop : MpAxisStopType; (*Stop parameter*)
		LimitLoad : MpAxisLimitLoadType; (*Limit load parameter*)
		AutoTune : MpAxisAutoTuneType;
		Jerk : REAL := 0.0; (*Maximum jerk [measurement units/s³]*)
	END_STRUCT;
	MpAxisHomingType : 	STRUCT 
		Mode : McHomingModeEnum; (*Selects the mode for homing.*)
		Position : LREAL; (*Absolute position after the homing signal is detected [measurement units] *)
		Options : MpAxisHomingOptionsType; (*Additional homing initialization options, *)
	END_STRUCT;
	MpAxisJogType : 	STRUCT 
		Velocity : REAL := 2; (*Maximum velocity [measurement units / s]*)
		Acceleration : REAL := 25; (*Maximum acceleration [measurement units / s²]*)
		Deceleration : REAL := 50; (*Maximum deceleration [measurement units / s²]*)
		LimitPosition : MpAxisJogLimitPositionType; (*Limit positions for the jog movement *)
		Jerk : REAL := 0.0; (*Maximum jerk [measurement units/s³]*)
	END_STRUCT;
	MpAxisStopType : 	STRUCT 
		Deceleration : REAL := 50; (*Maximum deceleration [measurement units / s²]*)
		Jerk : REAL := 0.0; (*Maximum jerk [measurement units/s³]*)
		StopAtPosition : MpAxisStopAtPositionType; (*Option to move to defined position before stop*)
	END_STRUCT;
	MpAxisJogLimitPositionType : 	STRUCT 
		FirstPosition : LREAL := 0.0; (*"Lower" limit position for the jog movement [measurement units]*)
		LastPosition : LREAL := 0.0; (*"Upper" limit position for the jog movement [measurement units]*)
	END_STRUCT;
	MpAxisLimitLoadType : 	STRUCT 
		Load : REAL := 0.0; (*Value for limiting the accelerating torque [Nm]*)
		Direction : McDirectionEnum := mcDIR_CURRENT; (*Direction of movement *)
	END_STRUCT;
	MpAxisBasicInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpAxisBasic is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpAxisBasic is ready for operation*)
		Simulation : BOOL; (*TRUE if axis is operated in simulation mode*)
		Jogging : BOOL; (*Performing movement*)
		JogLimitReached : BOOL; (*Indicates that the axis has reached one of the two position limits *)
		LimitLoadActive : BOOL; (*Limit active*)
		PLCopenState : McAxisPLCopenStateEnum; (*PLCopen state*)
		DigitalInputsStatus : McDigitalInputStatusType; (*Status of the digital inputs*)
		Diag : MpAxisDiagExtType; (*Diagnostic structure for the status ID*)
		LibraryInfo : McLibraryInfoType; (*Library info about the specific axis implementation*)
		CommunicationState : McCommunicationStateEnum; (*Communication state*)
		StartupCount : UDINT; (*Number of times the drive was started up since the last PLC start*)
		AutoTuneDone : BOOL; (*AutoTune command status*)
		AutoTuneQuality : REAL; (*Quality factor from executed AutoTune command*)
		HardwareInfo : McHardwareInfoType; (*Hardware info*)
		AutoTuneState : McAutoTuneStateEnum; (* Status of the auto tune activity on the drive*)
		MechDeviationCompState : McMechDevCompStateEnum; (*Status of mechanical deviation compensation*)
	END_STRUCT;
	MpAxisDiagExtType : 	STRUCT 
		StatusID : MpAxisStatusIDType; (*StatusID information*)
		Internal : MpAxisInternalType; (*Internal data*)
		ExecutingCommand : MpAxisExecutingCmdEnum; (*Command information*)
	END_STRUCT;
	MpAxisInternalType : 	STRUCT 
		ID : DINT; (*ID*)
		Severity : MpComSeveritiesEnum; (*Severity*)
		Facility : MpComFacilitiesEnum; (*Facility*)
		Code : UINT; (*UINT*)
	END_STRUCT;
	MpAxisStatusIDType : 	STRUCT 
		ID : MpAxisErrorEnum; (*Error*)
		Severity : MpComSeveritiesEnum; (*Severity*)
		Code : UINT; (*Code*)
	END_STRUCT;
	MpAxisOffsetParType : 	STRUCT 
		Shift : LREAL; (*Offset shift for slave axis [Measurement Units des Slaves]*)
		Velocity : REAL := 10; (*Maximum velocity [Measurement units/s]*)
		Acceleration : REAL := 50.0; (*Maximum acceleration [Measurement units/s²]*)
		Options : McAdvOffsetParType; (*Structure for using optional  functions
Note:
Parameters left at default values disable the associated optional functions.*)
		CmdIndependentActivation : BOOL := FALSE; (*Allow to activate the Offset functionality independently from OffsetShift command to avoid latency in shift functionalilty when command is set*)
	END_STRUCT;
	MpAxisPhasingParType : 	STRUCT 
		Shift : LREAL; (*Phase shift in the master position of the slave axis [Measurement units].*)
		Velocity : REAL := 10; (*Maximum velocity [Measurement units/s]*)
		Acceleration : REAL := 50.0; (*Maximum acceleration [Measurement units/s²]*)
		Options : McAdvPhasingParType; (*Structure for using optional  functions
Note:
Parameters left at default values disable the associated optional functions.*)
		CmdIndependentActivation : BOOL := FALSE; (*Allow to activate the Phasing functionality independently from PhaseShift command to avoid latency in shift functionalilty when command is set*)
	END_STRUCT;
	MpAxisCouplingInfoType : 	STRUCT 
		SlaveReady : BOOL; (*Slave axis ready for operation (Powered + IsHomed( when needed ))*)
		MasterReady : BOOL; (*Master axis ready for operation (CommunicationReady)*)
		Cam : MpAxisCamInfoType; (*Cam status info type*)
		ActualOffsetShift : LREAL; (*Offset shift currently being executed [Measurement units]
*)
		ActualPhaseShift : LREAL; (*Phase shift currently being executed [Measurement units]
*)
		GetCamPosition : MpAxisGetCamPositionInfoType; (*GetCamPosition command result*)
		Recovery : MpAxisRecoveryInfoType; (*Recovery command related information*)
		Diag : MpAxisDiagExtType; (*Diagnostic structure for the status ID*)
		OffsetValid : BOOL; (*Offset functionality is active and valid*)
		PhasingValid : BOOL; (*Phasing functionality is active and valid*)
	END_STRUCT;
	MpAxisGetCamPositionModeEnum : 
		(
		mcAXIS_GET_CAM_POSITION_SLAVE, (*Get slave postion based on defined cam and dependent on master position*)
		mcAXIS_GET_CAM_POSITION_MASTER, (*Get master postion based on defined cam and dependent on slave position*)
		mcAXIS_MOVE_CAM_POSITION_SLAVE (*Get slave postion based on defined cam and dependent on master position and move absolute to it*)
		);
	MpAxisGetCamPositionParType : 	STRUCT 
		Mode : MpAxisGetCamPositionModeEnum := mcAXIS_GET_CAM_POSITION_SLAVE; (*Mode for GetCamPosition command*)
		Cam : McCamDefineType; (*Cam for getting the position*)
		MasterFactor : DINT := 36000; (*Master streching factor for a cam*)
		SlaveFactor : DINT := 36000; (*Slave streching factor for a cam*)
		MasterPosition : LREAL; (*MasterPosition for which slave position is to be found. Only for mode mpAXIS_GET_CAM_POSITION_SLAVE*)
		SlavePosition : LREAL; (*SlavePosition for which slave position is to be found. Only for mode mpAXIS_GET_CAM_POSITION_MASTER*)
		MasterStartPosition : LREAL; (*Starting position of master from which search of slave matching position will be done. Only for mode mpAXIS_GET_CAM_POSITION_MASTER*)
		Move : MpAxisGetCamPositionMoveParType;
	END_STRUCT;
	MpAxisGetCamPositionMoveParType : 	STRUCT 
		Velocity : REAL := 10.0; (*Velocity for movement to cam slave position[Measurement units/s]*)
		Acceleration : REAL := 50.0; (*Acceleration for movement to cam slave position[Measurement units/s²]*)
		Deceleration : REAL := 50.0; (*Deceleration for movement to cam slave position[Measurement units/s²]*)
		Jerk : REAL; (*Jerk for movement to cam slave position[Measurement units//s³]*)
		Direction : McDirectionEnum := mcDIR_POSITIVE; (*Direction of movement *)
	END_STRUCT;
	MpAxisCamSequencerInfoType : 	STRUCT 
		SlaveReady : BOOL; (*Slave axis ready for operation (Powered + IsHomed( when needed ))*)
		MasterReady : BOOL; (*Master axis ready for operation (CommunicationReady)*)
		OffsetValid : BOOL; (*Offset functionality is active and valid*)
		ActualOffsetShift : LREAL; (*Offset shift currently being executed [Measurement units]*)
		PhasingValid : BOOL; (*Phasing functionality is active and valid*)
		ActualPhaseShift : LREAL; (*Phase shift currently being executed [Measurement units].
*)
		Diag : MpAxisDiagExtType; (*Diagnostic structure for the status ID*)
		Recovery : MpAxisRecoveryInfoType; (*Recovery command related information*)
		ActiveSignal1 : BOOL; (*Signal1 status*)
		ActiveSignal2 : BOOL; (*Signal2 status*)
		ActiveSignal3 : BOOL; (*Signal3 status*)
		ActiveSignal4 : BOOL; (*Signal4 status*)
	END_STRUCT;
	MpAxisCamSequencerParType : 	STRUCT 
		Deceleration : REAL := 0.0; (*Deceleration for Halting CamAutomat in case of sequence end [Measurement units/s²]*)
		CamSequence : MpAxisCamSequenceDataType; (*Cam sequence parameters*)
		ParLockCommand : McCamAutParLockCmdEnum := mcCAMAUT_NO_LOCK; (*ParLock parameters*)
		Offset : MpAxisOffsetParType; (*Offset parameters*)
		Phasing : MpAxisPhasingParType; (*Phasing parameters*)
		CamList : ARRAY[0..13]OF MpAxisCamListType; (*List of cam to be send to drive. As alternative cam defined in axis cam list feature can be used*)
		Recovery : MpAxisSequencerRecoveryParType; (*Recovery parameters*)
	END_STRUCT;
	MpAxisCamSequenceDataType : 	STRUCT 
		Data : McCamAutDefineType; (*Cam sequence definition*)
		Get : MpAxisCamSequenceGetType; (*Get data sequence parameters*)
		Set : MpAxisCamSequenceSetType; (*Set  data sequence parameters*)
	END_STRUCT;
	MpAxisCamSequenceSetType : 	STRUCT 
		Mode : MpAxisSequenceSetModeEnum := mcAXIS_CAM_SEQ_SET_INACTIVE; (*Defines Set cam sequence behaviour*)
		Command : McCamAutSetParCmdEnum; (*Definition of Set command type*)
		UpdateCamList : BOOL; (*Update CamList on Update*)
	END_STRUCT;
	MpAxisCamSequenceGetType : 	STRUCT 
		Command : McCamAutGetParCmdEnum; (*Define behaviour of parameter sequence get command*)
		GetOnEnable : BOOL := FALSE; (*Get Sequence on Fb Enable*)
	END_STRUCT;
	MpAxisCouplingParType : 	STRUCT 
		Gear : MpAxisGearParType; (*Gear parameters*)
		Cam : MpAxisCamParType; (*Cam parameters*)
		GearInPos : MpAxisGearInPosParType; (*Gear parameters*)
		Offset : MpAxisOffsetParType; (*Offset parameters*)
		Phasing : MpAxisPhasingParType; (*Phasing parameters*)
		GetCamPosition : MpAxisGetCamPositionParType; (*GetCamPosition parameters*)
		CamList : ARRAY[0..13]OF MpAxisCamListType; (*List of cam to be send to drive. As alternative cam defined in axis cam list feature can be used*)
		Recovery : MpAxisCouplingRecoveryParType;
	END_STRUCT;
	MpAxisGetCamPositionInfoType : 	STRUCT 
		MasterPosition : LREAL; (*GetCamPosition resulting master position*)
		SlavePosition : LREAL; (*GetCamPosition resulting slave position*)
	END_STRUCT;
	MpAxisCamInfoType : 	STRUCT 
		StandBy : BOOL; (*Cam active in background*)
		InLeadIn : BOOL; (*Currently slave axis is in lead in to a cam*)
		InCam : BOOL; (*Slave is following master with defined cam*)
		InLeadOut : BOOL; (*Currently slave axis is in lead out from a cam*)
		EndOfProfile : BOOL; (*Pulse output indicating end of profile*)
		DataInitialized : BOOL; (*Cam data initialized after Update*)
	END_STRUCT;
	MpAxisCamParType : 	STRUCT 
		ID : UINT; (*Id of a cam used for coupling*)
		MasterStartPosition : LREAL; (*Master axis start position*)
		MasterScaling : DINT := 36000; (*Master stretching factor for a cam*)
		SlaveScaling : DINT := 36000; (*Slave stretching factor for a cam*)
		Options : McAdvBrCamInParType; (*Structure for using optional  functions
Note:
Parameters left at default values disable the associated optional functions.*)
		Mode : MpAxisCamStartModeEnum; (*Mode of Cam command execution*)
	END_STRUCT;
	MpAxisGearInPosParType : 	STRUCT 
		RatioNumerator : DINT := 36000; (*Gear ratio numerator*)
		RatioDenominator : DINT := 36000; (*Gear ratio denominator*)
		MasterValueSource : McValueSrcEnum; (*Source of the master-position.*)
		MasterSyncPosition : LREAL; (*Master position at which the axes begin moving in sync 
[measurement units of master]*)
		SlaveSyncPosition : LREAL; (*Slave position at which the axes begin moving in sync 
[measurement units of slave]*)
		SyncMode : McSyncModeEnum; (*Defines the type of synchronization*)
		MasterStartDistance : LREAL; (*The master distance for the slave to start to synchronize to
the master [measurement units of master]*)
		Velocity : REAL := 10.0; (* Maximum velocity during the movement between StartSync and InSync [measurement units of slave/s]*)
		Acceleration : REAL := 50.0; (*Maximum acceleration [Measurement units/s²]
Note:
If the value is set to 0.0, the limit value for the slave axis is used.*)
		Deceleration : REAL := 50.0; (*Maximum deceleration [Measurement units/s²]
Note:
If the value is set to 0.0, the limit value for the slave axis is used.*)
		Jerk : REAL; (*Maximum jerk [measurement units /s³]*)
		Options : McAdvGearInPosParType; (*Structure for using optional  functions
Note:
Parameters left at default values disable the associated optional functions.*)
	END_STRUCT;
	MpAxisGearParType : 	STRUCT 
		RatioNumerator : DINT := 36000; (*Gear ratio numerator*)
		RatioDenominator : DINT := 36000; (*Gear ratio denominator*)
		MasterValueSource : McValueSrcEnum; (*Source of master position
Note:
Only mcVALUE_SET and mcVALUE_ACTUAL are currently supported.*)
		Acceleration : REAL := 50.0; (*Maximum acceleration [Measurement units/s²]
Note:
If the value is set to 0.0, the limit value for the slave axis is used.*)
		Deceleration : REAL := 50.0; (*Maximum deceleration [Measurement units/s²]
Note:
If the value is set to 0.0, the limit value for the slave axis is used.*)
		Jerk : REAL; (*Maximum jerk [measurement units/ s³]*)
		Options : McAdvGearInParType; (*Structure for using optional  functions
Note:
Parameters left at default values disable the associated optional functions.*)
	END_STRUCT;
	MpAxisCamListType : 	STRUCT 
		Index : UINT; (*Index to be set for a Cam*)
		Cam : McCamDefineType; (*Cam definition*)
	END_STRUCT;
	MpAxisSequencerRecoveryParType : 	STRUCT 
		Mode : McCamAutPrepRestartModeEnum; (* Mode of repositioning*)
		Velocity : REAL := 10.0; (* Maximum velocity [Measurement units/s]*)
		Acceleration : REAL := 50.0; (* Maximum acceleration [Measurement units/s²]*)
		Deceleration : REAL := 50.0; (* Maximum deceleration [Measurement units/s²]*)
		Jerk : REAL; (* Maximum jerk [Measurement units/s³]*)
		Options : McAdvCamAutPrepRestartParType; (* Recovery optional parameters*)
		MasterPositionOffset : LREAL; (*Master position offset used only for Recovery with no CamAutomat used in background*)
	END_STRUCT;
	MpAxisCouplingRecoveryParType : 	STRUCT 
		Mode : McCamAutPrepRestartModeEnum; (* Mode of repositioning*)
		Velocity : REAL := 10.0; (* Maximum velocity [Measurement units/s]*)
		Acceleration : REAL := 50.0; (* Maximum acceleration [Measurement units/s²]*)
		Deceleration : REAL := 50.0; (* Maximum deceleration [Measurement units/s²]*)
		Jerk : REAL; (* Maximum jerk [Measurement units/s³]*)
		Options : McAdvCamAutPrepRestartParType; (* Recovery optional parameters*)
		MasterPositionOffset : LREAL; (*Master position offset used only for Recovery with no CamAutomat used in background*)
	END_STRUCT;
	MpAxisSequenceSetModeEnum : 
		(
		mcAXIS_CAM_SEQ_SET_INACTIVE, (*Setting of Cam Sequence Data not active*)
		mcAXIS_CAM_SEQ_SET_ON_UPDATE, (*Setting of Cam Sequence Data active on Update*)
		mcAXIS_CAM_SEQ_SET_ON_START (*Setting of Cam Sequence Data active on Update and on command Start (StartSequence/Continue)*)
		);
	MpAxisExecutingCmdEnum : 
		(
		mcAXIS_CMD_IDLE := 0, (*No command executed*)
		mcAXIS_CMD_HOMING, (*Command Home in execution*)
		mcAXIS_CMD_STOP, (*Command Stop in execution*)
		mcAXIS_CMD_HALT, (*Command Halt in execution*)
		mcAXIS_CMD_MOVE_VELOCITY, (*Command MoveVelocity in execution*)
		mcAXIS_CMD_MOVE_ABSOLUTE, (*Command MoveAbsolute in execution*)
		mcAXIS_CMD_MOVE_ADDITIVE, (*Command MoveAdditive in execution*)
		mcAXIS_CMD_JOG_POSITIVE, (*Command JogPositive in execution*)
		mcAXIS_CMD_JOG_NEGATIVE, (*Command JogNegative in execution*)
		mcAXIS_CMD_REMOTE_CONTROL, (*External command in execution*)
		mcAXIS_CMD_ERROR_RESET, (*Command ErrorReset in execution*)
		mcAXIS_CMD_GEAR, (*Command Gear in execution*)
		mcAXIS_CMD_CAM, (*Command Cam in execution*)
		mcAXIS_CMD_GEAR_IN_POS, (*Command GearInPos in execution*)
		mcAXIS_CMD_OFFSET_SHIFT, (*Command OffsetShift in execution*)
		mcAXIS_CMD_PHASE_SHIFT, (*Command PhaseShift in execution*)
		mcAXIS_CMD_GET_CAM_POSITION, (*Command GetCamPosition in execution*)
		mcAXIS_CMD_CAM_PREPARE, (*Command CamPrepare in execution*)
		mcAXIS_CMD_CAM_RECOVERY, (*Command Recovery in execution*)
		mcAXIS_CMD_CAM_SEQUENCE, (*Command CamSequence in execution*)
		mcAXIS_CMD_PARLOCK, (*Command ParLock in execution*)
		mcAXIS_CMD_GET_SEQUENCE, (*Command GetSequence in execution*)
		mcAXIS_CMD_SET_SEQUENCE, (*Command SetSequence in execution*)
		mcAXIS_CMD_SIMULATION, (*Command Simulation in execution*)
		mcAXIS_CMD_STOP_AT_POSITION, (*Command StopAtPosition in execution*)
		mcAXIS_CMD_POWER, (*Command Power in execution*)
		mcAXIS_CMD_AUTOTUNE, (*Command AutoTune in execution*)
		mcAXIS_CMD_MOVE_CYCLIC_POSITION, (*Command MoveCyclicPosition*)
		mcAXIS_CMD_MOVE_CYCLIC_VELOCITY, (*Command MoveCyclicVelocity*)
		mcAXIS_CMD_VELOCITY_CONTROL, (*Command Velocity Control*)
		mcAXIS_CMD_TORQUE_CONTROL, (*Command Torque Control*)
		mcAXIS_CMD_TORQUE_FF (*Command Torque Feed Forward*)
		);
	MpAxisCamStartModeEnum : 
		(
		mcAXIS_CAM_START_ENTER_CAM, (* Mode for starting Cam from start*)
		mcAXIS_CAM_START_RESTART (* Mode for restarting previously running Cam*)
		);
	MpAxisRecoveryInfoType : 	STRUCT 
		RestartPosition : LREAL; (* Resulting restart position*)
	END_STRUCT;
	MpAxisHomingOptionsType : 	STRUCT 
		StartVelocity : REAL; (*Velocity for reference switch search [measurement units/s]*)
		HomingVelocity : REAL; (*Velocity (after reaching reference switch) [measurement units/s]*)
		Acceleration : REAL; (*Maximum acceleration [measurement units/s²]*)
		SwitchEdge : McDirectionEnum; (*Edge of reference switch*)
		StartDirection : McDirectionEnum; (*Start direction for searching the reference edge*)
		HomingDirection : McDirectionEnum; (*Direction for homing (after reaching reference switch) *)
		ReferencePulse : McSwitchEnum; (*The encoder's reference pulse is used for homing*)
		KeepDirection : McSwitchEnum; (*mcSWITCH_OFF ... The direction of movement is permitted to be changed during the homing procedure.
mcSWITCH_ON ... The direction of movement is not permitted to be changed during the homing procedure.*)
		ReferencePulseBlockingDistance : REAL; (*Distance for blocking activation of "triggering reference pulse" [measurement units]*)
		TorqueLimit : REAL; (*Torque limit value for homing to blocks [Nm] *)
		BlockDetectionPositionError : REAL; (*Lag error for block detection [measurement units]*)
		PositionErrorStopLimit : REAL; (*Lag error for canceling homing procedure [measurement units]*)
		RestorePositionVariableAddress : UDINT; (*Address of a permanent variable of type McAcpAxRestorePosType that is needed for "HomingMode" mcHOMING_RESTORE_POSITION. McAcpAx only*)
		DriveSpecificHoming : McSwitchEnum; (*The drive-specific homing method entered on input "DriveSpecificHomingMode" is used. McDS402Ax only*)
		DriveSpecificHomingMode : SINT; (*Used for selecting the drive-specific homing method. McDS402Ax only*)
		SensorOffset : LREAL; (*Sensor offset [measurement units]*)
		SensorOffsetDirection : McDirectionEnum; (*Direction for sensor offset movement*)
		DisableRestorePositionOnEnable : McSwitchEnum := mcSWITCH_OFF; (*Used for disabling RestorePosition homing regardless of other parametrization *)
	END_STRUCT;
	MpAxisStopAtPositionType : 	STRUCT 
		Activate : BOOL; (*Option to move to defined position before stop*)
		Deceleration : REAL := 25.0; (*Maximum deceleration [measurement units/s²]*)
		Position : LREAL; (*Position to be stopped at*)
	END_STRUCT;
	MpAxisAutoTuneType : 	STRUCT 
		Mode : MpAxisAutoTuneModeEnum; (*Tuning mode*)
		Orientation : McAcpAxAutoTuneOrientationEnum; (*Selects the orientation for autotuning*)
		MaxCurrentPercent : REAL; (*Percentage of the rated current that is used during autotuning [%]*)
		MaxDistance : LREAL; (*Maximum distance traveled during autotuning [measurement units]*)
		MaxPositionError : LREAL; (*Maximum permitted lag error during autotuning[measurement units]*)
		SaveControllerSettings : BOOL; (* When TRUE the successfully obtained controller settings will be save into axis configuration*)
		LoopFilterMode : MpAxisAutoTuneLoopFilterModeEnum; (* Loop filter tuning mode*)
		Options : MpAxisAutoTuneOptionsType; (*Tuning options*)
		FeedForward : MpAxisAutoTuneFFOptionsType; (*Feed forward parameters*)
	END_STRUCT;
	MpAxisAutoTuneOptionsType : 	STRUCT 
		MaxProportionalGain : REAL; (*Maximum proportional gain [As]*)
		SpeedTuneLoopFilter1Mode : McAcpAxLoopFilterModeEnum; (*Speed tuning loop filter 1 mode*)
		SpeedTuneFilterTmeMode : McAcpAxFilterTimeModeEnum; (*Speed tuning filter time mode*)
	END_STRUCT;
	MpAxisAutoTuneModeEnum : 
		(
		mcAXIS_TUNE_AUTOMATIC, (* Performs a complete auto-tuning sequence of all controllers*)
		mcAXIS_TUNE_SPEED, (* Speed controller tuning*)
		mcAXIS_TUNE_POSITION, (* Position controller tuning*)
		mcAXIS_TUNE_TEST, (* Tests system stability*)
		mcAXIS_TUNE_LOOP_FILTER, (* Loop filter tuning*)
		mcAXIS_TUNE_FEED_FORWARD (*Feed forward tuning*)
		);
	MpAxisAutoTuneLoopFilterModeEnum : 
		(
		mcAXIS_TUNE_LOOP_FILTER_F1, (*Tuning of loop filter 1 as a notch filter*)
		mcAXIS_TUNE_LOOP_FILTER_F1_F2, (*Tuning of filter 1 and 2 as a notch filter*)
		mcAXIS_TUNE_LOOP_FILTER_F1_F2_F3 (*Tuning of filter 1, 2 and 3 as a notch filter*)
		);
	MpAxisAutoTuneFFOptionsType : 	STRUCT 
		Mode : McAcpAxAutoTuneFeedFwdModeEnum := mcACPAX_TUNE_FF_MODE_STANDARD; (* Operating (identification) mode.*)
		Direction : McDirectionEnum := mcDIR_POSITIVE; (* Selects the direction of the feed forward movement.
Note:
Only mcDIR_POSITIVE, mcDIR_NEGATIVE and mcDIR_BOTH are supported.*)
		MaxVelocityPercent : REAL := 50.0; (* Percent of the velocity used during auto tuning [%].
Default value: 50.0F
Valid range: -100.0F .. +100.0F*)
		Acceleration : REAL := 0.0; (* Acceleration which is used for the auto tuning. [Measurement units / s].
Note:
If "0.0F" is used the acceleration is adjusted during the tuning process using an iterative method. Because of this, the tuning process may take a longer time.*)
	END_STRUCT;
	MpAxisCyclicSetInfoType : 	STRUCT 
		AxisReady : BOOL; (*Axis ready for operation (IsPowered and IsHomed if necessary)*)
		TorqueControl : MpAxisTorqueControlInfoType; (*TorqueControl command additional information*)
		Diag : MpAxisDiagExtType; (*Diagnostic information*)
	END_STRUCT;
	MpAxisTorqueControlInfoType : 	STRUCT 
		InTorque : BOOL; (*Torque setpoint reached*)
		DataInitialized : BOOL; (*Changes of TorqueControl parameters initialized on drive*)
		Ready : BOOL; (*The function block is ready for a command. 
If set, a new command can be executed immediately. 
If not set, then a command is executed directly. The next command will be executed as soon as the current command has been successfully transferred. *)
		AxisLimitActive : BOOL; (*Axis velocity limit active 
Note: 
If this output is active, the torque setpoint on the motor is automatically adjusted to bring the axis back within the valid velocity range (stabilization). It is no longer regulated to the configured "Torque" setpoint. *)
	END_STRUCT;
	MpAxisCyclicSetParType : 	STRUCT 
		MoveCyclicPosition : MpAxisMoveCyclicPositionParType; (*Parameter for MoveCyclicPosition command*)
		MoveCyclicVelocity : MpAxisMoveCyclicVelocityParType; (*Parameter for MoveCyclicVelocity command*)
		TorqueControl : MpAxisTorqueControlParType; (*Parameter for TorqueControl command*)
		TorqueFeedForward : MpAxisTorqueFFParType; (*Parameter for TorqueFF command*)
	END_STRUCT;
	MpAxisMoveCyclicPositionParType : 	STRUCT 
		InterpolationMode : McIplModeEnum; (*Interpolation mode for the received value*)
		Velocity : REAL; (*Maximum velocity [measurement units/s]*)
		Acceleration : REAL; (*Maximum acceleration [measurement units/s²]*)
		Deceleration : REAL; (*Maximum deceleration [measurement units/s²]*)
		Jerk : REAL; (*Maximum jerk [measurement units/s³]*)
		DisableJoltLimitation : McSwitchEnum; (*mcSWITCH_OFF ... Jerk limitation on the drive is active.
mcSWITCH_ON ... Jerk limitation on the drive is disabled.
Note:
This should only be disabled for a real axis if jerk limitation is included when calculating the cyclic setpoint. *)
		AlternativeValueSource : McAltValueSrcEnum; (*Alternative value source for CyclicPosition. 
Note:
Axis feature Alternative value source must be used to use an alternative source.*)
	END_STRUCT;
	MpAxisMoveCyclicVelocityModeEnum : 
		(
		mcAXIS_MCV_MODE_MOVE_CYC_VEL, (*MoveCyclicVelocity mode*)
		mcAXIS_MCV_MODE_MOVE_VEL_CTRL (*VelocityControl mode*)
		);
	MpAxisMoveCyclicVelocityParType : 	STRUCT 
		Mode : MpAxisMoveCyclicVelocityModeEnum; (*Mode for MoveCyclicVelocity command*)
		InterpolationMode : McIplModeEnum; (*Interpolation mode for the received value*)
		Acceleration : REAL; (*Maximum acceleration [measurement units/s²]*)
		Deceleration : REAL; (*Maximum deceleration [measurement units/s²]*)
		Jerk : REAL; (*Maximum jerk [measurement units/s³]*)
		DisableJoltLimitation : McSwitchEnum; (*mcSWITCH_OFF ... Jerk limitation on the drive is active.
mcSWITCH_ON ... Jerk limitation on the drive is disabled.
Note:
This should only be disabled for a real axis if jerk limitation is included when calculating the cyclic setpoint. *)
		AlternativeValueSource : McAltValueSrcEnum; (*Alternative value source for CyclicVelocity. 
Note:
Axis feature Alternative value source must be used to use an alternative source.*)
	END_STRUCT;
	MpAxisTorqueControlParType : 	STRUCT 
		CmdIndependentActivation : BOOL := FALSE; (*Allow to activate the TorqueControl functionality independently from TorqueControl command to avoid latency in shift functionalilty when command is set*)
		TorqueResolution : REAL; (*Smallest value change considered as Torque setpoint change*)
		TorqueRamp : REAL; (*Increase in torque until "Torque" value is reached [Nm/s]
Note: 
Value "0" is a valid setting and cuts off ramp generation. *)
		MaximumVelocity : REAL; (*Signed upper velocity limit [measurement units/s]
Note:
This value can be negative, "0" or positive, but "MaximumVelocity" must always be greater than "MinimumVelocity".
To disable, either set a high value or use "AdvancedParameters.VelocityLimitOff". *)
		MinimumVelocity : REAL; (*Signed lower velocity limit [measurement units/s]
Note: 
This value can be negative, "0" or positive, but "MaximumVelocity" must always be greater than "MinimumVelocity".
To disable, either set a low value (strongly negative) or use "AdvancedParameters.VelocityLimitOff". *)
		Acceleration : REAL; (*Maximum acceleration [measurement units/s²]
or maximum deceleration when changing "MaximumVelocity" or "MinimumVelocity" [measurement units/s²] 
Note:
The value is not necessarily reached during operation.
If value "0", "<0" or ">Limit value" is specified on this input, the limit value of the axis (Movement limits - Acceleration) is used.*)
		Jerk : REAL; (*Maximum jerk [measurement units/s³]
Note:
Jerk is currently not supported. Parameter "Jerk" must be 0.0.*)
		Options : McAdvBrTorqueControlParType; (*Structure for using advanced functions
Note:
Parameters left at "0" disable the associated advanced function. *)
	END_STRUCT;
	MpAxisTorqueFFParType : 	STRUCT 
		InterpolationMode : McIplModeEnum := mcIPLM_DEFAULT; (*Interpolation mode for the received value*)
		Options : McAdvCyclicTorqueFFParType; (*Selection of behavior when disabling*)
	END_STRUCT;
END_TYPE
