From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Tracepoints for pthreads conditional variables
Date: Thu, 5 Jul 2018 17:36:30 -0400
Message-ID: <CAC-H6tv5KPAYwg_ZxjUva95g2wZpZm8Oi_Q5Pve+Ow4jDcGfxw__31042.2352901243$1530826474$gmane$org@mail.gmail.com>
References: <CAC-H6tv29C9RdoquefmAs6s-kM6o-RyYFMAYF1a1Vqk0PYX9dQ@mail.gmail.com>
 <20180501143953.GA26829@joraj-alpa>
 <CAC-H6tuewaghma5hN3R2iCGvpcYVMph1uwti3u0+1ZhZEn44-A@mail.gmail.com>
 <CAC-H6tu3wfE-LJWCTL8+rggLkyJ75yjMEmi=rWGsWspWkaaoGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4033726996488534406=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x233.google.com (mail-lf0-x233.google.com
 [IPv6:2a00:1450:4010:c07::233])
 by lists.lttng.org (Postfix) with ESMTPS id 41MB4w2z9Fz1B1R
 for <lttng-dev@lists.lttng.org>; Thu,  5 Jul 2018 17:36:32 -0400 (EDT)
Received: by mail-lf0-x233.google.com with SMTP id m12-v6so8120439lfc.10
 for <lttng-dev@lists.lttng.org>; Thu, 05 Jul 2018 14:36:32 -0700 (PDT)
In-Reply-To: <CAC-H6tu3wfE-LJWCTL8+rggLkyJ75yjMEmi=rWGsWspWkaaoGg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4033726996488534406==
Content-Type: multipart/alternative; boundary="000000000000275dea05704757d6"

--000000000000275dea05704757d6
Content-Type: text/plain; charset="UTF-8"

Any suggestions where I should investigate to fix this bug? Also, please
let me know whether the git repo I shared is sufficient.

Thanks,
Shehab

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Tue, May 29, 2018 at 10:36 AM, Shehab Elsayed <shehabyomn@gmail.com>
wrote:

