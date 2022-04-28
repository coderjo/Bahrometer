# TRON file format

This is a definition of the file format of the .tron files used by the game.

The four .tron files in the game have 256 neurons on the input layer (for a 16x16 pixel input), one hidden layer with
268 neurons, and an output layer with 10 or 11 neurons (contining no weights, as there are no further layers). Only
the output layer neurons have names.

All multi-byte values are little endian.

## FILE

| Type   | Count | Typical value | Description |
| :---   | ----: | ------------: | :---------- |
| byte   |     1 |     6 | format ID or version number |
| bool   |     1 |  true | Whether the function to convert input gesture strokes into activation values is continuous (true) or discontinuous (false) |
| bool   |     1 |  true | Whether the conversion function reduces the input space to encompass only the active area |
| bool   |     1 |  true | Whether to make the active area of the input square |
| bool   |     1 | false | Whether to center the input. |
| LAYER  |     1 |       | Input layer |
| LAYER  |     1 |       | Output layer |
| uint32 |     1 |       | Hidden layer count (nHid) |
| LAYER  | nHid  |       | Hidden layers |

## LAYER

| Type   | Count | Description |
| :----- | ----: | :---------- |
| uint32 |     1 | Number of neurons in this layer (nNeu) |
| NEURON | nNeu  | The data for each neuron of this layer  |

## NEURON

| Type   |    Count | Desciption |
| :----- | -------: | :--------- |
| uint16 |        1 | The number of bytes in the name of this neuron (nLen) |
| char   |    nLen  | The name of this neuron. (Most are unnamed. Only the output layer has names) |
| byte   |        1 | The function used to smooth the activation of a neuron. (0-4. Existing files only use 2) |
| uint32 |        1 | The number of weights on this neuron (nWeights). This should match the number of neurons in the next layer |
| float  | nWeights | The weights for this neuron.

Note: There is no neuron bias value.

### Neuron smoothing functions

These are the names used in a function that takes the id number and gives the name as a string.

| ID | Internal name        |
| -: | :------------------- |
| 0  | Step                 |
| 1  | Piecewise Linear     |
| 2  | Logistic Sigmoid     |
| 3  | Hypertangent Sigmoid |
| 4  | Identity             |
| -1 | "Invalid"            |
| xx | "Unknown"            |

#### Type 0: Step

##### Forward:

```python
if x >= 0.5:
	return 1.0
else:
	return 0.0
```

##### Backpropagation

```python
return 0.0
```

#### Type 1: Piecewise Linear

##### Forward:

```python
if x >= 1.0:
	return 1.0
else if x < 0.0:
	return 0.0
else:
	return x
```

##### Backpropagation

```python
return 0.0
```

#### Type 2: Logistic Sigmoid

##### Forward:

```python
return 1.0 / (exp(-x) + 1.0)
```

##### Backpropagation

```python
return (1.0 - x) * x
```

#### Type 3: Hypertangent Sigmoid

##### Forward:

```python
return tanh(x)
```

##### Backpropagation

```python
return 1.0 - tanh(x) * tanh(x)
```

#### Type 4: Identity

##### Forward:

```python
return x
```

##### Backpropagation

```python
return 0.0
```
