From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Tracepoints for pthreads conditional variables
Date: Fri, 26 Apr 2019 16:44:16 -0400
Message-ID: <CAC-H6tvFzQvOz=MWbf9Yx9x5=EOSJRj6TVCwBrBMnNsWCuJ7gQ__27655.158685387$1556311487$gmane$org@mail.gmail.com>
References: <CAC-H6tv29C9RdoquefmAs6s-kM6o-RyYFMAYF1a1Vqk0PYX9dQ@mail.gmail.com>
 <20180501143953.GA26829@joraj-alpa>
 <CAC-H6tuewaghma5hN3R2iCGvpcYVMph1uwti3u0+1ZhZEn44-A@mail.gmail.com>
 <CAC-H6tu3wfE-LJWCTL8+rggLkyJ75yjMEmi=rWGsWspWkaaoGg@mail.gmail.com>
 <CAC-H6tv5KPAYwg_ZxjUva95g2wZpZm8Oi_Q5Pve+Ow4jDcGfxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2762789026380542674=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 by lists.lttng.org (Postfix) with ESMTPS id 44rQyj3hzYz1JtB
 for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2019 16:44:29 -0400 (EDT)
Received: by mail-lf1-x142.google.com with SMTP id w23so3295654lfc.9
 for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2019 13:44:29 -0700 (PDT)
In-Reply-To: <CAC-H6tv5KPAYwg_ZxjUva95g2wZpZm8Oi_Q5Pve+Ow4jDcGfxw@mail.gmail.com>
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

--===============2762789026380542674==
Content-Type: multipart/alternative; boundary="0000000000002fc11e05877500e9"

--0000000000002fc11e05877500e9
Content-Type: text/plain; charset="UTF-8"

I came across something some time ago that I think might solve this
problem. It goes back to making sure that the version of the
synchronization function called from the wrapper is the same that would be
called without the wrapper.

To specify the version the following instruction can be used:
        ....... = dlvsym(RTLD_NEXT, "function_name", "GLIBC_2.3.2")

To know which version is normally used, you can use the following:
        objdump -t <bin_name> | grep <func_name>
where <bin_name> is the name of the program to be run, and <func_name> is
the name of the function to be called from the wrapper.

For more information, check this
link:


http://blog.fesnel.com/blog/2009/08/25/preloading-with-multiple-symbol-versions/

I hope this helps.




On Thu, Jul 5, 2018 at 5:36 PM Shehab Elsayed <shehabyomn@gmail.com> wrote:

