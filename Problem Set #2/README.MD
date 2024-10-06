# System Modeling Simulations

This repository contains simulations of three different systems: a mass-spring-damper system, an RLC circuit, and a pendulum system. Each system is modeled and simulated using its respective state space or system equations. The simulations include both visual results in the form of videos and images.

## 1. Mass-Spring-Damper System Simulation

### Overview

The mass-spring-damper system is modeled using second-order differential equations, which are converted into state-space form. The system's response to external inputs such as forces is simulated.

### State Variables
- $(x)$: position of the mass
- $(\dot{x})$ : velocity of the mass

### State Space Form
The state-space representation of the system is as follows:
$$\dot{x} = Ax + Bu$$
$$\begin{bmatrix}x\\ \dot{x}\end{bmatrix} = \begin{bmatrix}0 & 1\\ -\frac{k}{m} & -\frac{c}{m}\end{bmatrix} \begin{bmatrix}x\\ \dot{x}\end{bmatrix} + \begin{bmatrix}0\\ \frac{1}{m}\end{bmatrix} u$$

### System Equation Form
The system is governed by the following second-order equation:
$$m\ddot{x} + c\dot{x} + kx = 0$$

### Results
- **Simulation Video**: 


---

## 2. RLC Circuit Simulation

### Overview
The RLC circuit is modeled using charge and current as state variables. The system's behavior over time is analyzed by solving its state-space representation.

### State Variables
- $(i)$ : current in the circuit
- $(q)$ : charge across the capacitor

### State Space Form
The state-space representation for the RLC circuit is:
$$\dot{x} = Ax + Bu$$
$$\begin{bmatrix}q\\ \dot{q}\end{bmatrix} = \begin{bmatrix}-\frac{1}{RC} & \frac{1}{C}\\ -\frac{1}{L} & 0\end{bmatrix} \begin{bmatrix}q\\ \dot{q}\end{bmatrix} + \begin{bmatrix}0\\ \frac{1}{L}\end{bmatrix} u$$

### System Equation Form
The system is governed by the following second-order equation:
$$L\ddot{q} + R\dot{q} + \frac{1}{C}q = 0$$

### Results
- **Simulation Image**: ![RLC Circuit Simulation](path_to_image)

---

## 3. Pendulum System Simulation

### Overview
The pendulum system is simulated in both **damped** and **undamped** cases. The system is non-linear due to the sine function in the equation of motion. The simulation analyzes the angular displacement and velocity of the pendulum over time.

### State Variables
- $(\theta)$ : angle of the pendulum
- $(\omega)$: angular velocity of the pendulum

### System Equation Form
For the **undamped** pendulum, the equation of motion is:
$$\ddot{\theta} = -\frac{g}{L}\sin(\theta)$$
### Results

#### Undamped Pendulum
- **Simulation Video**: [Link to undamped pendulum video]


#### Damped Pendulum
- **Simulation Video**: [Link to damped pendulum video]



