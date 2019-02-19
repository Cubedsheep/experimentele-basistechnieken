import numpy as np
import scipy.stats as nst
import scipy.optimize as opt
#
# hulpfuncties voor de fit-functie
#

# functie die de Least-squares functie uitrekent
# f is de te fitten functie, x en y de gemeten waardes met sigma de fout op
# y (normaal verdeeld). theta zijn de parameters voor f 
# die geoptimaliseerd moeten worden
def LS(theta, f, x, y, sigma):
    return sum([(y[i] - f(x[i], *theta))**2/sigma[i]**2 for i in range(len(x))])

# minimaliseert de least-squares functie om de optimale 
# parameters theta voor f te vinden
# zodat f een zo goed mogelijke fit is door de datapunten (x_i, y_i)
def find_theta(f, theta0, x, y, sigma):
    return opt.minimize(LS, theta0, args=(f, x, y, sigma))

# de functie die van LS een functie maakt in 1 variabele, -val zodat de punten
# waar LS gelijk is aan val nulpunten worden
def LS_i(t, LS, theta, index, val, kwargs):
    dt = np.zeros_like(theta)
    dt[index] = t
    return LS(theta+dt, **kwargs) - val

# zoekt de standaardafwijkingen op theta_index in de functie chi
# van de minimale waarde chi(theta)
def find_sigma(chi, theta, index, f, x, y, sigma, delta, val):
    # los de vergelijking op
    args = (chi, theta, index, val, {"f": f, "x": x, "y": y, "sigma": sigma})
    dt1 = opt.fsolve(LS_i, delta, args=args)
    dt2 = opt.fsolve(LS_i, -delta, args=args)
    return (dt2, dt1)

# ------------------------------------------------------------------------------
# de fit functie

# fit de functie f door de datapunten (x_i, y_i) met fout dy op y 
# met de least-squares methode. theta0 is een eerste gok voor de parameters
# van f. delta is een gok op de procentuele afwijking
# van de gefitte parameters (array met zelfde dimensies als theta0)
def fit(f, x, y, dy, theta0, delta):
    # zoek de optimale waarde voor theta
    theta = find_theta(f=f, theta0=theta0, x=x, y=y, sigma=dy)
    minimum = theta['fun']
    # bereken de fout op theta
    sigma = [find_sigma(LS, theta['x'], index=i, f=f, x=x, y=y, sigma=dy, 
                        delta=delta[i]*theta['x'][i], val=minimum+1)\
             for i in range(len(theta['x']))]
    
    # bereken de p-waarde van de fit
    vrijheid = len(x)-len(theta0)
    p = 1-nst.chi2.cdf(theta['fun'], vrijheid)
    return {'param' : theta['x'], 'stdv' : sigma, 'p' : p, 'chi2' : theta['fun']}