> I was wondering if you had a chance to look over this issue. Thanks!
>
> Shehab Y. Elsayed, MSc.
> PhD Student
> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> University of Toronto
> E-mail: shehabyomn@gmail.com
> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>
> On Thu, May 3, 2018 at 4:37 PM, Shehab Elsayed <shehabyomn@gmail.com>
> wrote:
>
>> Thanks for the reply. Here is a link to the repo
>> https://github.com/ShehabElsayed/LTTng_debugging.git
>>
>> It contains the LTTng source code I am using and one of the benchmarks
>> that is causing problems.
>>
>> Shehab Y. Elsayed, MSc.
>> PhD Student
>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>> University of Toronto
>> E-mail: shehabyomn@gmail.com
>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>
>> On Tue, May 1, 2018 at 10:39 AM, Jonathan Rajotte-Julien <
>> jonathan.rajotte-julien@efficios.com> wrote:
>>
>>> Hi Shehab,
>>>
>>> Please provide a link to a lttng-ust git tree or an actual patch (git
>>> format-patch).
>>> This will help any person who might be interested in helping you
>>> including
>>> myself.
>>>
>>> Cheers
>>>
>>> On Tue, May 01, 2018 at 09:31:52AM -0400, Shehab Elsayed wrote:
>>> > Hi,
>>> >
>>> > I am trying to create wrappers for pthreads conditional variables
>>> functions
>>> > (wait, signal and broadcast) to insert tracepoints. I followed the same
>>> > approach done for the mutex functions already provided with lttng,
>>> however
>>> > I am running into some problems. Mainly the applications seem to get
>>> stuck
>>> > when the conditional variable wrappers are enabled.
>>> >
>>> > Here is my implementation for the wrapper functions:
>>> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
>>> > *mutex)
>>> >
>>> > {
>>> >
>>> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t
>>> > *);
>>> >   int retval;
>>> >
>>> >
>>> >
>>> >   if (!cond_wait)
>>> > {
>>> >
>>> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>>> >
>>> >     if (!cond_wait)
>>> > {
>>> >
>>> >       if (thread_in_trace)
>>> > {
>>> >
>>> >
>>> > abort();
>>> >
>>> >
>>> > }
>>> >
>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>> > library.\n");
>>> >       return EINVAL;
>>> >
>>> >
>>> > }
>>> >
>>> >
>>> > }
>>> >
>>> >   if (thread_in_trace)
>>> > {
>>> >
>>> >     return cond_wait(condition, mutex);
>>> >
>>> >
>>> > }
>>> >
>>> >
>>> >
>>> >   thread_in_trace =
>>> > 1;
>>> >
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
>>> > mutex,
>>> >
>>> >     LTTNG_UST_CALLER_IP());
>>> >
>>> >   retval = cond_wait(condition, mutex);
>>> >
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
>>> > mutex,
>>> >
>>> >     LTTNG_UST_CALLER_IP());
>>> >
>>> >   thread_in_trace =
>>> > 0;
>>> >
>>> >   return retval;
>>> >
>>> > }
>>> >
>>> >
>>> >
>>> > int pthread_cond_signal(pthread_cond_t
>>> > *condition)
>>> >
>>> > {
>>> >
>>> >   static int (*cond_signal)(pthread_cond_t
>>> > *);
>>> >
>>> >   int retval;
>>> >
>>> >
>>> >
>>> >   if (!cond_signal)
>>> > {
>>> >
>>> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>>> >
>>> >     if (!cond_signal)
>>> > {
>>> >
>>> >       if (thread_in_trace)
>>> > {
>>> >
>>> >
>>> > abort();
>>> >
>>> >
>>> > }
>>> >
>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>> > library.\n");
>>> >       return EINVAL;
>>> >
>>> >
>>> > }
>>> >
>>> >
>>> > }
>>> >
>>> >   if (thread_in_trace)
>>> > {
>>> >
>>> >     return cond_signal(condition);
>>> >
>>> >
>>> > }
>>> >
>>> >
>>> >
>>> >   thread_in_trace =
>>> > 1;
>>> >
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin,
>>> > condition,
>>> >     LTTNG_UST_CALLER_IP());
>>> >
>>> >   retval = cond_signal(condition);
>>> >
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end,
>>> > condition,
>>> >     LTTNG_UST_CALLER_IP());
>>> >
>>> >   thread_in_trace =
>>> > 0;
>>> >
>>> >   return retval;
>>> >
>>> > }
>>> >
>>> >
>>> >
>>> > int pthread_cond_broadcast(pthread_cond_t
>>> > *condition)
>>> >
>>> > {
>>> >
>>> >   static int (*cond_broadcast)(pthread_cond_t
>>> > *);
>>> >   int retval;
>>> >
>>> >
>>> >
>>> >   if (!cond_broadcast)
>>> > {
>>> >
>>> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>>> >
>>> >     if (!cond_broadcast)
>>> > {
>>> >
>>> >       if (thread_in_trace)
>>> > {
>>> >
>>> >
>>> > abort();
>>> >
>>> >
>>> > }
>>> >
>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>> > library.\n");
>>> >       return EINVAL;
>>> >
>>> >
>>> > }
>>> >
>>> >
>>> > }
>>> >
>>> >   if (thread_in_trace)
>>> > {
>>> >
>>> >     return cond_broadcast(condition);
>>> >
>>> >
>>> > }
>>> >
>>> >
>>> >
>>> >   thread_in_trace =
>>> > 1;
>>> >
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
>>> > condition,
>>> >     LTTNG_UST_CALLER_IP());
>>> >
>>> >   retval = cond_broadcast(condition);
>>> >
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end,
>>> > condition,
>>> >     LTTNG_UST_CALLER_IP());
>>> >
>>> >   thread_in_trace =
>>> > 0;
>>> >
>>> >   return retval;
>>> >
>>> > }
>>> >
>>> > Things I have tried:
>>> > 1- Comment out pthread_cond_wait function --> segmentation fault
>>> > 2- Comment out pthread_cond_signal and _broadcast --> stuck (I can see
>>> the
>>> > program is still running but nor forward progress is being made)
>>> compared
>>> > to the case when the wrappers are not preloaded.
>>> > 3- Comment out all tracepoint related code (basically the wrapper just
>>> call
>>> > the corresponding pthreads function) --> same results as points 1 and
>>> 2.
>>> >
>>> > Any idea what might be causing this or how I could debug this problem?
>>> >
>>> > Thank you very much in advance.
>>> >
>>> > Best Regards,
>>> > Shehab
>>>
>>> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
>>> *mutex)
>>> > {
>>>
>>>
>>>
>>> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t *);
>>>
>>> >   int retval;
>>>
>>> >
>>>
>>> >   if (!cond_wait) {
>>>
>>> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>>>
>>> >     if (!cond_wait) {
>>>
>>> >       if (thread_in_trace) {
>>>
>>> >         abort();
>>>
>>> >       }
>>>
>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>> library.\n");
>>> >       return EINVAL;
>>>
>>> >     }
>>>
>>> >   }
>>>
>>> >   if (thread_in_trace) {
>>>
>>> >     return cond_wait(condition, mutex);
>>>
>>> >   }
>>>
>>> >
>>>
>>> >   thread_in_trace = 1;
>>>
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
>>> mutex,
>>> >     LTTNG_UST_CALLER_IP());
>>>
>>> >   retval = cond_wait(condition, mutex);
>>>
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
>>> mutex,
>>> >     LTTNG_UST_CALLER_IP());
>>>
>>> >   thread_in_trace = 0;
>>>
>>> >   return retval;
>>>
>>> > }
>>>
>>> >
>>>
>>> > int pthread_cond_signal(pthread_cond_t *condition)
>>>
>>> > {
>>>
>>> >   static int (*cond_signal)(pthread_cond_t *);
>>>
>>> >   int retval;
>>>
>>> >
>>>
>>> >   if (!cond_signal) {
>>>
>>> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>>>
>>> >     if (!cond_signal) {
>>>
>>> >       if (thread_in_trace) {
>>>
>>> >         abort();
>>>
>>> >       }
>>>
>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>> library.\n");
>>> >       return EINVAL;
>>>
>>> >     }
>>>
>>> >   }
>>>
>>> >   if (thread_in_trace) {
>>>
>>> >     return cond_signal(condition);
>>>
>>> >   }
>>>
>>> >
>>>
>>> >   thread_in_trace = 1;
>>>
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin, condition,
>>>
>>> >     LTTNG_UST_CALLER_IP());
>>>
>>> >   retval = cond_signal(condition);
>>>
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end, condition,
>>>
>>> >     LTTNG_UST_CALLER_IP());
>>>
>>> >   thread_in_trace = 0;
>>>
>>> >   return retval;
>>>
>>> > }
>>>
>>> >
>>>
>>> > int pthread_cond_broadcast(pthread_cond_t *condition)
>>>
>>> > {
>>>
>>> >   static int (*cond_broadcast)(pthread_cond_t *);
>>>
>>> >   int retval;
>>>
>>> >
>>>
>>> >   if (!cond_broadcast) {
>>>
>>> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>>>
>>> >     if (!cond_broadcast) {
>>>
>>> >       if (thread_in_trace) {
>>>
>>> >         abort();
>>>
>>> >       }
>>>
>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>> library.\n");
>>> >       return EINVAL;
>>>
>>> >     }
>>>
>>> >   }
>>>
>>> >   if (thread_in_trace) {
>>>
>>> >     return cond_broadcast(condition);
>>>
>>> >   }
>>>
>>> >
>>>
>>> >   thread_in_trace = 1;
>>>
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
>>> condition,
>>> >     LTTNG_UST_CALLER_IP());
>>>
>>> >   retval = cond_broadcast(condition);
>>>
>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end,
>>> condition,
>>> >     LTTNG_UST_CALLER_IP());
>>>
>>> >   thread_in_trace = 0;
>>>
>>> >   return retval;
>>>
>>> > }
>>>
>>> > _______________________________________________
>>> > lttng-dev mailing list
>>> > lttng-dev@lists.lttng.org
>>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>> --
>>> Jonathan Rajotte-Julien
>>> EfficiOS
>>>
>>
>>
>

