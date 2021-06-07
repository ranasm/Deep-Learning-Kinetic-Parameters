# Deep-Learning-Kinetic-Parameters

This project involves developing a neural network (NN) to predict the four rate constants of the 11C-PIB radiotracer for a sample of blood data and time activity curves (TACs) of 5 different brain regions: parietal cortex, frontal cortex, cerebellum, pons, and subcortical white matter

The Neural Network architecture is defined as follows: 
  - Input layer: 84 neurons and tanh activation function was used
  - 2nd layer: 42 neurons and sigmoid activation
  - 3rd layer: 21 neurons and tanh activation
  - 4th layer: 10 neurons and ReLU activation
  - Output layer:  4 neurons and sigmoid activation. Note, there are four neurons for each kinetic parameter (ie k1, k2, k3, k4)
