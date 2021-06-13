from keras.models import Sequential
from keras.layers import Dense, Dropout
import numpy as np
import keras
import math

def preprocess(data):
    mean = np.mean(data)
    variance = np.var(data)

    ret = (data-mean) / variance**.5
    return ret


testing_set = 50
training_set = 70
validation_set = 30
X_dataset = preprocess(np.loadtxt('TAC150.csv', delimiter=','))        # 84 x 150
Y_dataset = np.loadtxt('RateConstants150.csv', delimiter=',')             # 5 x 100

X_training = X_dataset[:training_set, :]
Y_training = Y_dataset[:training_set:, :4]
X_validation = X_dataset[training_set:training_set+validation_set, :]
Y_validation = Y_dataset[training_set:training_set+validation_set, :4]
X_testing = X_dataset[training_set+validation_set:, :]
Y_testing = Y_dataset[training_set+validation_set:, :4]

model = Sequential()
model.add(Dense(84, input_dim=84, activation='tanh'))  # input layer: 2 neurons, each is 1x100
model.add(Dense(49, activation='sigmoid'))  # hidden layer
model.add(Dense(24, activation='tanh'))  # hidden layer
model.add(Dense(12, activation='relu'))
model.add(Dense(4, activation='sigmoid'))   # output: 1x4

rmsprop = keras.optimizers.RMSprop(lr=0.0001, rho=0.9, epsilon=None, decay=0.0)
model.compile(optimizer=rmsprop, loss='mse', metrics=['accuracy'])
# print(X.shape, Y.shape)
model.fit(X_training, Y_training, epochs=1000, batch_size=1, validation_data=(X_validation, Y_validation))

predictions = model.predict(preprocess(X_testing))
#print(predictions)
#print(predictions.tolist())



lPredicted = predictions
lActual = Y_testing
abspercentError = np.mean(np.abs(lActual-lPredicted)/lActual)*100
absk1PercentError = np.mean(np.abs(lActual[:, 0]-lPredicted[:, 0])/lActual[:, 0])*100
absk2PercentError = np.mean(np.abs(lActual[:, 1]-lPredicted[:, 1])/lActual[:, 1])*100
absk3PercentError = np.mean(np.abs(lActual[:, 2]-lPredicted[:, 2])/lActual[:, 2])*100
absk4PercentError = np.mean(np.abs(lActual[:, 3]-lPredicted[:, 3])/lActual[:, 3])*100

percentError = np.mean(np.abs(lActual-lPredicted)/lActual)*100
k1PercentError = np.mean((lActual[:, 0]-lPredicted[:, 0])/lActual[:, 0])*100
k2PercentError = np.mean((lActual[:, 1]-lPredicted[:, 1])/lActual[:, 1])*100
k3PercentError = np.mean((lActual[:, 2]-lPredicted[:, 2])/lActual[:, 2])*100
k4PercentError = np.mean((lActual[:, 3]-lPredicted[:, 3])/lActual[:, 3])*100

print('Total Abs % Error: ', abspercentError)
print('K1 Abs % Error: ', absk1PercentError)
print('K2 Abs % Error: ', absk2PercentError)
print('K3 Abs % Error: ', absk3PercentError)
print('K4 Abs % Error: ', absk4PercentError)

print('Total % Error: ', percentError)
print('K1 % Error: ', k1PercentError)
print('K2 % Error: ', k2PercentError)
print('K3 % Error: ', k3PercentError)
print('K4 % Error: ', k4PercentError)

