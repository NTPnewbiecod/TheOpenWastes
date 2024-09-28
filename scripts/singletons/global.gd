extends Node

var mouse_inverted: bool = false
var default_mouse_sensitivity: float = 0.015

## if [code]true[/code] interpolate visual frame.[br]
## NOTE. in order to create the interpolated frame. [br]
## it needed to hold on to physic_process frame by at least 1 frame to properly interpolate between previous frame and current frame.[br]
## most of the code implementation use [code]top_level[/code] property to detach visual repesentation node from it's physic repesentation.[br]
## and may cause slight input lag. and reduce overall responsiveness.
## if [code]false[/code] disable all interpolation. this may sync the visual frame to physics_process frame.
var is_frame_interpolation_enable: bool = true
