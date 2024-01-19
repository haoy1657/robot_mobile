function [matrice_s] = S(vecteur)

x=vecteur(1);
y=vecteur(2);
z=vecteur(3);

matrice_s=[0 -z y
           z 0  -x
           -y x 0];

end