clear 
close all 
clc 
    figure(1) 
    potentialfield_Q1_2(1) ; legend("champ attractif de type conique") ; colorbar ;
    hold off ;
    figure(2) 
    potentialfield_Q1_2(2) ; legend("champ attractif de type parabolique") ; colorbar ;
    hold off ;

    figure(3) 
    potentialfield_Q1_2(5) ; legend("champ attractif de type conique+champ repulsif de type exponentiel") ; colorbar ;
    hold off ;
    figure(4)
    potentialfield_Q1_2(6) ; legend("champ attractif de type parabolique+champ repulsif de type hyperbolique") ; colorbar ;
    hold off ;

    figure(5)
    potentialfield_Q3(7) ; 
    legend("champ attractif de type parabolique mobile+champ repulsif de type hyperboliqu mobile")  ;

    hold off ;
    figure(6) 
    potentialfield_Q1_2(7) ; legend("deux minimum local") ; colorbar ;
    hold off ;