> Any suggestions where I should investigate to fix this bug? Also, please
> let me know whether the git repo I shared is sufficient.
>
> Thanks,
> Shehab
>
> Shehab Y. Elsayed, MSc.
> PhD Student
> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> University of Toronto
> E-mail: shehabyomn@gmail.com
> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>
> On Tue, May 29, 2018 at 10:36 AM, Shehab Elsayed <shehabyomn@gmail.com>
> wrote:
>
>> I was wondering if you had a chance to look over this issue. Thanks!
>>
>> Shehab Y. Elsayed, MSc.
>> PhD Student
>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>> University of Toronto
>> E-mail: shehabyomn@gmail.com
>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>
>> On Thu, May 3, 2018 at 4:37 PM, Shehab Elsayed <shehabyomn@gmail.com>
>> wrote:
>>
>>> Thanks for the reply. Here is a link to the repo
>>> https://github.com/ShehabElsayed/LTTng_debugging.git
>>>
>>> It contains the LTTng source code I am using and one of the benchmarks
>>> that is causing problems.
>>>
>>> Shehab Y. Elsayed, MSc.
>>> PhD Student
>>> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
>>> University of Toronto
>>> E-mail: shehabyomn@gmail.com
>>> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>>>
>>> On Tue, May 1, 2018 at 10:39 AM, Jonathan Rajotte-Julien <
>>> jonathan.rajotte-julien@efficios.com> wrote:
>>>
>>>> Hi Shehab,
>>>>
>>>> Please provide a link to a lttng-ust git tree or an actual patch (git
>>>> format-patch).
>>>> This will help any person who might be interested in helping you
>>>> including
>>>> myself.
>>>>
>>>> Cheers
>>>>
>>>> On Tue, May 01, 2018 at 09:31:52AM -0400, Shehab Elsayed wrote:
>>>> > Hi,
>>>> >
>>>> > I am trying to create wrappers for pthreads conditional variables
>>>> functions
>>>> > (wait, signal and broadcast) to insert tracepoints. I followed the
>>>> same
>>>> > approach done for the mutex functions already provided with lttng,
>>>> however
>>>> > I am running into some problems. Mainly the applications seem to get
>>>> stuck
>>>> > when the conditional variable wrappers are enabled.
>>>> >
>>>> > Here is my implementation for the wrapper functions:
>>>> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
>>>> > *mutex)
>>>> >
>>>> > {
>>>> >
>>>> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t
>>>> > *);
>>>> >   int retval;
>>>> >
>>>> >
>>>> >
>>>> >   if (!cond_wait)
>>>> > {
>>>> >
>>>> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>>>> >
>>>> >     if (!cond_wait)
>>>> > {
>>>> >
>>>> >       if (thread_in_trace)
>>>> > {
>>>> >
>>>> >
>>>> > abort();
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>>> > library.\n");
>>>> >       return EINVAL;
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >   if (thread_in_trace)
>>>> > {
>>>> >
>>>> >     return cond_wait(condition, mutex);
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> >
>>>> >   thread_in_trace =
>>>> > 1;
>>>> >
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
>>>> > mutex,
>>>> >
>>>> >     LTTNG_UST_CALLER_IP());
>>>> >
>>>> >   retval = cond_wait(condition, mutex);
>>>> >
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
>>>> > mutex,
>>>> >
>>>> >     LTTNG_UST_CALLER_IP());
>>>> >
>>>> >   thread_in_trace =
>>>> > 0;
>>>> >
>>>> >   return retval;
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> >
>>>> > int pthread_cond_signal(pthread_cond_t
>>>> > *condition)
>>>> >
>>>> > {
>>>> >
>>>> >   static int (*cond_signal)(pthread_cond_t
>>>> > *);
>>>> >
>>>> >   int retval;
>>>> >
>>>> >
>>>> >
>>>> >   if (!cond_signal)
>>>> > {
>>>> >
>>>> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>>>> >
>>>> >     if (!cond_signal)
>>>> > {
>>>> >
>>>> >       if (thread_in_trace)
>>>> > {
>>>> >
>>>> >
>>>> > abort();
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>>> > library.\n");
>>>> >       return EINVAL;
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >   if (thread_in_trace)
>>>> > {
>>>> >
>>>> >     return cond_signal(condition);
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> >
>>>> >   thread_in_trace =
>>>> > 1;
>>>> >
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin,
>>>> > condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>> >
>>>> >   retval = cond_signal(condition);
>>>> >
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end,
>>>> > condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>> >
>>>> >   thread_in_trace =
>>>> > 0;
>>>> >
>>>> >   return retval;
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> >
>>>> > int pthread_cond_broadcast(pthread_cond_t
>>>> > *condition)
>>>> >
>>>> > {
>>>> >
>>>> >   static int (*cond_broadcast)(pthread_cond_t
>>>> > *);
>>>> >   int retval;
>>>> >
>>>> >
>>>> >
>>>> >   if (!cond_broadcast)
>>>> > {
>>>> >
>>>> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>>>> >
>>>> >     if (!cond_broadcast)
>>>> > {
>>>> >
>>>> >       if (thread_in_trace)
>>>> > {
>>>> >
>>>> >
>>>> > abort();
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>>> > library.\n");
>>>> >       return EINVAL;
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >   if (thread_in_trace)
>>>> > {
>>>> >
>>>> >     return cond_broadcast(condition);
>>>> >
>>>> >
>>>> > }
>>>> >
>>>> >
>>>> >
>>>> >   thread_in_trace =
>>>> > 1;
>>>> >
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
>>>> > condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>> >
>>>> >   retval = cond_broadcast(condition);
>>>> >
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end,
>>>> > condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>> >
>>>> >   thread_in_trace =
>>>> > 0;
>>>> >
>>>> >   return retval;
>>>> >
>>>> > }
>>>> >
>>>> > Things I have tried:
>>>> > 1- Comment out pthread_cond_wait function --> segmentation fault
>>>> > 2- Comment out pthread_cond_signal and _broadcast --> stuck (I can
>>>> see the
>>>> > program is still running but nor forward progress is being made)
>>>> compared
>>>> > to the case when the wrappers are not preloaded.
>>>> > 3- Comment out all tracepoint related code (basically the wrapper
>>>> just call
>>>> > the corresponding pthreads function) --> same results as points 1 and
>>>> 2.
>>>> >
>>>> > Any idea what might be causing this or how I could debug this problem?
>>>> >
>>>> > Thank you very much in advance.
>>>> >
>>>> > Best Regards,
>>>> > Shehab
>>>>
>>>> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
>>>> *mutex)
>>>> > {
>>>>
>>>>
>>>>
>>>> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t *);
>>>>
>>>> >   int retval;
>>>>
>>>> >
>>>>
>>>> >   if (!cond_wait) {
>>>>
>>>> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>>>>
>>>> >     if (!cond_wait) {
>>>>
>>>> >       if (thread_in_trace) {
>>>>
>>>> >         abort();
>>>>
>>>> >       }
>>>>
>>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>>> library.\n");
>>>> >       return EINVAL;
>>>>
>>>> >     }
>>>>
>>>> >   }
>>>>
>>>> >   if (thread_in_trace) {
>>>>
>>>> >     return cond_wait(condition, mutex);
>>>>
>>>> >   }
>>>>
>>>> >
>>>>
>>>> >   thread_in_trace = 1;
>>>>
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
>>>> mutex,
>>>> >     LTTNG_UST_CALLER_IP());
>>>>
>>>> >   retval = cond_wait(condition, mutex);
>>>>
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
>>>> mutex,
>>>> >     LTTNG_UST_CALLER_IP());
>>>>
>>>> >   thread_in_trace = 0;
>>>>
>>>> >   return retval;
>>>>
>>>> > }
>>>>
>>>> >
>>>>
>>>> > int pthread_cond_signal(pthread_cond_t *condition)
>>>>
>>>> > {
>>>>
>>>> >   static int (*cond_signal)(pthread_cond_t *);
>>>>
>>>> >   int retval;
>>>>
>>>> >
>>>>
>>>> >   if (!cond_signal) {
>>>>
>>>> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>>>>
>>>> >     if (!cond_signal) {
>>>>
>>>> >       if (thread_in_trace) {
>>>>
>>>> >         abort();
>>>>
>>>> >       }
>>>>
>>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>>> library.\n");
>>>> >       return EINVAL;
>>>>
>>>> >     }
>>>>
>>>> >   }
>>>>
>>>> >   if (thread_in_trace) {
>>>>
>>>> >     return cond_signal(condition);
>>>>
>>>> >   }
>>>>
>>>> >
>>>>
>>>> >   thread_in_trace = 1;
>>>>
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin,
>>>> condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>>
>>>> >   retval = cond_signal(condition);
>>>>
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end, condition,
>>>>
>>>> >     LTTNG_UST_CALLER_IP());
>>>>
>>>> >   thread_in_trace = 0;
>>>>
>>>> >   return retval;
>>>>
>>>> > }
>>>>
>>>> >
>>>>
>>>> > int pthread_cond_broadcast(pthread_cond_t *condition)
>>>>
>>>> > {
>>>>
>>>> >   static int (*cond_broadcast)(pthread_cond_t *);
>>>>
>>>> >   int retval;
>>>>
>>>> >
>>>>
>>>> >   if (!cond_broadcast) {
>>>>
>>>> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>>>>
>>>> >     if (!cond_broadcast) {
>>>>
>>>> >       if (thread_in_trace) {
>>>>
>>>> >         abort();
>>>>
>>>> >       }
>>>>
>>>> >       fprintf(stderr, "unable to initialize pthread wrapper
>>>> library.\n");
>>>> >       return EINVAL;
>>>>
>>>> >     }
>>>>
>>>> >   }
>>>>
>>>> >   if (thread_in_trace) {
>>>>
>>>> >     return cond_broadcast(condition);
>>>>
>>>> >   }
>>>>
>>>> >
>>>>
>>>> >   thread_in_trace = 1;
>>>>
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
>>>> condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>>
>>>> >   retval = cond_broadcast(condition);
>>>>
>>>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end,
>>>> condition,
>>>> >     LTTNG_UST_CALLER_IP());
>>>>
>>>> >   thread_in_trace = 0;
>>>>
>>>> >   return retval;
>>>>
>>>> > }
>>>>
>>>> > _______________________________________________
>>>> > lttng-dev mailing list
>>>> > lttng-dev@lists.lttng.org
>>>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>> --
>>>> Jonathan Rajotte-Julien
>>>> EfficiOS
>>>>
>>>
>>>
>>
>

--0000000000002fc11e05877500e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdj5JIGNhbWUgYWNyb3NzIHNvbWV0aGluZyBzb21lIHRpbWUgYWdvIHRoYXQgSSB0aGlu
ayBtaWdodCBzb2x2ZSB0aGlzIHByb2JsZW0uIEl0IGdvZXMgYmFjayB0byBtYWtpbmcgc3VyZSB0
aGF0IHRoZSB2ZXJzaW9uIG9mIHRoZSBzeW5jaHJvbml6YXRpb24gZnVuY3Rpb24gY2FsbGVkIGZy
b20gdGhlIHdyYXBwZXIgaXMgdGhlIHNhbWUgdGhhdCB3b3VsZCBiZSBjYWxsZWQgd2l0aG91dCB0
aGUgd3JhcHBlci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRvIHNwZWNpZnkgdGhlIHZlcnNp
b24gdGhlIGZvbGxvd2luZyBpbnN0cnVjdGlvbiBjYW4gYmUgdXNlZDo8L2Rpdj48ZGl2PsKgwqDC
oMKgwqDCoMKgIC4uLi4uLi4gPSBkbHZzeW0oUlRMRF9ORVhULCAmcXVvdDtmdW5jdGlvbl9uYW1l
JnF1b3Q7LCAmcXVvdDtHTElCQ18yLjMuMiZxdW90Oyk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PlRvIGtub3cgd2hpY2ggdmVyc2lvbiBpcyBub3JtYWxseSB1c2VkLCB5b3UgY2FuIHVzZSB0aGUg
Zm9sbG93aW5nOjwvZGl2PjxkaXY+wqDCoMKgwqDCoMKgwqAgb2JqZHVtcCAtdCAmbHQ7YmluX25h
bWUmZ3Q7IHwgZ3JlcCAmbHQ7ZnVuY19uYW1lJmd0OzwvZGl2PjxkaXY+d2hlcmUgJmx0O2Jpbl9u
YW1lJmd0OyBpcyB0aGUgbmFtZSBvZiB0aGUgcHJvZ3JhbSB0byBiZSBydW4sIGFuZCAmbHQ7ZnVu
Y19uYW1lJmd0OyBpcyB0aGUgbmFtZSBvZiB0aGUgZnVuY3Rpb24gdG8gYmUgY2FsbGVkIGZyb20g
dGhlIHdyYXBwZXIuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Rm9yIG1vcmUgaW5mb3Jt
YXRpb24sIGNoZWNrIHRoaXMgbGluazrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgPGJyPsKgwqDCoMKgwqDCoMKgIDxhIGhyZWY9Imh0dHA6Ly9ibG9nLmZlc25lbC5j
b20vYmxvZy8yMDA5LzA4LzI1L3ByZWxvYWRpbmctd2l0aC1tdWx0aXBsZS1zeW1ib2wtdmVyc2lv
bnMvIj5odHRwOi8vYmxvZy5mZXNuZWwuY29tL2Jsb2cvMjAwOS8wOC8yNS9wcmVsb2FkaW5nLXdp
dGgtbXVsdGlwbGUtc3ltYm9sLXZlcnNpb25zLzwvYT48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkkgaG9wZSB0aGlzIGhlbHBzLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUaHUsIEp1
bCA1LCAyMDE4IGF0IDU6MzYgUE0gU2hlaGFiIEVsc2F5ZWQgJmx0OzxhIGhyZWY9Im1haWx0bzpz
aGVoYWJ5b21uQGdtYWlsLmNvbSI+c2hlaGFieW9tbkBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8
YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBw
eCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3Bh
ZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+QW55IHN1Z2dlc3Rpb25zIHdoZXJl
IEkgc2hvdWxkIGludmVzdGlnYXRlIHRvIGZpeCB0aGlzIGJ1Zz8gQWxzbywgcGxlYXNlIGxldCBt
ZSBrbm93IHdoZXRoZXIgdGhlIGdpdCByZXBvIEkgc2hhcmVkIGlzIHN1ZmZpY2llbnQuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj5TaGVoYWI8YnI+PC9kaXY+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxiciBjbGVhcj0iYWxsIj48ZGl2PjxkaXYgY2xh
c3M9ImdtYWlsLW1fLTg2OTc2MzQxNDg4MDMzNjYwNjRnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGly
PSJsdHIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij5TaGVoYWIgWS4gRWxzYXllZCwgTVNjLjxicj4N
ClBoRCBTdHVkZW50PGJyPlRoZSBFZHdhcmRzIFMuIFJvZ2VycyBTci4gRGVwdC4gb2YgRWxlY3Ry
aWNhbCBhbmQgQ29tcHV0ZXIgRW5naW5lZXJpbmc8YnI+VW5pdmVyc2l0eSBvZiBUb3JvbnRvIDwv
Zm9udD48Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGEgdmFsdWU9IisyMDEyNDQ5ODM2MCI+PHNwYW4g
ZGlyPSJsdHIiPjwvc3Bhbj48L2E+PGJyPg0KRS1tYWlsOiA8YSBocmVmPSJodHRwczovL3dlYm1h
aWwucmljZS5lZHUvaW1wL21lc3NhZ2UucGhwP21haWxib3g9SU5CT1gmYW1wO2luZGV4PTExIyIg
dGFyZ2V0PSJfYmxhbmsiPnNoZWhhYnlvbW5AZ21haWwuY29tPC9hPjwvZm9udD48L2Rpdj48L2Rp
dj48L2Rpdj4NCjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBNYXkgMjksIDIw
MTggYXQgMTA6MzYgQU0sIFNoZWhhYiBFbHNheWVkIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOnNoZWhhYnlvbW5AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+c2hlaGFieW9t
bkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRy
Ij5JIHdhcyB3b25kZXJpbmcgaWYgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIG92ZXIgdGhpcyBp
c3N1ZS4gVGhhbmtzITxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PHNwYW4+PGJy
IGNsZWFyPSJhbGwiPjxkaXY+PGRpdiBjbGFzcz0iZ21haWwtbV8tODY5NzYzNDE0ODgwMzM2NjA2
NG1fLTgyNzk0NzQ5MjI2MTQwNDc1OWdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGZv
bnQgY29sb3I9IiM4ODg4ODgiPlNoZWhhYiBZLiBFbHNheWVkLCBNU2MuPGJyPg0KUGhEIFN0dWRl
bnQ8YnI+VGhlIEVkd2FyZHMgUy4gUm9nZXJzIFNyLiBEZXB0LiBvZiBFbGVjdHJpY2FsIGFuZCBD
b21wdXRlciBFbmdpbmVlcmluZzxicj5Vbml2ZXJzaXR5IG9mIFRvcm9udG8gPC9mb250Pjxmb250
IGNvbG9yPSIjODg4ODg4Ij48YSB2YWx1ZT0iKzIwMTI0NDk4MzYwIj48c3BhbiBkaXI9Imx0ciI+
PC9zcGFuPjwvYT48YnI+DQpFLW1haWw6IDxhIGhyZWY9Imh0dHBzOi8vd2VibWFpbC5yaWNlLmVk
dS9pbXAvbWVzc2FnZS5waHA/bWFpbGJveD1JTkJPWCZhbXA7aW5kZXg9MTEjIiB0YXJnZXQ9Il9i
bGFuayI+c2hlaGFieW9tbkBnbWFpbC5jb208L2E+PC9mb250PjwvZGl2PjwvZGl2PjwvZGl2Pg0K
PGJyPjwvc3Bhbj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsLW1fLTg2OTc2MzQxNDg4MDMzNjYwNjRo
NSI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFRodSwgTWF5IDMsIDIwMTggYXQgNDozNyBQ
TSwgU2hlaGFiIEVsc2F5ZWQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86c2hl
aGFieW9tbkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5zaGVoYWJ5b21uQGdtYWlsLmNvbTwv
YT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+VGhhbmtz
IGZvciB0aGUgcmVwbHkuIEhlcmUgaXMgYSBsaW5rIHRvIHRoZSByZXBvIDxhIGhyZWY9Imh0dHBz
Oi8vZ2l0aHViLmNvbS9TaGVoYWJFbHNheWVkL0xUVG5nX2RlYnVnZ2luZy5naXQiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vU2hlaGFiRWxzYXllZC9MVFRuZ19kZWJ1Z2dpbmcu
Z2l0PC9hPjxicj48YnI+PC9kaXY+SXQgY29udGFpbnMgdGhlIExUVG5nIHNvdXJjZSBjb2RlIEkg
YW0gdXNpbmcgYW5kIG9uZSBvZiB0aGUgYmVuY2htYXJrcyB0aGF0IGlzIGNhdXNpbmcgcHJvYmxl
bXMuPGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnIgY2xlYXI9ImFsbCI+PGRp
dj48ZGl2IGNsYXNzPSJnbWFpbC1tXy04Njk3NjM0MTQ4ODAzMzY2MDY0bV8tODI3OTQ3NDkyMjYx
NDA0NzU5bV8tNTU2OTk3MDU1MDY2NjQwNjUyMGdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0
ciI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPlNoZWhhYiBZLiBFbHNheWVkLCBNU2MuPGJyPg0KUGhE
IFN0dWRlbnQ8YnI+VGhlIEVkd2FyZHMgUy4gUm9nZXJzIFNyLiBEZXB0LiBvZiBFbGVjdHJpY2Fs
IGFuZCBDb21wdXRlciBFbmdpbmVlcmluZzxicj5Vbml2ZXJzaXR5IG9mIFRvcm9udG8gPC9mb250
Pjxmb250IGNvbG9yPSIjODg4ODg4Ij48YSB2YWx1ZT0iKzIwMTI0NDk4MzYwIj48c3BhbiBkaXI9
Imx0ciI+PC9zcGFuPjwvYT48YnI+DQpFLW1haWw6IDxhIGhyZWY9Imh0dHBzOi8vd2VibWFpbC5y
aWNlLmVkdS9pbXAvbWVzc2FnZS5waHA/bWFpbGJveD1JTkJPWCZhbXA7aW5kZXg9MTEjIiB0YXJn
ZXQ9Il9ibGFuayI+c2hlaGFieW9tbkBnbWFpbC5jb208L2E+PC9mb250PjwvZGl2PjwvZGl2Pjwv
ZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWwtbV8tODY5NzYzNDE0ODgwMzM2NjA2NG1fLTgyNzk0
NzQ5MjI2MTQwNDc1OWg1Ij4NCjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBN
YXkgMSwgMjAxOCBhdCAxMDozOSBBTSwgSm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4gPHNwYW4gZGly
PSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNp
b3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3Mu
Y29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgU2hlaGFiLDxicj4NCjxicj4N
ClBsZWFzZSBwcm92aWRlIGEgbGluayB0byBhIGx0dG5nLXVzdCBnaXQgdHJlZSBvciBhbiBhY3R1
YWwgcGF0Y2ggKGdpdCBmb3JtYXQtcGF0Y2gpLjxicj4NClRoaXMgd2lsbCBoZWxwIGFueSBwZXJz
b24gd2hvIG1pZ2h0IGJlIGludGVyZXN0ZWQgaW4gaGVscGluZyB5b3UgaW5jbHVkaW5nPGJyPg0K
bXlzZWxmLjxicj4NCjxicj4NCkNoZWVyczxicj4NCjxkaXY+PGRpdiBjbGFzcz0iZ21haWwtbV8t
ODY5NzYzNDE0ODgwMzM2NjA2NG1fLTgyNzk0NzQ5MjI2MTQwNDc1OW1fLTU1Njk5NzA1NTA2NjY0
MDY1MjBoNSI+PGJyPg0KT24gVHVlLCBNYXkgMDEsIDIwMTggYXQgMDk6MzE6NTJBTSAtMDQwMCwg
U2hlaGFiIEVsc2F5ZWQgd3JvdGU6PGJyPg0KJmd0OyBIaSw8YnI+DQomZ3Q7IDxicj4NCiZndDsg
SSBhbSB0cnlpbmcgdG8gY3JlYXRlIHdyYXBwZXJzIGZvciBwdGhyZWFkcyBjb25kaXRpb25hbCB2
YXJpYWJsZXMgZnVuY3Rpb25zPGJyPg0KJmd0OyAod2FpdCwgc2lnbmFsIGFuZCBicm9hZGNhc3Qp
IHRvIGluc2VydCB0cmFjZXBvaW50cy4gSSBmb2xsb3dlZCB0aGUgc2FtZTxicj4NCiZndDsgYXBw
cm9hY2ggZG9uZSBmb3IgdGhlIG11dGV4IGZ1bmN0aW9ucyBhbHJlYWR5IHByb3ZpZGVkIHdpdGgg
bHR0bmcsIGhvd2V2ZXI8YnI+DQomZ3Q7IEkgYW0gcnVubmluZyBpbnRvIHNvbWUgcHJvYmxlbXMu
IE1haW5seSB0aGUgYXBwbGljYXRpb25zIHNlZW0gdG8gZ2V0IHN0dWNrPGJyPg0KJmd0OyB3aGVu
IHRoZSBjb25kaXRpb25hbCB2YXJpYWJsZSB3cmFwcGVycyBhcmUgZW5hYmxlZC48YnI+DQomZ3Q7
IDxicj4NCiZndDsgSGVyZSBpcyBteSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIHdyYXBwZXIgZnVu
Y3Rpb25zOjxicj4NCiZndDsgaW50IHB0aHJlYWRfY29uZF93YWl0KHB0aHJlYWRfY29uZF90ICpj
b25kaXRpb24sIHB0aHJlYWRfbXV0ZXhfdDxicj4NCiZndDsgKm11dGV4KTxicj4NCiZndDsgPGJy
Pg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBzdGF0aWMgaW50ICgqY29uZF93YWl0
KShwdGhyZWFkX2NvbmRfdCAqLCBwdGhyZWFkX211dGV4X3Q8YnI+DQomZ3Q7ICopOzxicj4NCiZn
dDvCoCDCoGludCByZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0K
Jmd0O8KgIMKgaWYgKCFjb25kX3dhaXQpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgwqAgwqBjb25kX3dhaXQgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJlYWRfY29uZF93
YWl0JnF1b3Q7KTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoGlmICghY29uZF93YWl0KTxi
cj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgaWYgKHRocmVhZF9pbl90
cmFjZSk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBhYm9ydCgp
Ozxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDvC
oCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDt1bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhy
ZWFkIHdyYXBwZXI8YnI+DQomZ3Q7IGxpYnJhcnkuXG4mcXVvdDspOzxicj4NCiZndDvCoCDCoCDC
oCDCoHJldHVybiBFSU5WQUw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4N
CiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoGlm
ICh0aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAg
wqByZXR1cm4gY29uZF93YWl0KGNvbmRpdGlvbiwgbXV0ZXgpOzxicj4NCiZndDsgPGJyPg0KJmd0
OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4NCiZndDsgMTs8YnI+DQomZ3Q7IDxicj4NCiZndDvC
oCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF93YWl0X2JlZ2lu
LCBjb25kaXRpb24sPGJyPg0KJmd0OyBtdXRleCw8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDC
oExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqByZXR2YWwg
PSBjb25kX3dhaXQoY29uZGl0aW9uLCBtdXRleCk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0
cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRfd2FpdF9lbmQsIGNvbmRp
dGlvbiw8YnI+DQomZ3Q7IG11dGV4LDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdf
VVNUX0NBTExFUl9JUCgpKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFj
ZSA9PGJyPg0KJmd0OyAwOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDs8
YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDsgaW50IHB0aHJlYWRfY29uZF9zaWduYWwocHRocmVhZF9jb25kX3Q8YnI+DQomZ3Q7
ICpjb25kaXRpb24pPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvC
oCDCoHN0YXRpYyBpbnQgKCpjb25kX3NpZ25hbCkocHRocmVhZF9jb25kX3Q8YnI+DQomZ3Q7ICop
Ozxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgaW50IHJldHZhbDs8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBpZiAoIWNvbmRfc2lnbmFsKTxicj4NCiZndDsg
ezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgY29uZF9zaWduYWwgPSBkbHN5bShSVExEX05F
WFQsICZxdW90O3B0aHJlYWRfY29uZF9zaWduYWwmcXVvdDspOzxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgIMKgaWYgKCFjb25kX3NpZ25hbCk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZn
dDvCoCDCoCDCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8
YnI+DQomZ3Q7IDxicj4NCiZndDsgYWJvcnQoKTs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0K
Jmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1
b3Q7dW5hYmxlIHRvIGluaXRpYWxpemUgcHRocmVhZCB3cmFwcGVyPGJyPg0KJmd0OyBsaWJyYXJ5
LlxuJnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMOzxicj4NCiZndDsg
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKTxicj4NCiZndDsg
ezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfc2lnbmFsKGNvbmRpdGlv
bik7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0
OyA8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJyPg0KJmd0OyAx
Ozxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwg
cHRocmVhZF9jb25kX3NpZ25hbF9iZWdpbiw8YnI+DQomZ3Q7IGNvbmRpdGlvbiw8YnI+DQomZ3Q7
wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKg
cmV0dmFsID0gY29uZF9zaWduYWwoY29uZGl0aW9uKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF9zaWduYWxfZW5kLDxi
cj4NCiZndDsgY29uZGl0aW9uLDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAo
KSk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4NCiZndDsg
MDs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHJldHVybiByZXR2YWw7PGJyPg0KJmd0OyA8YnI+
DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGludCBw
dGhyZWFkX2NvbmRfYnJvYWRjYXN0KHB0aHJlYWRfY29uZF90PGJyPg0KJmd0OyAqY29uZGl0aW9u
KTxicj4NCiZndDsgPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBzdGF0aWMg
aW50ICgqY29uZF9icm9hZGNhc3QpKHB0aHJlYWRfY29uZF90PGJyPg0KJmd0OyAqKTs8YnI+DQom
Z3Q7wqAgwqBpbnQgcmV0dmFsOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4N
CiZndDvCoCDCoGlmICghY29uZF9icm9hZGNhc3QpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+
DQomZ3Q7wqAgwqAgwqBjb25kX2Jyb2FkY2FzdCA9IGRsc3ltKFJUTERfTkVYVCwgJnF1b3Q7cHRo
cmVhZF9jb25kX2Jyb2FkY2FzdCZxdW90Oyk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBp
ZiAoIWNvbmRfYnJvYWRjYXN0KTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKg
IMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgPGJyPg0KJmd0OyBhYm9ydCgpOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08
YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDt1bmFi
bGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXI8YnI+DQomZ3Q7IGxpYnJhcnkuXG4mcXVv
dDspOzxicj4NCiZndDvCoCDCoCDCoCDCoHJldHVybiBFSU5WQUw7PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQom
Z3Q7IDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29uZF9icm9hZGNhc3QoY29uZGl0aW9uKTs8
YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID08YnI+DQomZ3Q7IDE7PGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhy
ZWFkX2NvbmRfYnJvYWRjYXN0X2JlZ2luLDxicj4NCiZndDsgY29uZGl0aW9uLDxicj4NCiZndDvC
oCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBy
ZXR2YWwgPSBjb25kX2Jyb2FkY2FzdChjb25kaXRpb24pOzxicj4NCiZndDsgPGJyPg0KJmd0O8Kg
IMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jyb2FkY2FzdF9l
bmQsPGJyPg0KJmd0OyBjb25kaXRpb24sPGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExF
Ul9JUCgpKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJyPg0K
Jmd0OyAwOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDs8YnI+DQomZ3Q7
IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyBUaGluZ3MgSSBoYXZlIHRyaWVkOjxi
cj4NCiZndDsgMS0gQ29tbWVudCBvdXQgcHRocmVhZF9jb25kX3dhaXQgZnVuY3Rpb24gLS0mZ3Q7
IHNlZ21lbnRhdGlvbiBmYXVsdDxicj4NCiZndDsgMi0gQ29tbWVudCBvdXQgcHRocmVhZF9jb25k
X3NpZ25hbCBhbmQgX2Jyb2FkY2FzdCAtLSZndDsgc3R1Y2sgKEkgY2FuIHNlZSB0aGU8YnI+DQom
Z3Q7IHByb2dyYW0gaXMgc3RpbGwgcnVubmluZyBidXQgbm9yIGZvcndhcmQgcHJvZ3Jlc3MgaXMg
YmVpbmcgbWFkZSkgY29tcGFyZWQ8YnI+DQomZ3Q7IHRvIHRoZSBjYXNlIHdoZW4gdGhlIHdyYXBw
ZXJzIGFyZSBub3QgcHJlbG9hZGVkLjxicj4NCiZndDsgMy0gQ29tbWVudCBvdXQgYWxsIHRyYWNl
cG9pbnQgcmVsYXRlZCBjb2RlIChiYXNpY2FsbHkgdGhlIHdyYXBwZXIganVzdCBjYWxsPGJyPg0K
Jmd0OyB0aGUgY29ycmVzcG9uZGluZyBwdGhyZWFkcyBmdW5jdGlvbikgLS0mZ3Q7IHNhbWUgcmVz
dWx0cyBhcyBwb2ludHMgMSBhbmQgMi48YnI+DQomZ3Q7IDxicj4NCiZndDsgQW55IGlkZWEgd2hh
dCBtaWdodCBiZSBjYXVzaW5nIHRoaXMgb3IgaG93IEkgY291bGQgZGVidWcgdGhpcyBwcm9ibGVt
Pzxicj4NCiZndDsgPGJyPg0KJmd0OyBUaGFuayB5b3UgdmVyeSBtdWNoIGluIGFkdmFuY2UuPGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7IEJlc3QgUmVnYXJkcyw8YnI+DQomZ3Q7IFNoZWhhYjxicj4NCjxi
cj4NCiZndDsgaW50IHB0aHJlYWRfY29uZF93YWl0KHB0aHJlYWRfY29uZF90ICpjb25kaXRpb24s
IHB0aHJlYWRfbXV0ZXhfdCAqbXV0ZXgpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyB7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBzdGF0aWMg
aW50ICgqY29uZF93YWl0KShwdGhyZWFkX2NvbmRfdCAqLCBwdGhyZWFkX211dGV4X3QgKik7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBpbnQgcmV0dmFsO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgaWYgKCFjb25kX3dhaXQpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoGNvbmRfd2FpdCA9IGRsc3ltKFJUTERf
TkVYVCwgJnF1b3Q7cHRocmVhZF9jb25kX3dhaXQmcXVvdDspO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoGlmICghY29uZF93YWl0KSB7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAo
dGhyZWFkX2luX3RyYWNlKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgYWJvcnQoKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7
dW5hYmxlIHRvIGluaXRpYWxpemUgcHRocmVhZCB3cmFwcGVyIGxpYnJhcnkuXG4mcXVvdDspO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgcmV0dXJuIEVJTlZBTDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB9wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8YnI+DQomZ3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKSB7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfd2FpdChjb25kaXRpb24sIG11
dGV4KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9IDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9j
b25kX3dhaXRfYmVnaW4sIGNvbmRpdGlvbiwgbXV0ZXgswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKg
IMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDvCoCDCoHJldHZhbCA9IGNvbmRfd2FpdChjb25kaXRpb24sIG11dGV4KTvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF93YWl0X2Vu
ZCwgY29uZGl0aW9uLCBtdXRleCzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19V
U1RfQ0FMTEVSX0lQKCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhy
ZWFkX2luX3RyYWNlID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
wqAgwqByZXR1cm4gcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDxicj4NCiZndDsgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyBpbnQg
cHRocmVhZF9jb25kX3NpZ25hbChwdGhyZWFkX2NvbmRfdCAqY29uZGl0aW9uKcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDsge8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgc3RhdGljIGludCAoKmNvbmRfc2lnbmFsKShwdGhyZWFkX2NvbmRfdCAq
KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8
YnI+DQomZ3Q7wqAgwqBpbnQgcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgaWYgKCFj
b25kX3NpZ25hbCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
O8KgIMKgIMKgY29uZF9zaWduYWwgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJlYWRfY29u
ZF9zaWduYWwmcXVvdDspO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4N
CiZndDvCoCDCoCDCoGlmICghY29uZF9zaWduYWwpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBhYm9ydCgpO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoCDCoH3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDt1bmFibGUgdG8gaW5pdGlh
bGl6ZSBwdGhyZWFkIHdyYXBwZXIgbGlicmFyeS5cbiZxdW90Oyk7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoH3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29uZF9zaWduYWwoY29uZGl0aW9uKTvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAxO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJl
YWRfY29uZF9zaWduYWxfYmVnaW4sIGNvbmRpdGlvbizCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+DQomZ3Q7wqAgwqByZXR2YWwgPSBjb25kX3NpZ25hbChjb25kaXRpb24pO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0
aHJlYWRfY29uZF9zaWduYWxfZW5kLCBjb25kaXRpb24swqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkpO8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID0gMDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqByZXR1cm4gcmV0dmFsO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDsgfcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyBpbnQgcHRocmVhZF9jb25kX2Jyb2FkY2FzdChw
dGhyZWFkX2NvbmRfdCAqY29uZGl0aW9uKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KJmd0OyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBzdGF0aWMgaW50
ICgqY29uZF9icm9hZGNhc3QpKHB0aHJlYWRfY29uZF90ICopO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgaW50IHJldHZhbDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICghY29uZF9icm9hZGNhc3QpIHvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBjb25kX2Jyb2FkY2FzdCA9IGRs
c3ltKFJUTERfTkVYVCwgJnF1b3Q7cHRocmVhZF9jb25kX2Jyb2FkY2FzdCZxdW90Oyk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgaWYgKCFjb25kX2Jyb2FkY2Fz
dCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoCDCoGlmICh0
aHJlYWRfaW5fdHJhY2UpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqBhYm9ydCgpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDxicj4NCiZndDvCoCDCoCDCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJy
LCAmcXVvdDt1bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXIgbGlicmFyeS5cbiZx
dW90Oyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoH3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29u
ZF9icm9hZGNhc3QoY29uZGl0aW9uKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoH3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9IDE7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChs
dHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jyb2FkY2FzdF9iZWdpbiwgY29uZGl0aW9u
LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqByZXR2YWwgPSBjb25kX2Jy
b2FkY2FzdChjb25kaXRpb24pO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChs
dHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jyb2FkY2FzdF9lbmQsIGNvbmRpdGlvbizC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNl
ID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqByZXR1
cm4gcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4N
CiZndDsgfcKgIMKgIMKgPGJyPg0KPGJyPg0KPC9kaXY+PC9kaXY+Jmd0OyBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4NCiZndDsgbHR0bmctZGV2IG1h
aWxpbmcgbGlzdDxicj4NCiZndDsgPGEgaHJlZj0ibWFpbHRvOmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmciIHRhcmdldD0iX2JsYW5rIj5sdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPC9hPjxicj4N
CiZndDsgPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldiIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldjwvYT48
YnI+DQo8c3BhbiBjbGFzcz0iZ21haWwtbV8tODY5NzYzNDE0ODgwMzM2NjA2NG1fLTgyNzk0NzQ5
MjI2MTQwNDc1OW1fLTU1Njk5NzA1NTA2NjY0MDY1MjBIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4
ODg4Ij48YnI+DQo8YnI+DQotLSA8YnI+DQpKb25hdGhhbiBSYWpvdHRlLUp1bGllbjxicj4NCkVm
ZmljaU9TPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pjwv
ZGl2PjwvZGl2Pg0KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj4NCjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--0000000000002fc11e05877500e9--

--===============2762789026380542674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2762789026380542674==--
