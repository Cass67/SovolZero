# Orca Slicer Setup

You have to modify your slicer's `Machine Gcode` that is sent to the printer.
The Machine Gcode for Orca slicer is shown below, please take special care to copy them in correctly, as even a single error can stop the whole system from working.
Below shows a fully setup slicer as per recommended Mainsail settings combined with the macro settings for Orca Slicer using relative extrusion.

Cut/paste your current gcode out of the gcode window & into Notepad/Notes to save if you ever revert back & need it again. Replace your old Machine Gcode with the new Gcode for the relevant boxes.

>[!TIP]
>It's very important the `DEMON_START` line of the `Machine Start Gcode` is a single long line as shown below, with no returns in it. 
>If this is not the case the system will fail as soon as you start a print.

###### NOTE: If your screen can't hold the text in a single line the computer will place it on mulitple lines itself, however there will not be actual "returns" placed into it, as far as the printer will see it will still be one long line.

>[!IMPORTANT]
>ORCA SLICER v2.3.2 is REQUIRED for this latest version (v1.4) of the machine G-code.
>
>The older v1.3 will still work but you will get red warnings when you start a print on this old version. v1.2 compatibilty has been removed.


>[!NOTE]
>The `_SPS GSTART=True` line must be on a new line as shown!
>
>Also make sure you add _DPROA to the new Printing by object G-code box! 

<br>

Here is how they should look in Ocra Slicer. 

<img width="1457" height="2104" alt="ORCA GCODE" src="https://github.com/user-attachments/assets/4ab2bd68-c5b4-4625-82c5-f3dd5a4befc1" />

<br>
<br>

These are fully setup codes as per recommended Mainsail settings combined with the macro settings for Orca Slicer using relative extrusion, as per the image....

>[!TIP]
>Use the double box icon on the right side of the text to instantly copy each command ready for you to paste into your SSH terminal!

<br>

Machine Start G-code:

```
SET_PRINT_STATS_INFO TOTAL_LAYER=[total_layer_count]
M104 S0  ; Stops the slicer from sending temp waits separately
M140 S0
DEMON_START EXTRUDER=[nozzle_temperature_initial_layer] TOOL={initial_tool} BED=[bed_temperature_initial_layer_single] LAYER=[layer_height] FILAMENT=[filament_type] SEQUENCE="[print_sequence]" EXCLUDE=[exclude_object] SURFACE="[curr_bed_type]" OAPA=[adaptive_pressure_advance] DMGCC="v1.4"
_SPS GSTART=True
```

Machine end G-code:
```
; printing object ENDGCODE
DEMON_END
```

Printing by object G-code:
```
_DPROA
```

Before layer change G-code:
```
;BEFORE_LAYER_CHANGE
;[layer_z]
G92 E0
```

Layer change G-code:
```
;AFTER_LAYER_CHANGE
;[layer_z]
SET_PRINT_STATS_INFO CURRENT_LAYER={layer_num + 1}
M117 Layer {layer_num+1}/[total_layer_count] : {filament_settings_id[0]}
```

Change filament G-code:
```
_FIL_CHANGE_PARK
```

Change extrusion role G-code:
```
_DEMON_ADAPTIVE_PA TYPE=[extrusion_role]
```

Pause G-code:
```
PAUSE
```

### [Head back to where you were...](https://github.com/3DPrintDemon/Demon_Klipper_Essentials_Unified/blob/main/Documentation/INSTALL_INSTRUCTIONS/General_Setup_For_All_Printers/INSTALL_INSTRUCTIONS.md#orca-slicer-setup)
