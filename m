From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Tracepoints for pthreads conditional variables
Date: Tue, 29 May 2018 10:36:07 -0400
Message-ID: <CAC-H6tu3wfE-LJWCTL8+rggLkyJ75yjMEmi=rWGsWspWkaaoGg__36503.3823684373$1527604456$gmane$org@mail.gmail.com>
References: <CAC-H6tv29C9RdoquefmAs6s-kM6o-RyYFMAYF1a1Vqk0PYX9dQ@mail.gmail.com>
 <20180501143953.GA26829@joraj-alpa>
 <CAC-H6tuewaghma5hN3R2iCGvpcYVMph1uwti3u0+1ZhZEn44-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7003345675335839388=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 by lists.lttng.org (Postfix) with ESMTPS id 40wGVx6RX2z17QS
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 10:36:09 -0400 (EDT)
Received: by mail-wm0-x230.google.com with SMTP id 18-v6so35721651wml.2
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 07:36:09 -0700 (PDT)
In-Reply-To: <CAC-H6tuewaghma5hN3R2iCGvpcYVMph1uwti3u0+1ZhZEn44-A@mail.gmail.com>
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

--===============7003345675335839388==
Content-Type: multipart/alternative; boundary="000000000000aa58b5056d592761"

--000000000000aa58b5056d592761
Content-Type: text/plain; charset="UTF-8"

I was wondering if you had a chance to look over this issue. Thanks!

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Thu, May 3, 2018 at 4:37 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote:

