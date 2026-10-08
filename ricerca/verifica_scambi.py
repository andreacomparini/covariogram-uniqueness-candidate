"""Controlli esatti per la nota sul covariogramma del 2026-10-08.

Non costituiscono una verifica formale dei teoremi: verificano le identita
polinomiali e le disuguaglianze numeriche usate nelle dimostrazioni.
Solo libreria standard; eseguibile con Python 3.
"""

from fractions import Fraction as F
from math import acos, cos, pi, sin, sqrt


def add(a, b):
    out = [F(0)] * max(len(a), len(b))
    for i, x in enumerate(a):
        out[i] += x
    for i, x in enumerate(b):
        out[i] += x
    return out


def scale(a, c):
    return [c * x for x in a]


def mul(a, b):
    out = [F(0)] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i + j] += x * y
    return out


def deriv(a):
    return [i * a[i] for i in range(1, len(a))] or [F(0)]


def value(a, x):
    total = F(0)
    for c in reversed(a):
        total = total * x + c
    return total


def same(a, b):
    return all(x == 0 for x in add(a, scale(b, -1)))


def main():
    z = [F(0), F(1)]
    p3 = [F(0), F(-3, 2), F(0), F(5, 2)]
    laplace = add(mul([F(1), F(0), F(-1)], deriv(deriv(p3))),
                  scale(mul(z, deriv(p3)), -2))
    assert same(laplace, scale(p3, -12))
    q_parallel = add(p3, scale(mul(z, deriv(p3)), -1))
    q_meridian = add(q_parallel,
                     mul([F(1), F(0), F(-1)], deriv(deriv(p3))))
    assert same(q_parallel, [F(0), F(0), F(0), F(-5)])
    assert same(q_meridian, [F(0), F(15), F(0), F(-20)])
    assert same(add(q_parallel, q_meridian), scale(p3, -10))
    # Integral_a^1 z P3(z) dz = a^3/5 when a^2=3/5.
    a2 = F(3, 5)
    assert (1 - a2) / 2 == F(1, 5)

    psi = [F(0)] * 4 + [F(35), F(-84), F(70), F(-20)]
    dpsi = scale(mul([F(0), F(0), F(0), F(1)],
                     [F(1), F(-3), F(3), F(-1)]), 140)
    assert same(deriv(psi), dpsi)
    assert value(psi, F(0)) == 0 and value(psi, F(1)) == 1
    for order in range(1, 4):
        psi = deriv(psi)
        assert value(psi, F(0)) == value(psi, F(1)) == 0, order

    c, d, eps_max = F(9, 10), F(19, 20), F(1, 100000)
    width = d - c
    grad_bound = F(35, 16) / width
    hess_bound = F(105, 4) / width**2 + grad_bound
    convexity_margin = (1 - eps_max)**2 - (1 + eps_max) * eps_max * hess_bound
    assert grad_bound == F(175, 4)
    assert hess_bound == F(42175, 4)
    assert convexity_margin == F(35781657829, 40000000000) > 0
    delta = eps_max / 2
    assert (1 - delta) / (1 + delta) > d
    # The coordinate bound for all unwanted convolution summands is negative.
    assert (1 + eps_max)**2 * (1 - c*c) < (1 - eps_max)**2 * c*c

    # Exact certification of annulus separation without floating-point trig:
    # cos(pi/4-theta)=(9+sqrt(19))/(10 sqrt(2)) < 19/20.
    # Squaring reduces to sqrt(19)<161/36, checked below.
    assert F(19) < F(161, 36)**2
    assert F(19, 10) + 2*eps_max < 2*(1-eps_max)
    # sin(pi/4-theta)=(9-sqrt(19))/(10 sqrt(2)) > 3/10.
    # A simple rational certification uses sqrt(19)<22/5 and sqrt(2)<3/2.
    assert F(19) < F(22, 5)**2
    assert F(2) < F(3, 2)**2
    assert (F(9)-F(22, 5))/(10*F(3, 2)) > F(3, 10)
    assert F(3, 5)-2*eps_max > 0

    theta = acos(float(c))
    inner = 2*sin(pi/4-theta) - 2*float(eps_max)
    outer = 2*cos(pi/4-theta) + 2*float(eps_max)
    print("Tutti i controlli esatti sono superati.")
    print("Margine di convessita >=", convexity_margin)
    print("Margine decimale:", float(convexity_margin))
    print("Raggio interno della corona:", inner)
    print("Raggio esterno della corona:", outer)
    print("Raggio della palla comune nei corpi differenza:", 2*(1-float(eps_max)))
    print("Separazione esplicita a x=(1,1,0): g_K-g_L <= -pi*epsilon^3/6.")
    print("Vettore della calotta per h=1-epsilon*P3:",
          "8*pi*epsilon*(3/5)^(3/2) e_3; coefficiente =", 8*pi*(3/5)**1.5)


if __name__ == "__main__":
    main()
