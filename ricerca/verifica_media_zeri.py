"""Diagnostica numerica per la formula di trasporto delle pendenze.

Non dimostra il teorema: confronta il calcolo diretto di Laplace con la
somma sui primi zeri per A(t)=(1-t*t)*(1+c*t), -1 <= t <= 1, c=1/5.
La moltiplicazione dell'area per pi non modifica zeri o rapporti.
Si usa soltanto la libreria standard di Python.
"""

import cmath
import math


C = 0.2
A = 2 * (1 - C)
B = 2 * (1 + C)
GAMMA = math.log(B / A) / 2


def transform_numerator_and_derivative(z):
    """Restituisce H=-z^2 F(z) e H'; gli zeri non nulli sono quelli di F."""
    sine, cosine = cmath.sin(z), cmath.cos(z)
    e_minus, e_plus = cmath.exp(-1j * z), cmath.exp(1j * z)
    j0 = 2 * sine / z
    j0_prime = 2 * (z * cosine - sine) / z**2
    j1 = 2j * (sine - z * cosine) / z**2
    j1_prime = 2j * (sine / z - 2 * (sine - z * cosine) / z**3)
    value = A * e_minus + B * e_plus - 2 * j0 - 6 * C * j1
    derivative = -1j * A * e_minus + 1j * B * e_plus - 2 * j0_prime - 6 * C * j1_prime
    return value, derivative


def numerical_root(m):
    z = (2 * m + 1) * math.pi / 2 + 1j * GAMMA
    for _ in range(30):
        value, derivative = transform_numerator_and_derivative(z)
        step = value / derivative
        next_z = z - step
        if abs(step) < max(1e-12, 4 * math.ulp(z.real)) or next_z == z:
            return next_z
        z = next_z
    raise ArithmeticError(f"Newton non converge per m={m}")


def pair_log_ratio(z, tau):
    x, y = z.real, z.imag
    plus = x * x + (tau + y)**2
    return math.log1p(-4 * tau * y / plus)


def pair_contribution(z, tau):
    x, y = z.real, z.imag
    minus = x * x + (tau - y)**2
    plus = x * x + (tau + y)**2
    ratio_log = math.log1p(-4 * tau * y / plus)
    derivative = 4 * y * (tau * tau - x * x - y * y) / (minus * plus)
    return ratio_log - tau * derivative


def exponential_moment(k, tau):
    """Integrale esatto di s^k exp(-tau*s) su [0,2], salvo arrotondamenti."""
    tail = math.exp(-2 * tau) * sum((2 * tau)**j / math.factorial(j) for j in range(k + 1))
    return math.factorial(k) / tau**(k + 1) * (1 - tail)


def direct_laplace(tau, differentiated=True):
    lower = (0, A, 3 * C - 1, -C)
    upper = (0, B, -1 - 3 * C, C)
    lo = sum(c * exponential_moment(k, tau) for k, c in enumerate(lower))
    hi = sum(c * exponential_moment(k, tau) for k, c in enumerate(upper))
    if not differentiated:
        return math.log(lo / hi)
    lo_moment = sum(c * exponential_moment(k + 1, tau) for k, c in enumerate(lower))
    hi_moment = sum(c * exponential_moment(k + 1, tau) for k, c in enumerate(upper))
    return math.log(lo / hi) - tau * (-lo_moment / lo + hi_moment / hi)


def main():
    count = 10000
    roots = [numerical_root(m) for m in range(1, count + 1)]
    print("Diagnostica numerica, non certificazione della dimostrazione.")
    print(f"Pendenze: a={A}, b={B}; limite atteso log(a/b)={math.log(A/B):.12f}")
    print(f"Zeri calcolati: {count}; gamma asintotica={GAMMA:.12f}")
    print("tau    J da Laplace       somma sui primi zeri    differenza")
    for tau in (20, 100, 500):
        direct = direct_laplace(tau)
        spectral = sum(pair_contribution(z, tau) for z in roots)
        print(f"{tau:3d}  {direct: .12f}    {spectral: .12f}     {spectral-direct:+.3e}")
    print("Formula semplificata senza derivate: B da Laplace e somma dei logaritmi.")
    print("L'ultima colonna aggiunge una stima integrale della coda del modello asintotico.")
    print("tau    B da Laplace       somma troncata          scarto con coda stimata")
    for tau in (20, 100, 500):
        direct = direct_laplace(tau, differentiated=False)
        spectral = sum(pair_log_ratio(z, tau) for z in roots)
        model_tail = -4 * GAMMA / math.pi * math.atan(tau / (math.pi * (count + 1)))
        print(f"{tau:3d}  {direct: .12f}    {spectral: .12f}     {spectral+model_tail-direct:+.3e}")
    print("Controllo con differenze finite: H(tau)=D(2*tau)-2*D(tau).")
    print("tau    H da Laplace       somma troncata          differenza")
    for tau in (20, 100, 500):
        direct = direct_laplace(2 * tau, False) - 2 * direct_laplace(tau, False)
        spectral = sum(pair_log_ratio(z, 2 * tau) - 2 * pair_log_ratio(z, tau) for z in roots)
        print(f"{tau:3d}  {direct: .12f}    {spectral: .12f}     {spectral-direct:+.3e}")
    print("La somma troncata omette la coda; Newton non certifica che siano tutti gli zeri.")


if __name__ == "__main__":
    main()