> Thanks for the reply. Here is a link to the repo https://github.com/
> ShehabElsayed/LTTng_debugging.git
>
> It contains the LTTng source code I am using and one of the benchmarks
> that is causing problems.
>
> Shehab Y. Elsayed, MSc.
> PhD Student
> The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> University of Toronto
> E-mail: shehabyomn@gmail.com
> <https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>
>
> On Tue, May 1, 2018 at 10:39 AM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
>
>> Hi Shehab,
>>
>> Please provide a link to a lttng-ust git tree or an actual patch (git
>> format-patch).
>> This will help any person who might be interested in helping you including
>> myself.
>>
>> Cheers
>>
>> On Tue, May 01, 2018 at 09:31:52AM -0400, Shehab Elsayed wrote:
>> > Hi,
>> >
>> > I am trying to create wrappers for pthreads conditional variables
>> functions
>> > (wait, signal and broadcast) to insert tracepoints. I followed the same
>> > approach done for the mutex functions already provided with lttng,
>> however
>> > I am running into some problems. Mainly the applications seem to get
>> stuck
>> > when the conditional variable wrappers are enabled.
>> >
>> > Here is my implementation for the wrapper functions:
>> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
>> > *mutex)
>> >
>> > {
>> >
>> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t
>> > *);
>> >   int retval;
>> >
>> >
>> >
>> >   if (!cond_wait)
>> > {
>> >
>> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>> >
>> >     if (!cond_wait)
>> > {
>> >
>> >       if (thread_in_trace)
>> > {
>> >
>> >
>> > abort();
>> >
>> >
>> > }
>> >
>> >       fprintf(stderr, "unable to initialize pthread wrapper
>> > library.\n");
>> >       return EINVAL;
>> >
>> >
>> > }
>> >
>> >
>> > }
>> >
>> >   if (thread_in_trace)
>> > {
>> >
>> >     return cond_wait(condition, mutex);
>> >
>> >
>> > }
>> >
>> >
>> >
>> >   thread_in_trace =
>> > 1;
>> >
>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
>> > mutex,
>> >
>> >     LTTNG_UST_CALLER_IP());
>> >
>> >   retval = cond_wait(condition, mutex);
>> >
>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
>> > mutex,
>> >
>> >     LTTNG_UST_CALLER_IP());
>> >
>> >   thread_in_trace =
>> > 0;
>> >
>> >   return retval;
>> >
>> > }
>> >
>> >
>> >
>> > int pthread_cond_signal(pthread_cond_t
>> > *condition)
>> >
>> > {
>> >
>> >   static int (*cond_signal)(pthread_cond_t
>> > *);
>> >
>> >   int retval;
>> >
>> >
>> >
>> >   if (!cond_signal)
>> > {
>> >
>> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>> >
>> >     if (!cond_signal)
>> > {
>> >
>> >       if (thread_in_trace)
>> > {
>> >
>> >
>> > abort();
>> >
>> >
>> > }
>> >
>> >       fprintf(stderr, "unable to initialize pthread wrapper
>> > library.\n");
>> >       return EINVAL;
>> >
>> >
>> > }
>> >
>> >
>> > }
>> >
>> >   if (thread_in_trace)
>> > {
>> >
>> >     return cond_signal(condition);
>> >
>> >
>> > }
>> >
>> >
>> >
>> >   thread_in_trace =
>> > 1;
>> >
>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin,
>> > condition,
>> >     LTTNG_UST_CALLER_IP());
>> >
>> >   retval = cond_signal(condition);
>> >
>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end,
>> > condition,
>> >     LTTNG_UST_CALLER_IP());
>> >
>> >   thread_in_trace =
>> > 0;
>> >
>> >   return retval;
>> >
>> > }
>> >
>> >
>> >
>> > int pthread_cond_broadcast(pthread_cond_t
>> > *condition)
>> >
>> > {
>> >
>> >   static int (*cond_broadcast)(pthread_cond_t
>> > *);
>> >   int retval;
>> >
>> >
>> >
>> >   if (!cond_broadcast)
>> > {
>> >
>> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>> >
>> >     if (!cond_broadcast)
>> > {
>> >
>> >       if (thread_in_trace)
>> > {
>> >
>> >
>> > abort();
>> >
>> >
>> > }
>> >
>> >       fprintf(stderr, "unable to initialize pthread wrapper
>> > library.\n");
>> >       return EINVAL;
>> >
>> >
>> > }
>> >
>> >
>> > }
>> >
>> >   if (thread_in_trace)
>> > {
>> >
>> >     return cond_broadcast(condition);
>> >
>> >
>> > }
>> >
>> >
>> >
>> >   thread_in_trace =
>> > 1;
>> >
>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
>> > condition,
>> >     LTTNG_UST_CALLER_IP());
>> >
>> >   retval = cond_broadcast(condition);
>> >
>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end,
>> > condition,
>> >     LTTNG_UST_CALLER_IP());
>> >
>> >   thread_in_trace =
>> > 0;
>> >
>> >   return retval;
>> >
>> > }
>> >
>> > Things I have tried:
>> > 1- Comment out pthread_cond_wait function --> segmentation fault
>> > 2- Comment out pthread_cond_signal and _broadcast --> stuck (I can see
>> the
>> > program is still running but nor forward progress is being made)
>> compared
>> > to the case when the wrappers are not preloaded.
>> > 3- Comment out all tracepoint related code (basically the wrapper just
>> call
>> > the corresponding pthreads function) --> same results as points 1 and 2.
>> >
>> > Any idea what might be causing this or how I could debug this problem?
>> >
>> > Thank you very much in advance.
>> >
>> > Best Regards,
>> > Shehab
>>
>> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
>> *mutex)
>> > {
>>
>>
>>
>> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t *);
>>
>> >   int retval;
>>
>> >
>>
>> >   if (!cond_wait) {
>>
>> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>>
>> >     if (!cond_wait) {
>>
>> >       if (thread_in_trace) {
>>
>> >         abort();
>>
>> >       }
>>
>> >       fprintf(stderr, "unable to initialize pthread wrapper
>> library.\n");
>> >       return EINVAL;
>>
>> >     }
>>
>> >   }
>>
>> >   if (thread_in_trace) {
>>
>> >     return cond_wait(condition, mutex);
>>
>> >   }
>>
>> >
>>
>> >   thread_in_trace = 1;
>>
>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
>> mutex,
>> >     LTTNG_UST_CALLER_IP());
>>
>> >   retval = cond_wait(condition, mutex);
>>
>> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
>> mutex,
>> >     LTTNG_UST_CALLER_IP());
>>
>> >   thread_in_trace = 0;
>>
>> >   return retval;
>>
>> > }
>>
>> >
>>
>> > int pthread_cond_signal(pthread_cond_t *condition)
>>
>> > {
>>
>> >   static int (*cond_signal)(pthread_cond_t *);
>>
>> >   int retval;
>>
>> >
>>
>> >   if (!cond_signal) {
>>
>> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>>
>> >     if (!cond_signal) {
>>
>> >       if (thread_in_trace) {
>>
>> >         abort();
>>
>> >       }
>>
>> >       fprintf(stderr, "unable to initialize pthread wrapper
>> library.\n");
>> >       return EINVAL;
>>
>> >     }
>>
>> >   }
>>
>> >   if (thread_in_trace) {
>>
>> >     return cond_signal(condition);
>>
>> >   }
>>
>> >
>>
>> >   thread_in_trace = 1;
>>
>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin, condition,
>>
>> >     LTTNG_UST_CALLER_IP());
>>
>> >   retval = cond_signal(condition);
>>
>> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end, condition,
>>
>> >     LTTNG_UST_CALLER_IP());
>>
>> >   thread_in_trace = 0;
>>
>> >   return retval;
>>
>> > }
>>
>> >
>>
>> > int pthread_cond_broadcast(pthread_cond_t *condition)
>>
>> > {
>>
>> >   static int (*cond_broadcast)(pthread_cond_t *);
>>
>> >   int retval;
>>
>> >
>>
>> >   if (!cond_broadcast) {
>>
>> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>>
>> >     if (!cond_broadcast) {
>>
>> >       if (thread_in_trace) {
>>
>> >         abort();
>>
>> >       }
>>
>> >       fprintf(stderr, "unable to initialize pthread wrapper
>> library.\n");
>> >       return EINVAL;
>>
>> >     }
>>
>> >   }
>>
>> >   if (thread_in_trace) {
>>
>> >     return cond_broadcast(condition);
>>
>> >   }
>>
>> >
>>
>> >   thread_in_trace = 1;
>>
>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
>> condition,
>> >     LTTNG_UST_CALLER_IP());
>>
>> >   retval = cond_broadcast(condition);
>>
>> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end, condition,
>>
>> >     LTTNG_UST_CALLER_IP());
>>
>> >   thread_in_trace = 0;
>>
>> >   return retval;
>>
>> > }
>>
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Jonathan Rajotte-Julien
>> EfficiOS
>>
>
>

