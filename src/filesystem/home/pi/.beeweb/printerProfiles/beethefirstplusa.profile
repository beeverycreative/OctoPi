axes:
  e:
    inverted: false
    speed: 300
  x:
    inverted: false
    speed: 4800
  y:
    inverted: false
    speed: 4800
  z:
    inverted: true
    speed: 4800
color: default
extruder:
  count: 1
  nozzleDiameter: 0.4
  offsets:
  - - 0.0
    - 0.0
heatedBed: false
id: beethefirstplusa
model: BEETHEFIRST+ A
name: BEETHEFIRST PLUS A
volume:
  depth: 135.0
  formFactor: rectangular
  height: 125.0
  origin: center
  width: 190.0
startGcode:
  - "M109 S{print_temperature}\nM300\nM107\nG28\nG92 E\nG1 X-98.0 Y-20.0 Z5.0 F3000\nG1 Y-70.0 Z0.3\nG1 X-98.0 Y66.0 F500 E40\nG92 E"
endGcode:
  - ";end gcode\nM300\nG28 X\nG28 Z\nG1 Y65\nG92 E"
