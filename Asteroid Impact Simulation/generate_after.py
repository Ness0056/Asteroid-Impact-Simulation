import numpy as np
import subprocess
import os

# data from before.pov
m_ast = 1.0
m_met = 0.027
M = m_ast + m_met

r = np.array([0.333, 0.465, 1.333])
v = np.array([-0.450, -0.015, -0.161])

I = np.diag([0.686, 0.726, 0.213])

# conserved momenta
P = m_met * v
L0 = np.cross(r, P)

VCM = P / M

print("P =", P)
print("L =", L0)
print("VCM =", VCM)

def Rx(a):
    return np.array([
        [1, 0, 0],
        [0, np.cos(a), -np.sin(a)],
        [0, np.sin(a), np.cos(a)]
    ])

def Ry(a):
    return np.array([
        [np.cos(a), 0, np.sin(a)],
        [0, 1, 0],
        [-np.sin(a), 0, np.cos(a)]
    ])

def Rz(a):
    return np.array([
        [np.cos(a), -np.sin(a), 0],
        [np.sin(a), np.cos(a), 0],
        [0, 0, 1]
    ])

def write_transforma(R, pos):
    # after.pov reads columns:
    values = [
        R[0,0], R[1,0], R[2,0],
        R[0,1], R[1,1], R[2,1],
        R[0,2], R[1,2], R[2,2],
        pos[0], pos[1], pos[2]
    ]

    with open("transforma.dat", "w") as f:
        f.write(", ".join(f"{x:.6f}" for x in values))

os.makedirs("framesafter", exist_ok=True)

R = np.eye(3)
pos = np.zeros(3)

dt = 1.0
nframes = 250

for frame in range(nframes):
    write_transforma(R, pos)
    if frame in [0, 1, 2]:
        import shutil
        shutil.copy("transforma.dat", f"my_transforma{frame}.dat")
    subprocess.run([
        "povray",
        "+Iafter.pov",
        f"+Oframesafter/after{frame:03d}.png",
        "+W800",
        "+H600"
    ])

    # update position
    pos = pos + VCM * dt

    # angular velocity in moving frame
    w = np.linalg.inv(I) @ (R.T @ L0)

    wx, wy, wz = w

    # accurate rotation update from guide2
    Rm = Rx(wx*dt/2) @ Ry(wy*dt/2) @ Rz(wz*dt) @ Ry(wy*dt/2) @ Rx(wx*dt/2)

    # update orientation
    R = R @ Rm
