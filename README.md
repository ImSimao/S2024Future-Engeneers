# Team and competition


## Presentation of the AGSG Team
We are the AGSG team, we are students and our name is Joana Silva, Simão Freire and Rafael Teodoro, under the guidance of our mentor Tiago Severino. We have the honour to represent Portugal in the World Robot Olympiad competition, in the Future Engineers category.

![Official Team](https://github.com/user-attachments/assets/388b1cfa-7b0c-4c5d-9003-7b1120306ec6)


## Competition Challenge
The main challenge in this category is to explore the fundamentals of autonomous driving by building a robot in the shape of a car. This robot must be able to navigate autonomously around a defined track, detecting and dodging obstacles, as well as adapting dynamically to the different conditions imposed during the competition.
Autonomous driving is one of the most significant advances in modern engineering, with applications ranging from personal vehicles to public transport solutions. This challenge not only allows us to demonstrate our skills as a team, but also promotes a space for the exchange of ideas and collaborative learning, contributing to joint evolution in the field of engineering.

## Repository Content
- `other` is for other files which can be used to understand how to prepare the vehicle for the competition. It may include documentation how to connect to a SBC/SBM and upload files there, datasets, hardware specifications, communication protocols descriptions etc. If there is nothing to add to this location, the directory can be removed.
- `schemes` contains one or several schematic diagrams in form of JPEG, PNG or PDF of the electromechanical components illustrating all the elements (electronic components and motors) used in the vehicle and how they connect to each other.
- `src` contains code of control software for all components which were programmed to participate in the competition.
- `t-photos` contains 2 photos of the team (an official one and one funny photo with all team members).
- `v-photos` contains 6 photos of the vehicle (from every side, from top and bottom).
- `video` contains the video.md file with the link to a video where driving demonstration exists.
- `models` is for the files for models used by 3D printers, laser cutting machines and CNC machines to produce the vehicle elements. If there is nothing to add to this location, the directory can be removed.



# Robot Description


## Materials used
The structure of our robot is mostly manufactured using 3D printing or recycled components. For the printed parts, we start with prior planning that includes the shape and dimensions required. We then design the parts using the Tinkercad application and carry out a final visualisation in 3D visualisation software to ensure that the specifications meet our needs before printing. Regarding the parts we reuse, one example is the differential of a toy car, which we adapt to the needs of our robot by giving new life to components that would otherwise be discarded.

![Capturar 26](https://github.com/user-attachments/assets/c813aead-fb27-4447-84ae-4cbcdf42a50d) ![Capturar 25](https://github.com/user-attachments/assets/036f537d-59ea-4728-9798-e796a9f77bac)

## Robot Scheme
![esquema do robot](https://github.com/user-attachments/assets/b96c37f0-7cdc-4067-b64e-4a38f48c53ef)

## The code: general
We used two software applications to develop our robot. Most of the programming was done in the PICAXE programming editor application, using the PICAXE Basic language. For the camera, we opted for OpenMV, programming in Python.
We have developed three programmes in PICAXE:
      1.	A general programme that controls the robot's movements on the track, reacting when it detects a can, dodges walls, it also reverses or parks.
      2.	A second programme is responsible for reading the blue and orange lines on the track mat, informing the robot in which direction the lap is being taken (clockwise or anti-clockwise) and when to reverse or park.
      3.	A third program that optimises the vehicle's movement, allowing it to move forwards or backwards, saving programming resources and freeing up space in the general programming for other functionalities.
In Python, we programmed the camera to distinguish the colour of green and red obstacles, sending information to the main programming about the direction the robot should go. It also identifies the colour of the car park walls to locate the correct area.

#### The Code: Setup and Compilation
To program, compile and upload the code to the robot we use the picaxe IDE, which is based in basic. When the IDE is running, it asks for the picaxe version, and the cable port. In our robot we use 4 processors, the main processor is a picaxe 28x2, that handles and runs the main code, two processors are slaves, one picaxe 14M2, for the RGB (red, green and blue)  sensor and line counting and the other slave is a picaxe 28x2 for handling the motors. The last processor is integrated in the camera from OpenMV and is programmed in python.
The processors communicate with each other through bits.
The picaxe IDE can be found at https://www.picaxe.com/ it is also needed to install de drivers so it can recognize the cable used for programming, they can also be found at the picaxe website.

#### The Code: Camera
For the camera we use an OpenMV H7 camera and to program it and calibrate it we use the OpenMV IDE. All the libraries required are present in the OpenMV IDE.
In the beginning of the code we initialize the libraries used for the camera The variable screen_division is used to divide the screen in X sections, for example X=3, the screen will be divided and only the bottom 2/3 of the screen will be used to track the obstacles. Then we initialized the variables green_blobs, red_blobs and pink_blobs. The blobs refer to the colour detected by the camera and their position in the screen. Each bracket represents the colour code seen by the camera, there are a few parameters because of the different angles that the camera can see the obstacles.

![image-1](https://github.com/ImSimao/S2024Future-Engeneers/assets/138500914/9489eefc-0b76-4a14-9abd-41e0db21dbad)

These thresholds can be obtained from the menu tools/machine vision/Threshold Editor.

![image-2](https://github.com/ImSimao/S2024Future-Engeneers/assets/138500914/f75615b1-dae2-49ad-97c5-3d0919cb3b93)

Then we adjust the sliders to track just the object that we want to track.

![image-3](https://github.com/ImSimao/S2024Future-Engeneers/assets/138500914/96aa8b7e-b7df-4072-a21e-eeaf5d4f0a1c)

After getting the colour values, we use the blobs position in the screen to send bits to the main processor indicating if the blobs detected are green or red and if they are on the right, left or in the middle.
We also use 1 bit to indicate if it is seeing the parking spot (looking for the pink colour).

![image-4](https://github.com/ImSimao/S2024Future-Engeneers/assets/138500914/01a50bb5-30b4-47e4-b01a-9622dfa00204)

Sending the bits to the main processor.

![image-5](https://github.com/ImSimao/S2024Future-Engeneers/assets/138500914/27db3bc9-0aad-4b0b-8cb9-a3b1d78d663e)


## Mobility Management
Our vehicle is equipped with four wheels, a motor and a differential, which connects the rear wheels. The front wheels are responsible for steering, controlled by a servo that allows the robot to turn left or right as required. The rear wheels connected to the differential was the configuration developed to solve a problem we faced, guaranteeing an even distribution of torque between the half shafts, enabling them to turn in opposite directions and have a different speed range.

## Energy Management
The robot is powered by four batteries, one of which is a separate power source dedicated specifically to the camera. This approach was implemented to avoid power failures in the camera that would compromise its functionality in distinguishing colours, a challenge we faced during the development of our vehicle.

## Sensors Management
We chose to use a camera to detect obstacles and the car park, equipping it with a lens that widens the field of view, which solved the difficulties in detecting two consecutive obstacles in a corner. In addition, we incorporated three infrared sensors (Sharp) on the front of the robot: one on each side and one in the centre, capable of measuring the distance to objects by emitting and receiving infrared light. To increase the robot's obstacle detection range, we also added a sonar sensor in the centre of the robot, which measures distances by emitting and receiving sound waves. To identify the colours of the blue and orange lines on the carpet, we used an RGB (red, green and blue) colour sensor, which allows the robot to determine the direction of the race and its position on the laps.

## Obstacle Management
With regard to obstacle detection, the robot uses the camera with the magnifying lens to identify obstacles, as well as locating the walls of the car park. We have implemented a strategy that allows the robot to bypass obstacles as soon as it detects them, moving to the right if the obstacle is red and to the left if it is green.

# Conclusion
Summarizing, our experience building and programming the robot for the World Robot Olympiad competition not only challenged us to apply theoretical knowledge to a practical project, but also strengthened the spirit of collaboration and innovation within our team. By integrating technologies such as 3D printing, programming in different languages and sensor management, we were able to create a robot capable of navigating autonomously, adapting to different scenarios. We went through several difficulties, some of which are described in this report, and managed to overcome them all, although with a lot of effort, this is a source of great pride.  We are excited to represent Portugal and look forward in applying everything we have learnt when preparing for this competition.
