## Prezentacja

Witam Szanowną Komisję i Szanownych Panów Promotorów, nazywam się Szymon Mikulicz.
Tytuł mojej pracy to _analiza porównawcza wybranych cech pakietów obliczeniowych w perspektywie ogólnoakustycznej_,
pracę pisałem pod nadzorem doktora Bartłomieja Borkowskiego.

1. Wprowadzenie

   Pakiety obliczeniowe są narzędziem stosowanym bardzo częśto w wszlaekigo rodzaju inżynierii, szczególnie w zagandnienach
   związanych z akustyką znajdują one duże zastosowanie w obliczeaniu i symulacji układów akustycznych czy mechanicznach,
   a przede wszystkim w przetwarzaniu sygnałów wibroakusycznych w celu ich analizy.

   Cele mojej pracy było przybliżenie i porównanie możliwości najpopularniejszych pakietów stosowanych do tych
   celów oraz przeprowadzenie testów badających czas wykonywania obliczeń proccedur związanych z szeroko pojętą
   akustyką.

   Wybrałem pięć pakietów, kierując się popularnością oraz możliwościami w dziedzinie cyfrowego przetwarzania sygnałów,
   są to: MATLAB, Anaconda, JuliaPro, GNU Octave i Scilab. Poza MATLABem, wszystkie są na licencji wolnego oprogramowania.
   Teraz je krótko opiszę.

2. Badane pakiety: MATLAB

   MATLAB jest najstarszym językiem i najstarszym pakietem z badanych. Jest również najpopularniejszym pakietem
   obliczeniowym w środowisku naukowym, a jego język jest drugim najpopularniejszym językiem programowania z
   badanych. Dzięki temu prosto jest znaleźć publikację i gotowe rozwiązania do tego pakietu, ponadto jego
   możliwości można zwiększać, dokupjąc biblioteki grupujące funkcjonalność z różnych dziedzin nauki, takich
   jak choćny przetwarzanie sygnałów. Nazywane są one toolboxami. Ponadto w serwisie File Exchenge znajduje się
   mnogość funkcji napisanych przez użytkowników. Jago składnia, kórej przykład jest na slajdzie, jest skonstruwana
   w taki sposób, by przypominać
   zapis matematyczny, by pozwolić  prosto przetłumaczyć formuły matematyczne na jego język. Ponadto w przeciwieństwie
   do pozostałych pakietów interfejs graficzny MATLABa jest niezwykle rozbudowany i pozwala wykonywać operacje
   takie jak pojektowanie filtrów, czy modyfikacja wyglądu wykresów wyłącznie za pomocą tego interfejsu.

3. Badane pakiety: GNU Octave

   Drugim poc względem wieku jest GNU Octave. Został on stworzony jako bezpośrednia alternatywa dla MATLABA.
   Jest rozwijany jako częśc systemu operacjynego GNU (z tąd GNU w nazwie) przez wolontariuszy. Doży on
   do pełnej kompatybiolności składniowej z MATLABem, tak by skrypty z MATLABA można było bez problemu 
   uruchumić w Octave. W dużej mierze jest to możliwe, większość podstawowych funkcji MATLABa jest zaimplementowana.
   Ponadto Octave dodaje własne elementy składniowe które można wykorzystaćm, tracąc jednak kompatybilność z
   MATLABem wtedy, na slajdzie pokazana jest funkcja która wykorzystuje jesen z tych elementów -- czyli
   pasujące końce bloków kodu -- endif do if, endfor do for.
   Podobnie jak w MATLABie funkcjonalość jest rozszerzana przez biblioteki, które są odpowiednikami toolboxów.
   Znajdują się one w repozytorium Octave-Forge, skąd można je pobrać. Wiele z nich nie jest aż tak rozbudowana
   jak odpowiedniki z MATLABa. Octave posiada mało rozbudowane środowisko graficzne, podobne w wyglądzie do MATLABa.

4. Badane pakiety: Scilab

   Scilab 
6. Proces badawczy

   Badania przeprowadziłem na dwóch komputerach, na stosunkowo nowym laptopie z precesorem Intel i dyskiem półprzewodnikowym SSD
   oraz na starszym kopmuterze stacjonarnym z procesorem AMD i dyskiem twardym. By zmiejszyć wpływ innych procesów, które
   w tym samym czasie co badany, mogłyby wykorzystać zasoby komputera, zainstalowałem na tych kopmuterach minimalny
   system GNU/Linux z jądrem RTLinux. RTLinux to specjalnie zmodyfikowane jądro linuxa, głównie do zastosowań w systemach
   czasu rzeczywistego. To jądro posiada taką właściwość, że proces może uzyska dostęp do zasobów kopmutera przed nim,
   jeżeli posiada odpowiednio wysoki priorytet.

   By można było wygodnie powtarzać testy, napisałem skrypty który automatycznie je wykonywały w każdym z testowanych pakietów,
   napisane został tak, by z łatwością można było dodać więcej testów i więcej pakietów w przyszłości. Testy przeprowadziłem
   dla różnych wielkości wektorów wejściowych, w zależności od testu od dzisięciu do dziesieć do potęgi piątej albo ósmej.
   Każdy test został uruchomiony stukrotnie.

   Testowanych funkcji wybrałem pięć, w tym cztery funkcje bibilioteczne: szybką transformatę fouriera, splot, sinus i wczytywanie
   plików audio oraz jedną funkcję własną. Jako funkcję własną wykorzystałem implementację algorytmu Cooleya-Turkeya z
   książki _Numerical Recipes in C_, oryginalnie napisaną w języku C, którą przepisałem na każdy z testowanych języków,
   dodatkowo wykorzystjąc natywny typ liczb zespolonych w badanych pakietach, bo w C go nie ma.

7. Wnioski

   Wybrane funkcjie nie rozstrzygają jednoznacznie, który z badanych pakietów jest najszybszy, w każdym z testów inne pakiety
   wykonywały procedurę w najkrótszym czasie. Pakietem, który poradził sobie najgorzej był Scilab.  W każdym z testów był on
   najgorszy albo drugi od końca.
