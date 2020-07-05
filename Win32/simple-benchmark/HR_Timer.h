// HR_Timer.h: Timer-Class

#ifndef _HR_TIMER_
#define _HR_TIMER_

/////////////
// Headers //
/////////////

#include <cstdio>
#include <Windows.h>

//////////////////////
// Class definition //
//////////////////////

class HR_Timer
{
	public:
		// Constructor
		inline HR_Timer();

		// Operators
		inline __int64 Now(void);
		inline __int64 Reset(void);
		__forceinline __int64 operator()() { return this->Now(); }
 
	private:
		// Current clock function
		inline __int64 CLK(void);

		// Internal Variables
		LARGE_INTEGER T;
		bool HRTimer;
		__int64 frequency;
		__int64 start;

};

///////////////
// Functions //
///////////////

// Constructor
inline HR_Timer::HR_Timer()
{
	// Query timer frequency
	this->HRTimer = (QueryPerformanceFrequency(&T) != 0);
	if(this->HRTimer)
		this->frequency = T.QuadPart;

	// Start first meassurement
	this->start = this->CLK();
}

// Current Timer
inline __int64 HR_Timer::Now()
{
	return (this->HRTimer) ? ((this->CLK()-this->start)*1000/this->frequency) : (this->CLK()-this->start);
}

// Reset and report meassurement
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
