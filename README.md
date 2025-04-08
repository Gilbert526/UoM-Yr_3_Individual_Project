# UoM Year 3 Individual Project

## A Project by Geping Wang

This is a repository for UoM Year 3 Individual Project where you can find files for MATLAB and Simulink simulation.

For running the model, please download [`constants.m`](constants.m), [`GridTiedInverterNew.slx`](GridTiedInverterNew.slx), and [`S_target_0.mat`](S_target_0.mat).

For detailed explanation for the usage of each file, please refer to the table below.

| File                      | Description   |
| :------:                  | :-------      |
| [`GridTiedInverterNew.slx`](GridTiedInverterNew.slx)  | Main model for the simulation.    |
| [`Readme.md`](Readme.md)                              | This defines the text you are reading right now. (˶ᵔ ᵕ ᵔ˶)    |
| [`S_target_0.mat`](S_target_0.mat)                    | Test scenario which include the target profile of active and reactive power.  |
| [`analysis.m`](analysis.m)                            | Calculation of response time, steady-state error and total harmonic distortion based on the simulation results.   |
| [`constants.m`](constants.m)                          | Stores all the parameters for the simulation. |
| [`graphing.m`](graphing.m)                            | Plot graphs of power against time and current against time based on the simulation results.   |
| [`total_harmonic_distortion.m`](total_harmonic_distortion.m)  | Plot graphs of harmonics based on the simulation results. |

Acknowledgement: Part of the code for data analysis and graph plotting involved the use of generative AI tools including ChatGPT and Deepseek.
