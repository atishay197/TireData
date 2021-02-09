# Tire Modeling

Tire is the fundamental componentto determine vehicle dynamics and handling. Improving vehicle performance keeping in mind the lateral and longitudinal dynamics can be done with the help of tire properties. The concept of understeer and oversteer are based on tire properties. Tire stimulation is important to understand the longitudinal and lateral dynamics of a tire. So data from an actual tire stimulation was used to understand tire behavior which will be used for suspension tuning to get the maximum output out of the tire.

## Runing the tire modeling scripts
Each script can be run independently. The following is the description of what each of the scripts do:

Testing.m - This code snippet shows the working of the extrapolation and hysteresis removal function for a single graph.

FY_SA.m - This is the full code that is used for comparison of tire forces and slip angle with respect to parameters like pressure, camber etc.  

FY_FZ.m - This is the full code that is used for comparison of tire forces in Y and z direction with respect to parameters like pressure, camber etc.  

atishay_expl_hyrem- This is a function that is called by FY_SA before final plotting, and it's explanation has been done in the report.

Links for detailed reports on:

> Nondimensional Tire Model using polyfit [Link](https://drive.google.com/file/d/1jYjMH7PbPFt6Tv5G5_PQuLvQQEWMOhIQ/view?usp=sharing)

> Extrapolation and Hysteresis removal [Link](https://drive.google.com/file/d/1Qa_OCf1i4bTmyxxmkvUNVZRkXDOW2QLv/view?usp=sharing)
