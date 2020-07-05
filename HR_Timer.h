// HR_Timer.h: Timer-Klasse

#ifndef _HR_TIMER_
#define _HR_TIMER_

////////////
// Header //
////////////

#include <cstdio>
#include <Windows.h>

///////////////////////////
// Klassenimplementation //
///////////////////////////

class HR_Timer
{
	public:
		// Standartfunktionen
		inline HR_Timer();							// Standart Konstruktor

		// Operatoren
		inline __int64 Now(void);					// Aktueller Zeitpunkt
		inline __int64 Reset(void);					// Zeitpunkt zurücksetzen
		__forceinline __int64 operator()() { return this->Now(); }
 
	private:
		// Aktueller Zeitpunkt
		inline __int64 CLK(void);					// Clock

		// Variablen
		LARGE_INTEGER T;							// HR-Timer Datenstruktur
		bool HRTimer;								// Typ des Timers
		__int64 frequency;							// Frequenz
		__int64 start;								// Referenzzeitpunkt

};

////////////////
// Funktionen //
////////////////

// Konstruktor
inline HR_Timer::HR_Timer()
{
	// Frequenz und Timer herausfinden
	this->HRTimer = (QueryPerformanceFrequency(&T) != 0);
	if(this->HRTimer)
		this->frequency = T.QuadPart;

	// Erste Messung
	this->start = this->CLK();
}

// aktuelle Zeit
inline __int64 HR_Timer::Now()
{
	return (this->HRTimer) ? ((this->CLK()-this->start)*1000/this->frequency) : (this->CLK()-this->start);
}

// Messung zurücksetzen
inline __int64 HR_Timer::Reset()
{
	__int64 time = this->CLK() - this->start;
	this->start += time;
	return (this->HRTimer) ? (time*1000/this->frequency) : time;
}

// Clock
inline __int64 HR_Timer::CLK()
{
	if(this->HRTimer) {
		DWORD_PTR threadmask = SetThreadAffinityMask(GetCurrentThread(), 0);
		QueryPerformanceCounter(&T);
		SetThreadAffinityMask(GetCurrentThread(), threadmask);
		return T.QuadPart;
	}
	else {
		#ifdef WIN32
			return (__int64)GetTickCount();
		#else
			return GetTickCount64();
		#endif
	}
}

#endif
