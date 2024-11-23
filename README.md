# B&R Automation Workshop - Simple motion control with MappTechnology and PLCOpen

## Requirements:

**Software:**
```bash
Automation Studio V 4.9.2.46, Scene Viewer V 4.1.0, Blender, Unity3D 2020.1.8f1, Vuforia 8.3.8 and later
```

**Supported on the following operating systems:**
```bash
Universal Windows Platform, Android
```

| Software/Package      | Link                                                                                  |
| --------------------- | ------------------------------------------------------------------------------------- |
| Blender               | https://www.blender.org/download/                                                     |
| Unity3D               | https://unity3d.com/get-unity/download/archive                                        |
| Vuforia Engine        | https://developer.vuforia.com/downloads/sdk                                           |
| Unity HDRI Pack       | https://assetstore.unity.com/packages/2d/textures-materials/sky/unity-hdri-pack-72511 |
| B&R Automation        | https://www.br-automation.com/en/downloads/#categories=Software-1344987434933         |
| SceneViewer B&R       | https://www.br-automation.com/en/downloads/software/simulation/br-scene-viewer/       |
| Visual Studio         | https://visualstudio.microsoft.com/downloads/                                         |

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

**Warning**

If the problem occurs during the build with the **User.user** file within the **Configuration View**, just add a new configuration and **COPY+PASTE** the same file into the previous configuration and rebuild the project.

## Project Description:

The workshop is focused on simple motion control using Mapp Technology and PLCOpen. The perfect combination of automation development solutions will be created by the additional connection of a visualization package (mappView) and software for digital/virtual twins (Scene Viewer).

<p align="center">
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/Workshop_Poster.png" width="800" height="450">
</p>

The project is divided into several parts:

  a) [Version 0](https://github.com/rparak/BaR-Motion-Workshop/tree/master/Version_0/test_workshop_l1):
  
  Simple motion control using PLCOpen libraries (MC_Power, MC_Home, etc.) The current version uses the package ACP10 for motion control without any mappMotion additional components. The functionality of the axis is tested using ACP10 Test Manager. The HMI visualization is controlled from the mappView.
  
```bash
Logical View:
[ AS Program   ] /Logical/axCtrl_T/
[ AS MappView  ] /Logical/mappView/
Physical View:
[ AS MappView  ] /Physical/X20CP1584/X20CP1584/mappView
```
  
  b) [Version 1](https://github.com/rparak/BaR-Motion-Workshop/tree/master/Version_1/test_workshop_l1):
  
  The middle way, but very efficient and currently the most used. For motion control uses libraries like MpAxisBasic, MpAxisCyclicSet, etc., but it uses the ACP10 package as in the previous case. The functionality of the axis is tested using ACP10 Test Manager. The HMI visualization is controlled from the mappView.
  
 ```bash
Logical View:
[ AS Program   ] /Logical/axCtrl_T/
[ AS MappView  ] /Logical/mappView/
Physical View:
[ AS Mapp Axis ] /Physical/X20CP1584/X20CP1584/Motion/
[ AS MappView  ] /Physical/X20CP1584/X20CP1584/mappView/
```
  
  c) [Version 2](https://github.com/rparak/BaR-Motion-Workshop/tree/master/Version_2/test_workshop_l1):
  
  The latest (newest) motion control with mappMotion using libraries like MpAxisBasic, etc.  The functionality of the axis is tested using mappCockpit. The HMI visualization is controlled from the mappView.
  
 ```bash
Logical View:
[ AS Program   ] /Logical/axCtrl_T/
[ AS MappView  ] /Logical/mappView/
Physical View:
[ AS MappMotion  ] /Physical/X20CP1584/X20CP1584/mappMotion/
[ AS MappCockpit ] /Physical/X20CP1584/X20CP1584/mappCockpit/
[ AS MappView    ] /Physical/X20CP1584/X20CP1584/mappView/
```

  d) [Workshop_Template_Folder](https://github.com/rparak/BaR-Motion-Workshop/tree/master/Workshop_Template_Folder):
  
  An empty project with necessarily installed versions (runtime, mappview package, etc.), and several files to create your own project (3D objects for SceneViewer digital twin, binding file, mappview theme, etc.)
  
 ```bash
Logical View:
[ AS Program   ] /Logical/axCtrl_T/
```

[Workshop_Template_Folder](https://github.com/rparak/BaR-Motion-Workshop/tree/master/Unity3D):
  
Client-server communication via OPC UA, which is implemented in Unity3D (Server - B&R Automation PLC, Client - Unity3D). The application can be used for digital twins or augmented reality, both principles are in a folder.

## Hardware Components:

<p align="center">
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/simple_diagram.PNG" width="400" height="175">
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
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/mappView.png" width="800" height="450">
</p>

**MappCockpit (Exclusively for MappMotion control):**

IP Address (Simulation/Real HW): 

http://localhost:8084/mappCockpit or http://PLC_ADDRESS:8084/mappCockpit

<p align="center">
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/mappCockpit.png" width="800" height="500">
</p>

## Digital Twin:

**Scene Viewer:**

<p align="center">
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/digT_sv.PNG" width="800" height="500">
</p>

**Unity3D:**

<p align="center">
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/lin_ax_1.png" width="800" height="500">
</p>

## Augmented Reality:

<p align="center">
<img src="https://github.com/rparak/BaR-Motion-Workshop/blob/master/images/ar_1.JPG" width="800" height="500">
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

## Citation (BibTex)
```bash
@misc{RomanParak_Unity3D,
  author = {Roman Parak},
  title = {A digital-twins in the field of industrial robotics integrated into the unity3d development platform},
  year = {2020-2021},
  publisher = {GitHub},
  journal = {GitHub repository},
  howpublished = {\url{https://github.com/rparak/Unity3D_Robotics_Overview}}
}
```
## License
[MIT](https://choosealicense.com/licenses/mit/)
