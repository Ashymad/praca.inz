## Analiza porównawcza wybranych cech pakietów obliczeniowych w perspektywie ogólnoakustycznej

# Abstrakt

W środowisku naukowym najpopularniejszym pakietem obliczeniowym jest
MATLAB, jest on głównym narzędziem stosowanym do programowych
obliczeń numerycznych związanych z dziedzinami akustyki, takimi jak
przetwarzanie sygnałów, akustyka teoretyczna, czy mechanika układów
wibroakustycznych. Najpopularniejsze  pakiety oferujące podobną
funkcjonalność to: Anaconda, GNU Octave, Julia i Scilab, wszystkie
otwartoźródłowe i darmowe. Porównano funkcjonalność i możliwości jej
poszerzenia w danym pakiecie oraz najważniejsze cechy języka
programowania w nim używanego. Przygotowano system do automatycznego
testowania czasu wykonywanych obliczeń, po czym wykorzystano go do
przeprowadzenia testów na dwóch platformach: komputerze stacjonarnym
ze starszym procesorem AMD i laptopie z nowszym procesorem Intel.
Wykonano testy funkcji bibliotecznych do obliczania sinusa, szybkiej
transformaty Fouriera (FFT), splotu i wczytywania plików typu
_WAV_, ponadto przeprowadzono test funkcji własnej będącej
implementacja algorytmu FFT Cooleya-Tukeya. W wynikach, żaden
z badanych pakietów nie uzyskał przeważającej przewagi nad
pozostałymi, w każdym teście było inaczej, lecz średnio najszybsze
okazały się: Anaconda, MATLAB i Julia. Biorąc całość badań pod uwagę
wywnioskowano, że najlepszą alternatywą dla MATLABa jest Anaconda
z powodu podobnej prędkości obliczeń i bardzo dużej funkcjonalności, 
choć niepodobnego języka programowania.

# Summary

In the field of science and engineering MATLAB is the most popular
numerical computing environment, it is very often used in fields
of study connected with acoustics, such as signal processing,
theoretical acoustics or mechanics of vibroacoustic systems. The most
popular packages that offer similar functionality are: Anaconada,
GNU Octave, Julia and Scilab, all of them open source and free.
Funcionality and possibility of expanding it as well as programming
language used was compared between these packages. A system for
automatic testing of execution time was written and used to conduct
tests on two computers: a PC with an older AMD CPU and a notebook
with a newer Intel CPU. Tests of library functions for computing
sine, fast Fourier transform (FFT), convolution and loading
of _WAV_ files were conducted, furthermore a test of an
implementation of Cooley-Tukey FFT algorithm was conducted as well. 
None of the studied packages was the fastest in all of the tests,
in each one of them the results were different, but on average
Anaconda, MATLAB and Julia were the fastest. Taking the whole
study into consideration, it was concluded, that the best alternative
to MATLAB is, despite its very different programming language, Anaconda,
thanks to its wide range of funcionality and comparable speed.
