# Deep-Learning-Kinetic-Parameters

## Overview

This project involves developing a neural network (NN) to predict the pharmacokinetic rate constants of the 11C-PIB radiotracer. Blood activity data and tissue activity curves (TACs) for 5 different brain regions (parietal cortex, frontal cortex, cerebellum, pons, and subcortical white matter) were simulated, along with the ground truth rate constants.

The blood data and TACs were each sampled at 42 time points (ie total input features are 84 dimensional), consisting of 10x5 second scans, 7x10 second scans, 4x30 second scans, 3x2 minute scans, 15x5 minute and 3x10 minute scans. 

The final neural network architecture is defined as follows: 
  - Input layer: 84 neurons and tanh activation function was used
  - 2nd layer: 42 neurons and sigmoid activation
  - 3rd layer: 21 neurons and tanh activation
  - 4th layer: 10 neurons and ReLU activation
  - Output layer:  4 neurons and sigmoid activation. Note, there are four neurons for each kinetic parameter (ie k1, k2, k3, k4)

## Dataset

The input features (ie sampled TAC and blood activity data) are contained in the TAC150.csv, while the ground truth kinetic rate constants are located in RateConstants150.csv. 

Note the training data were generated artificically in a manner where TAC and blood data were sampled from a distribution centered on mean activity values specific to the radio tracer of interest. For more information on the script used to generate the data, please view "TACGenerator.m". Users interested in running the script will need a program called COMKAT (http://comkat.case.edu/index.php?title=Home)

## Getting Started