--000000000000aa58b5056d592761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SSB3YXMgd29uZGVyaW5nIGlmIHlvdSBoYWQgYSBjaGFuY2UgdG8gbG9v
ayBvdmVyIHRoaXMgaXNzdWUuIFRoYW5rcyE8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0
cmEiPjxiciBjbGVhcj0iYWxsIj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0
YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGZvbnQgY29sb3I9
IiM4ODg4ODgiPlNoZWhhYiBZLiBFbHNheWVkLCBNU2MuPGJyPg0KUGhEIFN0dWRlbnQ8YnI+VGhl
IEVkd2FyZHMgUy4gUm9nZXJzIFNyLiBEZXB0LiBvZiBFbGVjdHJpY2FsIGFuZCBDb21wdXRlciBF
bmdpbmVlcmluZzxicj5Vbml2ZXJzaXR5IG9mIFRvcm9udG8gPC9mb250Pjxmb250IGNvbG9yPSIj
ODg4ODg4Ij48YSB2YWx1ZT0iKzIwMTI0NDk4MzYwIj48c3BhbiBkaXI9Imx0ciI+PC9zcGFuPjwv
YT48YnI+DQpFLW1haWw6IDxhIGhyZWY9Imh0dHBzOi8vd2VibWFpbC5yaWNlLmVkdS9pbXAvbWVz
c2FnZS5waHA/bWFpbGJveD1JTkJPWCZhbXA7aW5kZXg9MTEjIiB0YXJnZXQ9Il9ibGFuayI+c2hl
aGFieW9tbkBnbWFpbC5jb208L2E+PC9mb250PjwvZGl2PjwvZGl2PjwvZGl2Pg0KPGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIE1heSAzLCAyMDE4IGF0IDQ6MzcgUE0sIFNoZWhh
YiBFbHNheWVkIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnNoZWhhYnlvbW5A
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+c2hlaGFieW9tbkBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+VGhhbmtzIGZvciB0aGUgcmVwbHkuIEhlcmUgaXMgYSBs
aW5rIHRvIHRoZSByZXBvIDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9TaGVoYWJFbHNheWVk
L0xUVG5nX2RlYnVnZ2luZy5naXQiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20v
PHdicj5TaGVoYWJFbHNheWVkL0xUVG5nX2RlYnVnZ2luZy48d2JyPmdpdDwvYT48YnI+PGJyPjwv
ZGl2Pkl0IGNvbnRhaW5zIHRoZSBMVFRuZyBzb3VyY2UgY29kZSBJIGFtIHVzaW5nIGFuZCBvbmUg
b2YgdGhlIGJlbmNobWFya3MgdGhhdCBpcyBjYXVzaW5nIHByb2JsZW1zLjxicj48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGRpdiBjbGFzcz0ibV8t
NTU2OTk3MDU1MDY2NjQwNjUyMGdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWls
X3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPlNoZWhhYiBZ
LiBFbHNheWVkLCBNU2MuPGJyPg0KUGhEIFN0dWRlbnQ8YnI+VGhlIEVkd2FyZHMgUy4gUm9nZXJz
IFNyLiBEZXB0LiBvZiBFbGVjdHJpY2FsIGFuZCBDb21wdXRlciBFbmdpbmVlcmluZzxicj5Vbml2
ZXJzaXR5IG9mIFRvcm9udG8gPC9mb250Pjxmb250IGNvbG9yPSIjODg4ODg4Ij48YSB2YWx1ZT0i
KzIwMTI0NDk4MzYwIj48c3BhbiBkaXI9Imx0ciI+PC9zcGFuPjwvYT48YnI+DQpFLW1haWw6IDxh
IGhyZWY9Imh0dHBzOi8vd2VibWFpbC5yaWNlLmVkdS9pbXAvbWVzc2FnZS5waHA/bWFpbGJveD1J
TkJPWCZhbXA7aW5kZXg9MTEjIiB0YXJnZXQ9Il9ibGFuayI+c2hlaGFieW9tbkBnbWFpbC5jb208
L2E+PC9mb250PjwvZGl2PjwvZGl2PjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iaDUiPg0KPGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUdWUsIE1heSAxLCAyMDE4IGF0IDEwOjM5IEFNLCBK
b25hdGhhbiBSYWpvdHRlLUp1bGllbiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0
bzpqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5q
b25hdGhhbi5yYWpvdHRlLWp1bGllbkA8d2JyPmVmZmljaW9zLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3
cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkg
U2hlaGFiLDxicj4NCjxicj4NClBsZWFzZSBwcm92aWRlIGEgbGluayB0byBhIGx0dG5nLXVzdCBn
aXQgdHJlZSBvciBhbiBhY3R1YWwgcGF0Y2ggKGdpdCBmb3JtYXQtcGF0Y2gpLjxicj4NClRoaXMg
d2lsbCBoZWxwIGFueSBwZXJzb24gd2hvIG1pZ2h0IGJlIGludGVyZXN0ZWQgaW4gaGVscGluZyB5
b3UgaW5jbHVkaW5nPGJyPg0KbXlzZWxmLjxicj4NCjxicj4NCkNoZWVyczxicj4NCjxkaXY+PGRp
diBjbGFzcz0ibV8tNTU2OTk3MDU1MDY2NjQwNjUyMGg1Ij48YnI+DQpPbiBUdWUsIE1heSAwMSwg
MjAxOCBhdCAwOTozMTo1MkFNIC0wNDAwLCBTaGVoYWIgRWxzYXllZCB3cm90ZTo8YnI+DQomZ3Q7
IEhpLDxicj4NCiZndDsgPGJyPg0KJmd0OyBJIGFtIHRyeWluZyB0byBjcmVhdGUgd3JhcHBlcnMg
Zm9yIHB0aHJlYWRzIGNvbmRpdGlvbmFsIHZhcmlhYmxlcyBmdW5jdGlvbnM8YnI+DQomZ3Q7ICh3
YWl0LCBzaWduYWwgYW5kIGJyb2FkY2FzdCkgdG8gaW5zZXJ0IHRyYWNlcG9pbnRzLiBJIGZvbGxv
d2VkIHRoZSBzYW1lPGJyPg0KJmd0OyBhcHByb2FjaCBkb25lIGZvciB0aGUgbXV0ZXggZnVuY3Rp
b25zIGFscmVhZHkgcHJvdmlkZWQgd2l0aCBsdHRuZywgaG93ZXZlcjxicj4NCiZndDsgSSBhbSBy
dW5uaW5nIGludG8gc29tZSBwcm9ibGVtcy4gTWFpbmx5IHRoZSBhcHBsaWNhdGlvbnMgc2VlbSB0
byBnZXQgc3R1Y2s8YnI+DQomZ3Q7IHdoZW4gdGhlIGNvbmRpdGlvbmFsIHZhcmlhYmxlIHdyYXBw
ZXJzIGFyZSBlbmFibGVkLjxicj4NCiZndDsgPGJyPg0KJmd0OyBIZXJlIGlzIG15IGltcGxlbWVu
dGF0aW9uIGZvciB0aGUgd3JhcHBlciBmdW5jdGlvbnM6PGJyPg0KJmd0OyBpbnQgcHRocmVhZF9j
b25kX3dhaXQocHRocmVhZF9jb25kPHdicj5fdCAqY29uZGl0aW9uLCBwdGhyZWFkX211dGV4X3Q8
YnI+DQomZ3Q7ICptdXRleCk8YnI+DQomZ3Q7IDxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0K
Jmd0O8KgIMKgc3RhdGljIGludCAoKmNvbmRfd2FpdCkocHRocmVhZF9jb25kX3QgKiwgcHRocmVh
ZF9tdXRleF90PGJyPg0KJmd0OyAqKTs8YnI+DQomZ3Q7wqAgwqBpbnQgcmV0dmFsOzxicj4NCiZn
dDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoGlmICghY29uZF93YWl0KTxi
cj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgY29uZF93YWl0ID0gZGxzeW0o
UlRMRF9ORVhULCAmcXVvdDtwdGhyZWFkX2NvbmRfd2FpdCZxdW90Oyk7PGJyPg0KJmd0OyA8YnI+
DQomZ3Q7wqAgwqAgwqBpZiAoIWNvbmRfd2FpdCk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4N
CiZndDvCoCDCoCDCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0KJmd0
OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgYWJvcnQoKTs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJy
Pg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwg
JnF1b3Q7dW5hYmxlIHRvIGluaXRpYWxpemUgcHRocmVhZCB3cmFwcGVyPGJyPg0KJmd0OyBsaWJy
YXJ5LlxuJnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMOzxicj4NCiZn
dDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0
OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKTxicj4NCiZn
dDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfd2FpdChjb25kaXRp
b24sIG11dGV4KTs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8
YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID08YnI+
DQomZ3Q7IDE7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9w
dGhyZWFkLCBwdGhyZWFkX2NvbmRfd2FpdF9iZWdpbiwgY29uZGl0aW9uLDxicj4NCiZndDsgbXV0
ZXgsPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkpOzxi
cj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dmFsID0gY29uZF93YWl0KGNvbmRpdGlvbiwgbXV0
ZXgpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVh
ZCwgcHRocmVhZF9jb25kX3dhaXRfZW5kLCBjb25kaXRpb24sPGJyPg0KJmd0OyBtdXRleCw8YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJyPg0KJmd0
OyA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4NCiZndDsgMDs8YnI+DQomZ3Q7
IDxicj4NCiZndDvCoCDCoHJldHVybiByZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+
DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGludCBwdGhyZWFkX2NvbmRf
c2lnbmFsKHB0aHJlYWRfY288d2JyPm5kX3Q8YnI+DQomZ3Q7ICpjb25kaXRpb24pPGJyPg0KJmd0
OyA8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHN0YXRpYyBpbnQgKCpjb25k
X3NpZ25hbCkocHRocmVhZF9jb25kX3Q8YnI+DQomZ3Q7ICopOzxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgaW50IHJldHZhbDs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7wqAgwqBpZiAoIWNvbmRfc2lnbmFsKTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgIMKgY29uZF9zaWduYWwgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJlYWRfY29u
ZF9zaWduYWwmcXVvdDspOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgaWYgKCFjb25kX3Np
Z25hbCk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoGlmICh0aHJl
YWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsg
YWJvcnQoKTs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7dW5hYmxlIHRvIGluaXRpYWxp
emUgcHRocmVhZCB3cmFwcGVyPGJyPg0KJmd0OyBsaWJyYXJ5LlxuJnF1b3Q7KTs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7
IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgIMKgcmV0dXJuIGNvbmRfc2lnbmFsKGNvbmRpdGlvbik7PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZn
dDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJyPg0KJmd0OyAxOzxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX3NpZ25hbF9i
ZWdpbiw8YnI+DQomZ3Q7IGNvbmRpdGlvbiw8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FM
TEVSX0lQKCkpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dmFsID0gY29uZF9zaWduYWwo
Y29uZGl0aW9uKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRyYWNlcG9pbnQobHR0bmdfdXN0
X3B0aHJlYWQsIHB0aHJlYWRfY29uZF9zaWduYWxfZW5kLDxicj4NCiZndDsgY29uZGl0aW9uLDxi
cj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4NCiZndDsgMDs8YnI+DQomZ3Q7IDxicj4NCiZn
dDvCoCDCoHJldHVybiByZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxi
cj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGludCBwdGhyZWFkX2NvbmRfYnJvYWRjYXN0
KHB0aHJlYWQ8d2JyPl9jb25kX3Q8YnI+DQomZ3Q7ICpjb25kaXRpb24pPGJyPg0KJmd0OyA8YnI+
DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHN0YXRpYyBpbnQgKCpjb25kX2Jyb2Fk
Y2FzdCkocHRocmVhZF9jb25kPHdicj5fdDxicj4NCiZndDsgKik7PGJyPg0KJmd0O8KgIMKgaW50
IHJldHZhbDs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBp
ZiAoIWNvbmRfYnJvYWRjYXN0KTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKg
IMKgY29uZF9icm9hZGNhc3QgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJlYWRfY29uZF9i
cm9hZGNhc3QmcXVvdDspOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgaWYgKCFjb25kX2Jy
b2FkY2FzdCk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoGlmICh0
aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgYWJvcnQoKTs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8
YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7dW5hYmxlIHRvIGluaXRp
YWxpemUgcHRocmVhZCB3cmFwcGVyPGJyPg0KJmd0OyBsaWJyYXJ5LlxuJnF1b3Q7KTs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0K
Jmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfYnJvYWRjYXN0KGNvbmRpdGlvbik7PGJyPg0KJmd0OyA8
YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJyPg0KJmd0OyAxOzxicj4NCiZndDsgPGJy
Pg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jy
b2FkY2FzdF9iZWdpbiw8YnI+DQomZ3Q7IGNvbmRpdGlvbiw8YnI+DQomZ3Q7wqAgwqAgwqBMVFRO
R19VU1RfQ0FMTEVSX0lQKCkpOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dmFsID0gY29u
ZF9icm9hZGNhc3QoY29uZGl0aW9uKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRyYWNlcG9p
bnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF9icm9hZGNhc3RfZW5kLDxicj4NCiZn
dDsgY29uZGl0aW9uLDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPTxicj4NCiZndDsgMDs8YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoHJldHVybiByZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgVGhpbmdzIEkgaGF2ZSB0cmllZDo8YnI+DQomZ3Q7IDEt
IENvbW1lbnQgb3V0IHB0aHJlYWRfY29uZF93YWl0IGZ1bmN0aW9uIC0tJmd0OyBzZWdtZW50YXRp
b24gZmF1bHQ8YnI+DQomZ3Q7IDItIENvbW1lbnQgb3V0IHB0aHJlYWRfY29uZF9zaWduYWwgYW5k
IF9icm9hZGNhc3QgLS0mZ3Q7IHN0dWNrIChJIGNhbiBzZWUgdGhlPGJyPg0KJmd0OyBwcm9ncmFt
IGlzIHN0aWxsIHJ1bm5pbmcgYnV0IG5vciBmb3J3YXJkIHByb2dyZXNzIGlzIGJlaW5nIG1hZGUp
IGNvbXBhcmVkPGJyPg0KJmd0OyB0byB0aGUgY2FzZSB3aGVuIHRoZSB3cmFwcGVycyBhcmUgbm90
IHByZWxvYWRlZC48YnI+DQomZ3Q7IDMtIENvbW1lbnQgb3V0IGFsbCB0cmFjZXBvaW50IHJlbGF0
ZWQgY29kZSAoYmFzaWNhbGx5IHRoZSB3cmFwcGVyIGp1c3QgY2FsbDxicj4NCiZndDsgdGhlIGNv
cnJlc3BvbmRpbmcgcHRocmVhZHMgZnVuY3Rpb24pIC0tJmd0OyBzYW1lIHJlc3VsdHMgYXMgcG9p
bnRzIDEgYW5kIDIuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IEFueSBpZGVhIHdoYXQgbWlnaHQgYmUg
Y2F1c2luZyB0aGlzIG9yIGhvdyBJIGNvdWxkIGRlYnVnIHRoaXMgcHJvYmxlbT88YnI+DQomZ3Q7
IDxicj4NCiZndDsgVGhhbmsgeW91IHZlcnkgbXVjaCBpbiBhZHZhbmNlLjxicj4NCiZndDsgPGJy
Pg0KJmd0OyBCZXN0IFJlZ2FyZHMsPGJyPg0KJmd0OyBTaGVoYWI8YnI+DQo8YnI+DQomZ3Q7IGlu
dCBwdGhyZWFkX2NvbmRfd2FpdChwdGhyZWFkX2NvbmQ8d2JyPl90ICpjb25kaXRpb24sIHB0aHJl
YWRfbXV0ZXhfdCAqbXV0ZXgpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyB7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBzdGF0aWMgaW50ICgq
Y29uZF93YWl0KShwdGhyZWFkX2NvbmRfdCAqLCBwdGhyZWFkX211dGV4X3QgKik7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBpbnQgcmV0dmFsO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KJmd0O8KgIMKgaWYgKCFjb25kX3dhaXQpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoGNvbmRfd2FpdCA9IGRsc3ltKFJUTERfTkVYVCwg
JnF1b3Q7cHRocmVhZF9jb25kX3dhaXQmcXVvdDspO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoGlmICghY29uZF93YWl0KSB7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAodGhyZWFk
X2luX3RyYWNlKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
YWJvcnQoKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
wqAgwqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7dW5hYmxl
IHRvIGluaXRpYWxpemUgcHRocmVhZCB3cmFwcGVyIGxpYnJhcnkuXG4mcXVvdDspO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgcmV0dXJuIEVJTlZBTDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB9wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgPGJyPg0KJmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfd2FpdChjb25kaXRpb24sIG11dGV4KTvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiZndDvCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvC
oCDCoHRocmVhZF9pbl90cmFjZSA9IDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJy
Pg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX3dh
aXRfYmVnaW4sIGNvbmRpdGlvbiwgbXV0ZXgswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgTFRU
TkdfVVNUX0NBTExFUl9JUCgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oHJldHZhbCA9IGNvbmRfd2FpdChjb25kaXRpb24sIG11dGV4KTvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oHRyYWNlcG9pbnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF93YWl0X2VuZCwgY29u
ZGl0aW9uLCBtdXRleCzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FM
TEVSX0lQKCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2lu
X3RyYWNlID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqBy
ZXR1cm4gcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4N
CiZndDsgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyBpbnQgcHRocmVh
ZF9jb25kX3NpZ25hbChwdGhyZWFkX2NvPHdicj5uZF90ICpjb25kaXRpb24pwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyB7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7wqAgwqBzdGF0aWMgaW50ICgqY29uZF9zaWduYWwpKHB0aHJlYWRfY29uZF90ICop
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4NCiZndDvCoCDCoGludCByZXR2YWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBpZiAoIWNv
bmRfc2lnbmFsKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqAgwqBjb25kX3NpZ25hbCA9IGRsc3ltKFJUTERfTkVYVCwgJnF1b3Q7cHRocmVhZF9jb25k
X3NpZ25hbCZxdW90Oyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0K
Jmd0O8KgIMKgIMKgaWYgKCFjb25kX3NpZ25hbCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSkge8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGFib3J0KCk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKgfcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O3VuYWJsZSB0byBpbml0aWFs
aXplIHB0aHJlYWQgd3JhcHBlciBsaWJyYXJ5LlxuJnF1b3Q7KTvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoCDCoCDCoHJldHVybiBFSU5WQUw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgfcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgaWYgKHRocmVhZF9pbl90cmFjZSkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDxicj4NCiZndDvCoCDCoCDCoHJldHVybiBjb25kX3NpZ25hbChjb25kaXRpb24pO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9IDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVh
ZF9jb25kX3NpZ25hbF9iZWdpbiwgY29uZGl0aW9uLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoHJldHZhbCA9IGNvbmRfc2lnbmFsKGNvbmRpdGlvbik7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRo
cmVhZF9jb25kX3NpZ25hbF9lbmQsIGNvbmRpdGlvbizCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAwO8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoHJldHVybiByZXR2YWw7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyB9wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IGludCBwdGhyZWFkX2NvbmRfYnJvYWRjYXN0KHB0
aHJlYWQ8d2JyPl9jb25kX3QgKmNvbmRpdGlvbinCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgc3RhdGlj
IGludCAoKmNvbmRfYnJvYWRjYXN0KShwdGhyZWFkX2NvbmQ8d2JyPl90ICopO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgaW50
IHJldHZhbDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICghY29uZF9icm9hZGNhc3QpIHvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBjb25kX2Jyb2Fk
Y2FzdCA9IGRsc3ltKFJUTERfTkVYVCwgJnF1b3Q7cHRocmVhZF9jb25kX2Jyb2FkY2FzdCZxdW90
Oyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgaWYgKCFjb25k
X2Jyb2FkY2FzdCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDC
oCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqBhYm9ydCgpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmlu
dGYoc3RkZXJyLCAmcXVvdDt1bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXIgbGli
cmFyeS5cbiZxdW90Oyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4g
RUlOVkFMO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDC
oCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiZndDvCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5f
dHJhY2UpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBy
ZXR1cm4gY29uZF9icm9hZGNhc3QoY29uZGl0aW9uKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFj
ZSA9IDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgdHJh
Y2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jyb2FkY2FzdF9iZWdpbiwg
Y29uZGl0aW9uLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9DQUxM
RVJfSVAoKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqByZXR2YWwg
PSBjb25kX2Jyb2FkY2FzdChjb25kaXRpb24pO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdHJh
Y2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jyb2FkY2FzdF9lbmQsIGNv
bmRpdGlvbizCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FM
TEVSX0lQKCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFk
X2luX3RyYWNlID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
wqAgwqByZXR1cm4gcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDxicj4NCiZndDsgfcKgIMKgIMKgPGJyPg0KPGJyPg0KPC9kaXY+PC9kaXY+Jmd0OyBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188d2JyPl9fX19fX19fX19fX19fX19fPGJyPg0KJmd0
OyBsdHRuZy1kZXYgbWFpbGluZyBsaXN0PGJyPg0KJmd0OyA8YSBocmVmPSJtYWlsdG86bHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmc8L2E+PGJyPg0KJmd0OyA8YSBocmVmPSJodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmk8d2JyPm4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXY8L2E+PGJyPg0KPHNwYW4gY2xhc3M9Im1fLTU1Njk5NzA1NTA2NjY0MDY1
MjBIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+DQo8YnI+DQotLSA8YnI+DQpKb25h
dGhhbiBSYWpvdHRlLUp1bGllbjxicj4NCkVmZmljaU9TPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pg0KPC9ibG9ja3F1b3RlPjwvZGl2
Pjxicj48L2Rpdj4NCg==
--000000000000aa58b5056d592761--

--===============7003345675335839388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7003345675335839388==--
