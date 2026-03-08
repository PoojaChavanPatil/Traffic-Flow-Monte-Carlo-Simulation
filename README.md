# Traffic Flow Model on 101 Freeway Using Monte Carlo Simulation

## Overview

A numerical simulation of traffic flow dynamics on a **1-mile section of the 101 Freeway** using Monte Carlo methods and the Euler method for position updates. Developed as part of **Math 748 (Numerical Analysis)** at San Francisco State University.

The model simulates how vehicles interact, adjust speeds based on spacing, and how traffic density evolves over time — providing insights into congestion patterns and flow behavior.

---

## Methodology

1. **Road Setup** — 1-mile freeway section with vehicles initialized at random positions
2. **Speed Model** — Vehicle speeds determined by spacing to the car ahead (Monte Carlo randomization)
3. **Position Updates** — Euler method used to update vehicle positions at each time step
4. **Boundary Conditions** — Vehicles exiting the section are replaced by new ones entering
5. **Density Analysis** — Traffic density and flow rates computed at each simulation step

---

## Key Features

- **Monte Carlo process** for stochastic speed updates based on vehicle spacing
- **Euler method** numerical integration for position tracking
- **Real-time visualization** of traffic flow patterns and density
- **Speed distribution analysis** across the simulated freeway section
- Configurable parameters: number of vehicles, simulation time, road length

---

## Simulation Parameters

| Parameter | Value |
|-----------|-------|
| Road Length | 1 mile |
| Time Steps | Configurable |
| Speed Model | Spacing-dependent with Monte Carlo noise |
| Integration Method | Forward Euler |

---

## Tech Stack

- **MATLAB** — Simulation engine, numerical computation, and visualization

## Files

- `Final_Project_File.m` — Main MATLAB simulation script
- `Traffic Flow Model on 101 Freeway using Monte Carlo Simulation.pdf` — Full project report with methodology and conclusions

## Course

**Math 748 — Numerical Analysis** | San Francisco State University

## Author

**Pooja Chavanpatil** — MS in Statistical Data Science, San Francisco State University