--000000000000275dea05704757d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5Bbnkgc3VnZ2VzdGlvbnMgd2hlcmUgSSBzaG91bGQgaW52ZXN0
aWdhdGUgdG8gZml4IHRoaXMgYnVnPyBBbHNvLCBwbGVhc2UgbGV0IG1lIGtub3cgd2hldGhlciB0
aGUgZ2l0IHJlcG8gSSBzaGFyZWQgaXMgc3VmZmljaWVudC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PlRoYW5rcyw8L2Rpdj48ZGl2PlNoZWhhYjxicj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9leHRyYSI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0
dXJlIiBkYXRhLXNtYXJ0bWFpbD0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48Zm9u
dCBjb2xvcj0iIzg4ODg4OCI+U2hlaGFiIFkuIEVsc2F5ZWQsIE1TYy48YnI+DQpQaEQgU3R1ZGVu
dDxicj5UaGUgRWR3YXJkcyBTLiBSb2dlcnMgU3IuIERlcHQuIG9mIEVsZWN0cmljYWwgYW5kIENv
bXB1dGVyIEVuZ2luZWVyaW5nPGJyPlVuaXZlcnNpdHkgb2YgVG9yb250byA8L2ZvbnQ+PGZvbnQg
Y29sb3I9IiM4ODg4ODgiPjxhIHZhbHVlPSIrMjAxMjQ0OTgzNjAiPjxzcGFuIGRpcj0ibHRyIj48
L3NwYW4+PC9hPjxicj4NCkUtbWFpbDogPGEgaHJlZj0iaHR0cHM6Ly93ZWJtYWlsLnJpY2UuZWR1
L2ltcC9tZXNzYWdlLnBocD9tYWlsYm94PUlOQk9YJmFtcDtpbmRleD0xMSMiIHRhcmdldD0iX2Js
YW5rIj5zaGVoYWJ5b21uQGdtYWlsLmNvbTwvYT48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9kaXY+DQo8
YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFR1ZSwgTWF5IDI5LCAyMDE4IGF0IDEwOjM2
IEFNLCBTaGVoYWIgRWxzYXllZCA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpz
aGVoYWJ5b21uQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnNoZWhhYnlvbW5AZ21haWwuY29t
PC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5JIHdhcyB3b25kZXJpbmcgaWYgeW91IGhhZCBh
IGNoYW5jZSB0byBsb29rIG92ZXIgdGhpcyBpc3N1ZS4gVGhhbmtzITxicj48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9leHRyYSI+PHNwYW4gY2xhc3M9IiI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGRp
diBjbGFzcz0ibV8tODI3OTQ3NDkyMjYxNDA0NzU5Z21haWxfc2lnbmF0dXJlIiBkYXRhLXNtYXJ0
bWFpbD0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48Zm9udCBjb2xvcj0iIzg4ODg4
OCI+U2hlaGFiIFkuIEVsc2F5ZWQsIE1TYy48YnI+DQpQaEQgU3R1ZGVudDxicj5UaGUgRWR3YXJk
cyBTLiBSb2dlcnMgU3IuIERlcHQuIG9mIEVsZWN0cmljYWwgYW5kIENvbXB1dGVyIEVuZ2luZWVy
aW5nPGJyPlVuaXZlcnNpdHkgb2YgVG9yb250byA8L2ZvbnQ+PGZvbnQgY29sb3I9IiM4ODg4ODgi
PjxhIHZhbHVlPSIrMjAxMjQ0OTgzNjAiPjxzcGFuIGRpcj0ibHRyIj48L3NwYW4+PC9hPjxicj4N
CkUtbWFpbDogPGEgaHJlZj0iaHR0cHM6Ly93ZWJtYWlsLnJpY2UuZWR1L2ltcC9tZXNzYWdlLnBo
cD9tYWlsYm94PUlOQk9YJmFtcDtpbmRleD0xMSMiIHRhcmdldD0iX2JsYW5rIj5zaGVoYWJ5b21u
QGdtYWlsLmNvbTwvYT48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9kaXY+DQo8YnI+PC9zcGFuPjxkaXY+
PGRpdiBjbGFzcz0iaDUiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIE1heSAzLCAy
MDE4IGF0IDQ6MzcgUE0sIFNoZWhhYiBFbHNheWVkIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOnNoZWhhYnlvbW5AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+c2hlaGFieW9t
bkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+VGhhbmtzIGZvciB0
aGUgcmVwbHkuIEhlcmUgaXMgYSBsaW5rIHRvIHRoZSByZXBvIDxhIGhyZWY9Imh0dHBzOi8vZ2l0
aHViLmNvbS9TaGVoYWJFbHNheWVkL0xUVG5nX2RlYnVnZ2luZy5naXQiIHRhcmdldD0iX2JsYW5r
Ij5odHRwczovL2dpdGh1Yi5jb20vU2hlaGFiRWxzYXk8d2JyPmVkL0xUVG5nX2RlYnVnZ2luZy5n
aXQ8L2E+PGJyPjxicj48L2Rpdj5JdCBjb250YWlucyB0aGUgTFRUbmcgc291cmNlIGNvZGUgSSBh
bSB1c2luZyBhbmQgb25lIG9mIHRoZSBiZW5jaG1hcmtzIHRoYXQgaXMgY2F1c2luZyBwcm9ibGVt
cy48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxiciBjbGVhcj0iYWxsIj48ZGl2
PjxkaXYgY2xhc3M9Im1fLTgyNzk0NzQ5MjI2MTQwNDc1OW1fLTU1Njk5NzA1NTA2NjY0MDY1MjBn
bWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGly
PSJsdHIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij5TaGVoYWIgWS4gRWxzYXllZCwgTVNjLjxicj4N
ClBoRCBTdHVkZW50PGJyPlRoZSBFZHdhcmRzIFMuIFJvZ2VycyBTci4gRGVwdC4gb2YgRWxlY3Ry
aWNhbCBhbmQgQ29tcHV0ZXIgRW5naW5lZXJpbmc8YnI+VW5pdmVyc2l0eSBvZiBUb3JvbnRvIDwv
Zm9udD48Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGEgdmFsdWU9IisyMDEyNDQ5ODM2MCI+PHNwYW4g
ZGlyPSJsdHIiPjwvc3Bhbj48L2E+PGJyPg0KRS1tYWlsOiA8YSBocmVmPSJodHRwczovL3dlYm1h
aWwucmljZS5lZHUvaW1wL21lc3NhZ2UucGhwP21haWxib3g9SU5CT1gmYW1wO2luZGV4PTExIyIg
dGFyZ2V0PSJfYmxhbmsiPnNoZWhhYnlvbW5AZ21haWwuY29tPC9hPjwvZm9udD48L2Rpdj48L2Rp
dj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9Im1fLTgyNzk0NzQ5MjI2MTQwNDc1OWg1Ij4NCjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBNYXkgMSwgMjAxOCBhdCAxMDozOSBBTSwg
Sm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWls
dG86am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+
am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWM8d2JyPmlvcy5jb208L2E+Jmd0Ozwvc3Bhbj4g
d3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhp
IFNoZWhhYiw8YnI+DQo8YnI+DQpQbGVhc2UgcHJvdmlkZSBhIGxpbmsgdG8gYSBsdHRuZy11c3Qg
Z2l0IHRyZWUgb3IgYW4gYWN0dWFsIHBhdGNoIChnaXQgZm9ybWF0LXBhdGNoKS48YnI+DQpUaGlz
IHdpbGwgaGVscCBhbnkgcGVyc29uIHdobyBtaWdodCBiZSBpbnRlcmVzdGVkIGluIGhlbHBpbmcg
eW91IGluY2x1ZGluZzxicj4NCm15c2VsZi48YnI+DQo8YnI+DQpDaGVlcnM8YnI+DQo8ZGl2Pjxk
aXYgY2xhc3M9Im1fLTgyNzk0NzQ5MjI2MTQwNDc1OW1fLTU1Njk5NzA1NTA2NjY0MDY1MjBoNSI+
PGJyPg0KT24gVHVlLCBNYXkgMDEsIDIwMTggYXQgMDk6MzE6NTJBTSAtMDQwMCwgU2hlaGFiIEVs
c2F5ZWQgd3JvdGU6PGJyPg0KJmd0OyBIaSw8YnI+DQomZ3Q7IDxicj4NCiZndDsgSSBhbSB0cnlp
bmcgdG8gY3JlYXRlIHdyYXBwZXJzIGZvciBwdGhyZWFkcyBjb25kaXRpb25hbCB2YXJpYWJsZXMg
ZnVuY3Rpb25zPGJyPg0KJmd0OyAod2FpdCwgc2lnbmFsIGFuZCBicm9hZGNhc3QpIHRvIGluc2Vy
dCB0cmFjZXBvaW50cy4gSSBmb2xsb3dlZCB0aGUgc2FtZTxicj4NCiZndDsgYXBwcm9hY2ggZG9u
ZSBmb3IgdGhlIG11dGV4IGZ1bmN0aW9ucyBhbHJlYWR5IHByb3ZpZGVkIHdpdGggbHR0bmcsIGhv
d2V2ZXI8YnI+DQomZ3Q7IEkgYW0gcnVubmluZyBpbnRvIHNvbWUgcHJvYmxlbXMuIE1haW5seSB0
aGUgYXBwbGljYXRpb25zIHNlZW0gdG8gZ2V0IHN0dWNrPGJyPg0KJmd0OyB3aGVuIHRoZSBjb25k
aXRpb25hbCB2YXJpYWJsZSB3cmFwcGVycyBhcmUgZW5hYmxlZC48YnI+DQomZ3Q7IDxicj4NCiZn
dDsgSGVyZSBpcyBteSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIHdyYXBwZXIgZnVuY3Rpb25zOjxi
cj4NCiZndDsgaW50IHB0aHJlYWRfY29uZF93YWl0KHB0aHJlYWRfY29uZDx3YnI+X3QgKmNvbmRp
dGlvbiwgcHRocmVhZF9tdXRleF90PGJyPg0KJmd0OyAqbXV0ZXgpPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHN0YXRpYyBpbnQgKCpjb25kX3dhaXQpKHB0
aHJlYWRfY29uZF90ICosIHB0aHJlYWRfbXV0ZXhfdDxicj4NCiZndDsgKik7PGJyPg0KJmd0O8Kg
IMKgaW50IHJldHZhbDs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgwqBpZiAoIWNvbmRfd2FpdCk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oCDCoGNvbmRfd2FpdCA9IGRsc3ltKFJUTERfTkVYVCwgJnF1b3Q7cHRocmVhZF9jb25kX3dhaXQm
cXVvdDspOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgaWYgKCFjb25kX3dhaXQpPGJyPg0K
Jmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAodGhyZWFkX2luX3RyYWNl
KTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGFib3J0KCk7PGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKg
IMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O3VuYWJsZSB0byBpbml0aWFsaXplIHB0aHJlYWQg
d3JhcHBlcjxicj4NCiZndDsgbGlicmFyeS5cbiZxdW90Oyk7PGJyPg0KJmd0O8KgIMKgIMKgIMKg
cmV0dXJuIEVJTlZBTDs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0
OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgaWYgKHRo
cmVhZF9pbl90cmFjZSk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoHJl
dHVybiBjb25kX3dhaXQoY29uZGl0aW9uLCBtdXRleCk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oHRocmVhZF9pbl90cmFjZSA9PGJyPg0KJmd0OyAxOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKg
dHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX3dhaXRfYmVnaW4sIGNv
bmRpdGlvbiw8YnI+DQomZ3Q7IG11dGV4LDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgTFRU
TkdfVVNUX0NBTExFUl9JUCgpKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHJldHZhbCA9IGNv
bmRfd2FpdChjb25kaXRpb24sIG11dGV4KTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRyYWNl
cG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF93YWl0X2VuZCwgY29uZGl0aW9u
LDxicj4NCiZndDsgbXV0ZXgsPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1Rf
Q0FMTEVSX0lQKCkpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID08
YnI+DQomZ3Q7IDA7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqByZXR1cm4gcmV0dmFsOzxicj4N
CiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0K
Jmd0OyBpbnQgcHRocmVhZF9jb25kX3NpZ25hbChwdGhyZWFkX2NvPHdicj5uZF90PGJyPg0KJmd0
OyAqY29uZGl0aW9uKTxicj4NCiZndDsgPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgwqBzdGF0aWMgaW50ICgqY29uZF9zaWduYWwpKHB0aHJlYWRfY29uZF90PGJyPg0KJmd0OyAq
KTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoGludCByZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgaWYgKCFjb25kX3NpZ25hbCk8YnI+DQomZ3Q7
IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoGNvbmRfc2lnbmFsID0gZGxzeW0oUlRMRF9O
RVhULCAmcXVvdDtwdGhyZWFkX2NvbmRfc2lnbmFsJnF1b3Q7KTs8YnI+DQomZ3Q7IDxicj4NCiZn
dDvCoCDCoCDCoGlmICghY29uZF9zaWduYWwpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7wqAgwqAgwqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKTxicj4NCiZndDsgezxicj4NCiZndDsg
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGFib3J0KCk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4N
CiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZx
dW90O3VuYWJsZSB0byBpbml0aWFsaXplIHB0aHJlYWQgd3JhcHBlcjxicj4NCiZndDsgbGlicmFy
eS5cbiZxdW90Oyk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgcmV0dXJuIEVJTlZBTDs8YnI+DQomZ3Q7
IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsg
fTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgaWYgKHRocmVhZF9pbl90cmFjZSk8YnI+DQomZ3Q7
IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoHJldHVybiBjb25kX3NpZ25hbChjb25kaXRp
b24pOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZn
dDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4NCiZndDsg
MTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQs
IHB0aHJlYWRfY29uZF9zaWduYWxfYmVnaW4sPGJyPg0KJmd0OyBjb25kaXRpb24sPGJyPg0KJmd0
O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oHJldHZhbCA9IGNvbmRfc2lnbmFsKGNvbmRpdGlvbik7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAg
wqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRfc2lnbmFsX2VuZCw8
YnI+DQomZ3Q7IGNvbmRpdGlvbiw8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQ
KCkpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID08YnI+DQomZ3Q7
IDA7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqByZXR1cm4gcmV0dmFsOzxicj4NCiZndDsgPGJy
Pg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBpbnQg
cHRocmVhZF9jb25kX2Jyb2FkY2FzdChwdGhyZWFkPHdicj5fY29uZF90PGJyPg0KJmd0OyAqY29u
ZGl0aW9uKTxicj4NCiZndDsgPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBz
dGF0aWMgaW50ICgqY29uZF9icm9hZGNhc3QpKHB0aHJlYWRfY29uZDx3YnI+X3Q8YnI+DQomZ3Q7
ICopOzxicj4NCiZndDvCoCDCoGludCByZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4N
CiZndDsgPGJyPg0KJmd0O8KgIMKgaWYgKCFjb25kX2Jyb2FkY2FzdCk8YnI+DQomZ3Q7IHs8YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoGNvbmRfYnJvYWRjYXN0ID0gZGxzeW0oUlRMRF9ORVhU
LCAmcXVvdDtwdGhyZWFkX2NvbmRfYnJvYWRjYXN0JnF1b3Q7KTs8YnI+DQomZ3Q7IDxicj4NCiZn
dDvCoCDCoCDCoGlmICghY29uZF9icm9hZGNhc3QpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKTxicj4NCiZndDsgezxicj4NCiZn
dDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGFib3J0KCk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIs
ICZxdW90O3VuYWJsZSB0byBpbml0aWFsaXplIHB0aHJlYWQgd3JhcHBlcjxicj4NCiZndDsgbGli
cmFyeS5cbiZxdW90Oyk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgcmV0dXJuIEVJTlZBTDs8YnI+DQom
Z3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgfTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgaWYgKHRocmVhZF9pbl90cmFjZSk8YnI+DQom
Z3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoHJldHVybiBjb25kX2Jyb2FkY2FzdChj
b25kaXRpb24pOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxi
cj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4N
CiZndDsgMTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0
aHJlYWQsIHB0aHJlYWRfY29uZF9icm9hZGNhc3RfYmVnaW4sPGJyPg0KJmd0OyBjb25kaXRpb24s
PGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTs8YnI+DQomZ3Q7IDxicj4N
CiZndDvCoCDCoHJldHZhbCA9IGNvbmRfYnJvYWRjYXN0KGNvbmRpdGlvbik7PGJyPg0KJmd0OyA8
YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRf
YnJvYWRjYXN0X2VuZCw8YnI+DQomZ3Q7IGNvbmRpdGlvbiw8YnI+DQomZ3Q7wqAgwqAgwqBMVFRO
R19VU1RfQ0FMTEVSX0lQKCkpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3Ry
YWNlID08YnI+DQomZ3Q7IDA7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqByZXR1cm4gcmV0dmFs
Ozxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFRoaW5ncyBJIGhh
dmUgdHJpZWQ6PGJyPg0KJmd0OyAxLSBDb21tZW50IG91dCBwdGhyZWFkX2NvbmRfd2FpdCBmdW5j
dGlvbiAtLSZndDsgc2VnbWVudGF0aW9uIGZhdWx0PGJyPg0KJmd0OyAyLSBDb21tZW50IG91dCBw
dGhyZWFkX2NvbmRfc2lnbmFsIGFuZCBfYnJvYWRjYXN0IC0tJmd0OyBzdHVjayAoSSBjYW4gc2Vl
IHRoZTxicj4NCiZndDsgcHJvZ3JhbSBpcyBzdGlsbCBydW5uaW5nIGJ1dCBub3IgZm9yd2FyZCBw
cm9ncmVzcyBpcyBiZWluZyBtYWRlKSBjb21wYXJlZDxicj4NCiZndDsgdG8gdGhlIGNhc2Ugd2hl
biB0aGUgd3JhcHBlcnMgYXJlIG5vdCBwcmVsb2FkZWQuPGJyPg0KJmd0OyAzLSBDb21tZW50IG91
dCBhbGwgdHJhY2Vwb2ludCByZWxhdGVkIGNvZGUgKGJhc2ljYWxseSB0aGUgd3JhcHBlciBqdXN0
IGNhbGw8YnI+DQomZ3Q7IHRoZSBjb3JyZXNwb25kaW5nIHB0aHJlYWRzIGZ1bmN0aW9uKSAtLSZn
dDsgc2FtZSByZXN1bHRzIGFzIHBvaW50cyAxIGFuZCAyLjxicj4NCiZndDsgPGJyPg0KJmd0OyBB
bnkgaWRlYSB3aGF0IG1pZ2h0IGJlIGNhdXNpbmcgdGhpcyBvciBob3cgSSBjb3VsZCBkZWJ1ZyB0
aGlzIHByb2JsZW0/PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggaW4g
YWR2YW5jZS48YnI+DQomZ3Q7IDxicj4NCiZndDsgQmVzdCBSZWdhcmRzLDxicj4NCiZndDsgU2hl
aGFiPGJyPg0KPGJyPg0KJmd0OyBpbnQgcHRocmVhZF9jb25kX3dhaXQocHRocmVhZF9jb25kPHdi
cj5fdCAqY29uZGl0aW9uLCBwdGhyZWFkX211dGV4X3QgKm11dGV4KcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4NCiZndDsge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgc3RhdGljIGludCAoKmNvbmRfd2FpdCkocHRocmVhZF9jb25kX3QgKiwgcHRocmVh
ZF9tdXRleF90ICopO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKg
aW50IHJldHZhbDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICghY29uZF93YWl0KSB7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBjb25kX3dh
aXQgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJlYWRfY29uZF93YWl0JnF1b3Q7KTvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBp
ZiAoIWNvbmRfd2FpdCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
O8KgIMKgIMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoGFib3J0KCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgZnByaW50
ZihzdGRlcnIsICZxdW90O3VuYWJsZSB0byBpbml0aWFsaXplIHB0aHJlYWQgd3JhcHBlciBsaWJy
YXJ5LlxuJnF1b3Q7KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoHJldHVybiBFSU5W
QUw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgfcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KJmd0O8KgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgaWYgKHRocmVhZF9pbl90cmFjZSkge8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoHJldHVybiBjb25kX3dh
aXQoY29uZGl0aW9uLCBtdXRleCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB9wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAxO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0
aHJlYWQsIHB0aHJlYWRfY29uZF93YWl0X2JlZ2luLCBjb25kaXRpb24sIG11dGV4LMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqByZXR2YWwgPSBjb25kX3dhaXQoY29uZGl0aW9uLCBtdXRl
eCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhy
ZWFkX2NvbmRfd2FpdF9lbmQsIGNvbmRpdGlvbiwgbXV0ZXgswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0
O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9IDA7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7IH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDxicj4NCiZndDsgaW50IHB0aHJlYWRfY29uZF9zaWduYWwocHRocmVhZF9jbzx3YnI+bmRfdCAq
Y29uZGl0aW9uKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDxicj4NCiZndDsge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgc3RhdGljIGludCAoKmNvbmRfc2ln
bmFsKShwdGhyZWFkX2NvbmRfdCAqKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqBpbnQgcmV0dmFsO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgaWYgKCFjb25kX3NpZ25hbCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgY29uZF9zaWduYWwgPSBkbHN5bShSVExEX05F
WFQsICZxdW90O3B0aHJlYWRfY29uZF9zaWduYWwmcXVvdDspO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoGlmICghY29uZF9zaWduYWwpIHvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoGlmICh0aHJl
YWRfaW5fdHJhY2UpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqBhYm9ydCgpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4NCiZndDvCoCDCoCDCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAm
cXVvdDt1bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXIgbGlicmFyeS5cbiZxdW90
Oyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoH3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29uZF9z
aWduYWwoY29uZGl0aW9uKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqB9wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAxO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0
bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF9zaWduYWxfYmVnaW4sIGNvbmRpdGlvbizCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqByZXR2YWwgPSBjb25kX3Np
Z25hbChjb25kaXRpb24pO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQo
bHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF9zaWduYWxfZW5kLCBjb25kaXRpb24swqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQ
KCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3Ry
YWNlID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqBy
ZXR1cm4gcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4NCiZndDsgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyBpbnQgcHRo
cmVhZF9jb25kX2Jyb2FkY2FzdChwdGhyZWFkPHdicj5fY29uZF90ICpjb25kaXRpb24pwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IHvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDxicj4NCiZndDvCoCDCoHN0YXRpYyBpbnQgKCpjb25kX2Jyb2FkY2FzdCkocHRocmVhZF9jb25k
PHdicj5fdCAqKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoGludCByZXR2YWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBp
ZiAoIWNvbmRfYnJvYWRjYXN0KSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0K
Jmd0O8KgIMKgIMKgY29uZF9icm9hZGNhc3QgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJl
YWRfY29uZF9icm9hZGNhc3QmcXVvdDspO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4N
CiZndDvCoCDCoCDCoGlmICghY29uZF9icm9hZGNhc3QpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKSB7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgYWJvcnQoKTvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqAgwqB9wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7dW5hYmxlIHRvIGluaXRpYWxp
emUgcHRocmVhZCB3cmFwcGVyIGxpYnJhcnkuXG4mcXVvdDspO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgcmV0dXJuIEVJTlZBTDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB9wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgPGJyPg0KJmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfYnJvYWRjYXN0KGNvbmRpdGlvbik7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAxO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRf
Y29uZF9icm9hZGNhc3RfYmVnaW4sIGNvbmRpdGlvbizCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgcmV0dmFsID0gY29uZF9icm9hZGNhc3QoY29uZGl0aW9uKTvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRf
Y29uZF9icm9hZGNhc3RfZW5kLCBjb25kaXRpb24swqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0
O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9IDA7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7IH3CoCDCoCDCoDxicj4NCjxicj4N
CjwvZGl2PjwvZGl2PiZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPHdicj5fX19f
X19fX19fX19fX19fXzxicj4NCiZndDsgbHR0bmctZGV2IG1haWxpbmcgbGlzdDxicj4NCiZndDsg
PGEgaHJlZj0ibWFpbHRvOmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmciIHRhcmdldD0iX2JsYW5r
Ij5sdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPC9hPjxicj4NCiZndDsgPGEgaHJlZj0iaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldiIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpPHdicj5uL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxicj4NCjxzcGFuIGNsYXNz
PSJtXy04Mjc5NDc0OTIyNjE0MDQ3NTltXy01NTY5OTcwNTUwNjY2NDA2NTIwSE9FblpiIj48Zm9u
dCBjb2xvcj0iIzg4ODg4OCI+PGJyPg0KPGJyPg0KLS0gPGJyPg0KSm9uYXRoYW4gUmFqb3R0ZS1K
dWxpZW48YnI+DQpFZmZpY2lPUzxicj4NCjwvZm9udD48L3NwYW4+PC9ibG9ja3F1b3RlPjwvZGl2
Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj4NCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9k
aXY+PC9kaXY+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pg0K
--000000000000275dea05704757d6--

--===============4033726996488534406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4033726996488534406==--
