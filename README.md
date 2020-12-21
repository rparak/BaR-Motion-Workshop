# B&R Automation Workshop - simple motion control with MappTechnology and PLCOpen

## Requirements:

**Software:**
```bash
Automation Studio V 4.9.2.46
Scene Viewer V 4.1.0
```

Link AS B&R: https://www.br-automation.com/en/downloads/software/automation-studio/automation-studio-49

Link SceneViewer B&R: https://www.br-automation.com/en/downloads/software/simulation/br-scene-viewer/

**Version 0:**

```bash
Automation Runtime: C4.90 (PLC -> X20CP1584)
ACP10 ARNC0 (Motion): 5.12.2
mappView  : 5.12.1
```

**Version 1:**

```bash
Automation Runtime: C4.90 (PLC -> X20CP1584)
ACP10 ARNC0 (Motion): 5.12.2
MpAxis: 1.75.0
mappView  : 5.12.1
```

**Version 2:**

```bash
Automation Runtime: C4.90 (PLC -> X20CP1584)
mapp Motion: 5.12.2
mapp View  : 5.12.1
mapp Cockpit: 5.12.0
```

## Project Description:

The workshop is focused on simple motion control using Mapp Technology and PLCOpen. The perfect combination of automation development solutions will be created by the additional connection of a visualization package (mappView) and software for digital/virtual twins (Scene Viewer).

<p align="center">
<img src="https://github.com/rparak/BaR-Workshop-Simple/blob/master/images/Workshop_Poster.png" width="550" height="300">
</p>

The project is divided into several parts:

  a) [Version 0](https://github.com/rparak/BaR-Workshop-Simple/tree/master/Version_0/test_workshop_l1):
  
  Text
  
  b) [Version 1](https://github.com/rparak/BaR-Workshop-Simple/tree/master/Version_1/test_workshop_l1):
  
  Text
  
  c) [Version 2](https://github.com/rparak/BaR-Workshop-Simple/tree/master/Version_2/test_workshop_l1):
  
  Text
  
  d) [Workshop_Template_Folder](https://github.com/rparak/BaR-Workshop-Simple/tree/master/Workshop_Template_Folder):
  
  An empty project with necessarily installed versions (runtime, mappview package, etc.), and several files to create your own project (3D objects for SceneViewer digital twin, binding file, mappview theme, etc.)

## Hardware Components:

<p align="center">
<img src="https://github.com/rparak/BaR-Workshop-Simple/blob/master/images/simple_diagram.PNG" width="400" height="220">
</p>

**Electric Switchboard/Motion Control:**
| Part Name     | Link          |
| ------------- | ------------- |
| PLC system (X20CP1584) | https://www.br-automation.com/en/products/plc-systems/x20-system/x20-cpus/x20cp1584/ |
| ACOPOSmicro -> Inverter modules (80VD100PD.C000-01) | https://www.br-automation.com/en/products/motion-control/acoposmicro/inverter-modules/80vd100pdc000-01/?noredirect=1 |

**7th Axis (Linear Conveyor):**
| Part Name     | Link          |
| ------------- | ------------- |
| LEJSH63NZA-800  | https://www.smcusa.com/products/?id=126023&partNumber=LEJSH63NZA-800&type=Detail |
| LEFG40-S-800  | https://www.smcusa.com/products/?id=139293&partNumber=LEFG40-S-800&type=Detail |
| 8LVA synchronous motors (8LVA23.B1030D000-0)  | https://www.br-automation.com/en/products/motion-control/8lva-synchronous-motors/standard-motors/8lva23b1030d000-0/?noredirect=1|

## HMI Visualization:

**MappView:**

IP Address (Simulation/Real HW): 

http://localhost:81/index.html?visuId=axis_control or http://PLC_ADDRESS:81/index.html?visuId=axis_control

<p align="center">
<img src="https://github.com/rparak/BaR-Workshop-Simple/blob/master/images/mappView.png" width="550" height="300">
</p>

**MappCockpit (Exclusively for MappMotion control):**

IP Address (Simulation/Real HW): 

http://localhost:8084/mappCockpit or http://PLC_ADDRESS:8084/mappCockpit

<p align="center">
<img src="https://github.com/rparak/BaR-Workshop-Simple/blob/master/images/mappCockpit.png" width="550" height="300">
</p>

## Digital Twin:

<p align="center">
<img src="https://github.com/rparak/BaR-Workshop-Simple/blob/master/images/digT_sv.PNG" width="550" height="300">
</p>

## Additional information:

**MappTechnology:**

Link: https://www.br-automation.com/en/products/software/mapp-technology/

Link: https://www.youtube.com/watch?v=poufs5F3xB8

**B&R Automation - Free Webinars (CZ):**

Link: https://www.br-automation.com/cs/akademie/webinare/

**B&R Automation - Academy:**

Link: https://www.br-automation.com/en/academy/dates-and-registration/

## Contact Info:
Roman.Parak@outlook.com

## License
[MIT](https://choosealicense.com/licenses/mit/)
