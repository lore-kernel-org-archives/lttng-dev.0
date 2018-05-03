From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Tracepoints for pthreads conditional variables
Date: Thu, 3 May 2018 16:37:11 -0400
Message-ID: <CAC-H6tuewaghma5hN3R2iCGvpcYVMph1uwti3u0+1ZhZEn44-A__34139.6674550653$1525379717$gmane$org@mail.gmail.com>
References: <CAC-H6tv29C9RdoquefmAs6s-kM6o-RyYFMAYF1a1Vqk0PYX9dQ@mail.gmail.com>
 <20180501143953.GA26829@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8016236041734808316=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com
 [IPv6:2a00:1450:4010:c07::236])
 by lists.lttng.org (Postfix) with ESMTPS id 40cRlZ2sv9z18L1
 for <lttng-dev@lists.lttng.org>; Thu,  3 May 2018 16:37:13 -0400 (EDT)
Received: by mail-lf0-x236.google.com with SMTP id h4-v6so27928170lfc.1
 for <lttng-dev@lists.lttng.org>; Thu, 03 May 2018 13:37:13 -0700 (PDT)
In-Reply-To: <20180501143953.GA26829@joraj-alpa>
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

--===============8016236041734808316==
Content-Type: multipart/alternative; boundary="0000000000000f5bb0056b532b5a"

--0000000000000f5bb0056b532b5a
Content-Type: text/plain; charset="UTF-8"

Thanks for the reply. Here is a link to the repo
https://github.com/ShehabElsayed/LTTng_debugging.git

It contains the LTTng source code I am using and one of the benchmarks that
is causing problems.

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Tue, May 1, 2018 at 10:39 AM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Shehab,
>
> Please provide a link to a lttng-ust git tree or an actual patch (git
> format-patch).
> This will help any person who might be interested in helping you including
> myself.
>
> Cheers
>
> On Tue, May 01, 2018 at 09:31:52AM -0400, Shehab Elsayed wrote:
> > Hi,
> >
> > I am trying to create wrappers for pthreads conditional variables
> functions
> > (wait, signal and broadcast) to insert tracepoints. I followed the same
> > approach done for the mutex functions already provided with lttng,
> however
> > I am running into some problems. Mainly the applications seem to get
> stuck
> > when the conditional variable wrappers are enabled.
> >
> > Here is my implementation for the wrapper functions:
> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
> > *mutex)
> >
> > {
> >
> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t
> > *);
> >   int retval;
> >
> >
> >
> >   if (!cond_wait)
> > {
> >
> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
> >
> >     if (!cond_wait)
> > {
> >
> >       if (thread_in_trace)
> > {
> >
> >
> > abort();
> >
> >
> > }
> >
> >       fprintf(stderr, "unable to initialize pthread wrapper
> > library.\n");
> >       return EINVAL;
> >
> >
> > }
> >
> >
> > }
> >
> >   if (thread_in_trace)
> > {
> >
> >     return cond_wait(condition, mutex);
> >
> >
> > }
> >
> >
> >
> >   thread_in_trace =
> > 1;
> >
> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
> > mutex,
> >
> >     LTTNG_UST_CALLER_IP());
> >
> >   retval = cond_wait(condition, mutex);
> >
> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
> > mutex,
> >
> >     LTTNG_UST_CALLER_IP());
> >
> >   thread_in_trace =
> > 0;
> >
> >   return retval;
> >
> > }
> >
> >
> >
> > int pthread_cond_signal(pthread_cond_t
> > *condition)
> >
> > {
> >
> >   static int (*cond_signal)(pthread_cond_t
> > *);
> >
> >   int retval;
> >
> >
> >
> >   if (!cond_signal)
> > {
> >
> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
> >
> >     if (!cond_signal)
> > {
> >
> >       if (thread_in_trace)
> > {
> >
> >
> > abort();
> >
> >
> > }
> >
> >       fprintf(stderr, "unable to initialize pthread wrapper
> > library.\n");
> >       return EINVAL;
> >
> >
> > }
> >
> >
> > }
> >
> >   if (thread_in_trace)
> > {
> >
> >     return cond_signal(condition);
> >
> >
> > }
> >
> >
> >
> >   thread_in_trace =
> > 1;
> >
> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin,
> > condition,
> >     LTTNG_UST_CALLER_IP());
> >
> >   retval = cond_signal(condition);
> >
> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end,
> > condition,
> >     LTTNG_UST_CALLER_IP());
> >
> >   thread_in_trace =
> > 0;
> >
> >   return retval;
> >
> > }
> >
> >
> >
> > int pthread_cond_broadcast(pthread_cond_t
> > *condition)
> >
> > {
> >
> >   static int (*cond_broadcast)(pthread_cond_t
> > *);
> >   int retval;
> >
> >
> >
> >   if (!cond_broadcast)
> > {
> >
> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
> >
> >     if (!cond_broadcast)
> > {
> >
> >       if (thread_in_trace)
> > {
> >
> >
> > abort();
> >
> >
> > }
> >
> >       fprintf(stderr, "unable to initialize pthread wrapper
> > library.\n");
> >       return EINVAL;
> >
> >
> > }
> >
> >
> > }
> >
> >   if (thread_in_trace)
> > {
> >
> >     return cond_broadcast(condition);
> >
> >
> > }
> >
> >
> >
> >   thread_in_trace =
> > 1;
> >
> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
> > condition,
> >     LTTNG_UST_CALLER_IP());
> >
> >   retval = cond_broadcast(condition);
> >
> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end,
> > condition,
> >     LTTNG_UST_CALLER_IP());
> >
> >   thread_in_trace =
> > 0;
> >
> >   return retval;
> >
> > }
> >
> > Things I have tried:
> > 1- Comment out pthread_cond_wait function --> segmentation fault
> > 2- Comment out pthread_cond_signal and _broadcast --> stuck (I can see
> the
> > program is still running but nor forward progress is being made) compared
> > to the case when the wrappers are not preloaded.
> > 3- Comment out all tracepoint related code (basically the wrapper just
> call
> > the corresponding pthreads function) --> same results as points 1 and 2.
> >
> > Any idea what might be causing this or how I could debug this problem?
> >
> > Thank you very much in advance.
> >
> > Best Regards,
> > Shehab
>
> > int pthread_cond_wait(pthread_cond_t *condition, pthread_mutex_t
> *mutex)
> > {
>
>
>
> >   static int (*cond_wait)(pthread_cond_t *, pthread_mutex_t *);
>
> >   int retval;
>
> >
>
> >   if (!cond_wait) {
>
> >     cond_wait = dlsym(RTLD_NEXT, "pthread_cond_wait");
>
> >     if (!cond_wait) {
>
> >       if (thread_in_trace) {
>
> >         abort();
>
> >       }
>
> >       fprintf(stderr, "unable to initialize pthread wrapper
> library.\n");
> >       return EINVAL;
>
> >     }
>
> >   }
>
> >   if (thread_in_trace) {
>
> >     return cond_wait(condition, mutex);
>
> >   }
>
> >
>
> >   thread_in_trace = 1;
>
> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_begin, condition,
> mutex,
> >     LTTNG_UST_CALLER_IP());
>
> >   retval = cond_wait(condition, mutex);
>
> >   tracepoint(lttng_ust_pthread, pthread_cond_wait_end, condition,
> mutex,
> >     LTTNG_UST_CALLER_IP());
>
> >   thread_in_trace = 0;
>
> >   return retval;
>
> > }
>
> >
>
> > int pthread_cond_signal(pthread_cond_t *condition)
>
> > {
>
> >   static int (*cond_signal)(pthread_cond_t *);
>
> >   int retval;
>
> >
>
> >   if (!cond_signal) {
>
> >     cond_signal = dlsym(RTLD_NEXT, "pthread_cond_signal");
>
> >     if (!cond_signal) {
>
> >       if (thread_in_trace) {
>
> >         abort();
>
> >       }
>
> >       fprintf(stderr, "unable to initialize pthread wrapper
> library.\n");
> >       return EINVAL;
>
> >     }
>
> >   }
>
> >   if (thread_in_trace) {
>
> >     return cond_signal(condition);
>
> >   }
>
> >
>
> >   thread_in_trace = 1;
>
> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_begin, condition,
>
> >     LTTNG_UST_CALLER_IP());
>
> >   retval = cond_signal(condition);
>
> >   tracepoint(lttng_ust_pthread, pthread_cond_signal_end, condition,
>
> >     LTTNG_UST_CALLER_IP());
>
> >   thread_in_trace = 0;
>
> >   return retval;
>
> > }
>
> >
>
> > int pthread_cond_broadcast(pthread_cond_t *condition)
>
> > {
>
> >   static int (*cond_broadcast)(pthread_cond_t *);
>
> >   int retval;
>
> >
>
> >   if (!cond_broadcast) {
>
> >     cond_broadcast = dlsym(RTLD_NEXT, "pthread_cond_broadcast");
>
> >     if (!cond_broadcast) {
>
> >       if (thread_in_trace) {
>
> >         abort();
>
> >       }
>
> >       fprintf(stderr, "unable to initialize pthread wrapper
> library.\n");
> >       return EINVAL;
>
> >     }
>
> >   }
>
> >   if (thread_in_trace) {
>
> >     return cond_broadcast(condition);
>
> >   }
>
> >
>
> >   thread_in_trace = 1;
>
> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_begin,
> condition,
> >     LTTNG_UST_CALLER_IP());
>
> >   retval = cond_broadcast(condition);
>
> >   tracepoint(lttng_ust_pthread, pthread_cond_broadcast_end, condition,
>
> >     LTTNG_UST_CALLER_IP());
>
> >   thread_in_trace = 0;
>
> >   return retval;
>
> > }
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000000f5bb0056b532b5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGFua3MgZm9yIHRoZSByZXBseS4gSGVyZSBpcyBhIGxpbmsg
dG8gdGhlIHJlcG8gPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL1NoZWhhYkVsc2F5ZWQvTFRU
bmdfZGVidWdnaW5nLmdpdCI+aHR0cHM6Ly9naXRodWIuY29tL1NoZWhhYkVsc2F5ZWQvTFRUbmdf
ZGVidWdnaW5nLmdpdDwvYT48YnI+PGJyPjwvZGl2Pkl0IGNvbnRhaW5zIHRoZSBMVFRuZyBzb3Vy
Y2UgY29kZSBJIGFtIHVzaW5nIGFuZCBvbmUgb2YgdGhlIGJlbmNobWFya3MgdGhhdCBpcyBjYXVz
aW5nIHByb2JsZW1zLjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyIGNsZWFy
PSJhbGwiPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIiBkYXRhLXNtYXJ0bWFpbD0i
Z21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+U2hl
aGFiIFkuIEVsc2F5ZWQsIE1TYy48YnI+DQpQaEQgU3R1ZGVudDxicj5UaGUgRWR3YXJkcyBTLiBS
b2dlcnMgU3IuIERlcHQuIG9mIEVsZWN0cmljYWwgYW5kIENvbXB1dGVyIEVuZ2luZWVyaW5nPGJy
PlVuaXZlcnNpdHkgb2YgVG9yb250byA8L2ZvbnQ+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxhIHZh
bHVlPSIrMjAxMjQ0OTgzNjAiPjxzcGFuIGRpcj0ibHRyIj48L3NwYW4+PC9hPjxicj4NCkUtbWFp
bDogPGEgaHJlZj0iaHR0cHM6Ly93ZWJtYWlsLnJpY2UuZWR1L2ltcC9tZXNzYWdlLnBocD9tYWls
Ym94PUlOQk9YJmFtcDtpbmRleD0xMSMiIHRhcmdldD0iX2JsYW5rIj5zaGVoYWJ5b21uQGdtYWls
LmNvbTwvYT48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9kaXY+DQo8YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPk9uIFR1ZSwgTWF5IDEsIDIwMTggYXQgMTA6MzkgQU0sIEpvbmF0aGFuIFJham90dGUt
SnVsaWVuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmpvbmF0aGFuLnJham90
dGUtanVsaWVuQGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmpvbmF0aGFuLnJham90dGUt
anVsaWVuQGVmZmljaW9zLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgU2hlaGFiLDxicj4NCjxicj4NClBs
ZWFzZSBwcm92aWRlIGEgbGluayB0byBhIGx0dG5nLXVzdCBnaXQgdHJlZSBvciBhbiBhY3R1YWwg
cGF0Y2ggKGdpdCBmb3JtYXQtcGF0Y2gpLjxicj4NClRoaXMgd2lsbCBoZWxwIGFueSBwZXJzb24g
d2hvIG1pZ2h0IGJlIGludGVyZXN0ZWQgaW4gaGVscGluZyB5b3UgaW5jbHVkaW5nPGJyPg0KbXlz
ZWxmLjxicj4NCjxicj4NCkNoZWVyczxicj4NCjxkaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4NCk9u
IFR1ZSwgTWF5IDAxLCAyMDE4IGF0IDA5OjMxOjUyQU0gLTA0MDAsIFNoZWhhYiBFbHNheWVkIHdy
b3RlOjxicj4NCiZndDsgSGksPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IEkgYW0gdHJ5aW5nIHRvIGNy
ZWF0ZSB3cmFwcGVycyBmb3IgcHRocmVhZHMgY29uZGl0aW9uYWwgdmFyaWFibGVzIGZ1bmN0aW9u
czxicj4NCiZndDsgKHdhaXQsIHNpZ25hbCBhbmQgYnJvYWRjYXN0KSB0byBpbnNlcnQgdHJhY2Vw
b2ludHMuIEkgZm9sbG93ZWQgdGhlIHNhbWU8YnI+DQomZ3Q7IGFwcHJvYWNoIGRvbmUgZm9yIHRo
ZSBtdXRleCBmdW5jdGlvbnMgYWxyZWFkeSBwcm92aWRlZCB3aXRoIGx0dG5nLCBob3dldmVyPGJy
Pg0KJmd0OyBJIGFtIHJ1bm5pbmcgaW50byBzb21lIHByb2JsZW1zLiBNYWlubHkgdGhlIGFwcGxp
Y2F0aW9ucyBzZWVtIHRvIGdldCBzdHVjazxicj4NCiZndDsgd2hlbiB0aGUgY29uZGl0aW9uYWwg
dmFyaWFibGUgd3JhcHBlcnMgYXJlIGVuYWJsZWQuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IEhlcmUg
aXMgbXkgaW1wbGVtZW50YXRpb24gZm9yIHRoZSB3cmFwcGVyIGZ1bmN0aW9uczo8YnI+DQomZ3Q7
IGludCBwdGhyZWFkX2NvbmRfd2FpdChwdGhyZWFkXzx3YnI+Y29uZF90ICpjb25kaXRpb24sIHB0
aHJlYWRfbXV0ZXhfdDxicj4NCiZndDsgKm11dGV4KTxicj4NCiZndDsgPGJyPg0KJmd0OyB7PGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqBzdGF0aWMgaW50ICgqY29uZF93YWl0KShwdGhyZWFkX2Nv
bmRfdCAqLCBwdGhyZWFkX211dGV4X3Q8YnI+DQomZ3Q7ICopOzxicj4NCiZndDvCoCDCoGludCBy
ZXR2YWw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgaWYg
KCFjb25kX3dhaXQpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBjb25k
X3dhaXQgPSBkbHN5bShSVExEX05FWFQsICZxdW90O3B0aHJlYWRfY29uZF93YWl0JnF1b3Q7KTs8
YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoGlmICghY29uZF93YWl0KTxicj4NCiZndDsgezxi
cj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSk8YnI+DQom
Z3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBhYm9ydCgpOzxicj4NCiZndDsg
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoGZw
cmludGYoc3RkZXJyLCAmcXVvdDt1bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXI8
YnI+DQomZ3Q7IGxpYnJhcnkuXG4mcXVvdDspOzxicj4NCiZndDvCoCDCoCDCoCDCoHJldHVybiBF
SU5WQUw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5f
dHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29u
ZF93YWl0KGNvbmRpdGlvbiwgbXV0ZXgpOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7
IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0aHJlYWRf
aW5fdHJhY2UgPTxicj4NCiZndDsgMTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRyYWNlcG9p
bnQobHR0bmdfdXN0X3B0aHJlYWQsIHB0aHJlYWRfY29uZF93YWl0X2JlZ2luLCBjb25kaXRpb24s
PGJyPg0KJmd0OyBtdXRleCw8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoExUVE5HX1VTVF9D
QUxMRVJfSVAoKSk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqByZXR2YWwgPSBjb25kX3dhaXQo
Y29uZGl0aW9uLCBtdXRleCk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0
dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRfd2FpdF9lbmQsIGNvbmRpdGlvbiw8YnI+DQom
Z3Q7IG11dGV4LDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9J
UCgpKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJyPg0KJmd0
OyAwOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDs8YnI+DQomZ3Q7IDxi
cj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgaW50
IHB0aHJlYWRfY29uZF9zaWduYWwocHRocmVhZF88d2JyPmNvbmRfdDxicj4NCiZndDsgKmNvbmRp
dGlvbik8YnI+DQomZ3Q7IDxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgc3Rh
dGljIGludCAoKmNvbmRfc2lnbmFsKShwdGhyZWFkX2NvbmRfdDxicj4NCiZndDsgKik7PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqBpbnQgcmV0dmFsOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoGlmICghY29uZF9zaWduYWwpPGJyPg0KJmd0OyB7PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBjb25kX3NpZ25hbCA9IGRsc3ltKFJUTERfTkVYVCwgJnF1
b3Q7cHRocmVhZF9jb25kX3NpZ25hbCZxdW90Oyk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAg
wqBpZiAoIWNvbmRfc2lnbmFsKTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKg
IMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgPGJyPg0KJmd0OyBhYm9ydCgpOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08
YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDt1bmFi
bGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXI8YnI+DQomZ3Q7IGxpYnJhcnkuXG4mcXVv
dDspOzxicj4NCiZndDvCoCDCoCDCoCDCoHJldHVybiBFSU5WQUw7PGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+DQom
Z3Q7IDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29uZF9zaWduYWwoY29uZGl0aW9uKTs8YnI+
DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4N
CiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID08YnI+DQomZ3Q7IDE7PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFk
X2NvbmRfc2lnbmFsX2JlZ2luLDxicj4NCiZndDsgY29uZGl0aW9uLDxicj4NCiZndDvCoCDCoCDC
oExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqByZXR2YWwg
PSBjb25kX3NpZ25hbChjb25kaXRpb24pOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdHJhY2Vw
b2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX3NpZ25hbF9lbmQsPGJyPg0KJmd0
OyBjb25kaXRpb24sPGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTs8YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJyPg0KJmd0OyAwOzxicj4N
CiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDs8YnI+DQomZ3Q7IDxicj4NCiZndDsg
fTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgaW50IHB0aHJlYWRf
Y29uZF9icm9hZGNhc3QoPHdicj5wdGhyZWFkX2NvbmRfdDxicj4NCiZndDsgKmNvbmRpdGlvbik8
YnI+DQomZ3Q7IDxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgc3RhdGljIGlu
dCAoKmNvbmRfYnJvYWRjYXN0KShwdGhyZWFkXzx3YnI+Y29uZF90PGJyPg0KJmd0OyAqKTs8YnI+
DQomZ3Q7wqAgwqBpbnQgcmV0dmFsOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoGlmICghY29uZF9icm9hZGNhc3QpPGJyPg0KJmd0OyB7PGJyPg0KJmd0OyA8
YnI+DQomZ3Q7wqAgwqAgwqBjb25kX2Jyb2FkY2FzdCA9IGRsc3ltKFJUTERfTkVYVCwgJnF1b3Q7
cHRocmVhZF9jb25kX2Jyb2FkY2FzdCZxdW90Oyk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAg
wqBpZiAoIWNvbmRfYnJvYWRjYXN0KTxicj4NCiZndDsgezxicj4NCiZndDsgPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSk8YnI+DQomZ3Q7IHs8YnI+DQomZ3Q7IDxicj4N
CiZndDsgPGJyPg0KJmd0OyBhYm9ydCgpOzxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7
IH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDt1
bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXI8YnI+DQomZ3Q7IGxpYnJhcnkuXG4m
cXVvdDspOzxicj4NCiZndDvCoCDCoCDCoCDCoHJldHVybiBFSU5WQUw7PGJyPg0KJmd0OyA8YnI+
DQomZ3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IH08YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpPGJyPg0KJmd0OyB7PGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29uZF9icm9hZGNhc3QoY29uZGl0aW9u
KTs8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID08YnI+DQomZ3Q7IDE7
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBw
dGhyZWFkX2NvbmRfYnJvYWRjYXN0X2JlZ2luLDxicj4NCiZndDsgY29uZGl0aW9uLDxicj4NCiZn
dDvCoCDCoCDCoExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAg
wqByZXR2YWwgPSBjb25kX2Jyb2FkY2FzdChjb25kaXRpb24pOzxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25kX2Jyb2FkY2Fz
dF9lbmQsPGJyPg0KJmd0OyBjb25kaXRpb24sPGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NB
TExFUl9JUCgpKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9PGJy
Pg0KJmd0OyAwOzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJldHZhbDs8YnI+DQom
Z3Q7IDxicj4NCiZndDsgfTxicj4NCiZndDsgPGJyPg0KJmd0OyBUaGluZ3MgSSBoYXZlIHRyaWVk
Ojxicj4NCiZndDsgMS0gQ29tbWVudCBvdXQgcHRocmVhZF9jb25kX3dhaXQgZnVuY3Rpb24gLS0m
Z3Q7IHNlZ21lbnRhdGlvbiBmYXVsdDxicj4NCiZndDsgMi0gQ29tbWVudCBvdXQgcHRocmVhZF9j
b25kX3NpZ25hbCBhbmQgX2Jyb2FkY2FzdCAtLSZndDsgc3R1Y2sgKEkgY2FuIHNlZSB0aGU8YnI+
DQomZ3Q7IHByb2dyYW0gaXMgc3RpbGwgcnVubmluZyBidXQgbm9yIGZvcndhcmQgcHJvZ3Jlc3Mg
aXMgYmVpbmcgbWFkZSkgY29tcGFyZWQ8YnI+DQomZ3Q7IHRvIHRoZSBjYXNlIHdoZW4gdGhlIHdy
YXBwZXJzIGFyZSBub3QgcHJlbG9hZGVkLjxicj4NCiZndDsgMy0gQ29tbWVudCBvdXQgYWxsIHRy
YWNlcG9pbnQgcmVsYXRlZCBjb2RlIChiYXNpY2FsbHkgdGhlIHdyYXBwZXIganVzdCBjYWxsPGJy
Pg0KJmd0OyB0aGUgY29ycmVzcG9uZGluZyBwdGhyZWFkcyBmdW5jdGlvbikgLS0mZ3Q7IHNhbWUg
cmVzdWx0cyBhcyBwb2ludHMgMSBhbmQgMi48YnI+DQomZ3Q7IDxicj4NCiZndDsgQW55IGlkZWEg
d2hhdCBtaWdodCBiZSBjYXVzaW5nIHRoaXMgb3IgaG93IEkgY291bGQgZGVidWcgdGhpcyBwcm9i
bGVtPzxicj4NCiZndDsgPGJyPg0KJmd0OyBUaGFuayB5b3UgdmVyeSBtdWNoIGluIGFkdmFuY2Uu
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IEJlc3QgUmVnYXJkcyw8YnI+DQomZ3Q7IFNoZWhhYjxicj4N
Cjxicj4NCiZndDsgaW50IHB0aHJlYWRfY29uZF93YWl0KHB0aHJlYWRfPHdicj5jb25kX3QgKmNv
bmRpdGlvbiwgcHRocmVhZF9tdXRleF90ICptdXRleCnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
IHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oHN0YXRpYyBpbnQgKCpjb25kX3dhaXQpKHB0aHJlYWRfY29uZF90ICosIHB0aHJlYWRfbXV0ZXhf
dCAqKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGludCByZXR2
YWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBpZiAoIWNvbmRfd2FpdCkge8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgY29uZF93YWl0ID0gZGxz
eW0oUlRMRF9ORVhULCAmcXVvdDtwdGhyZWFkX2NvbmRfd2FpdCZxdW90Oyk7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgaWYgKCFjb25k
X3dhaXQpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDC
oCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqBhYm9ydCgpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDxicj4NCiZndDvCoCDCoCDCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJy
LCAmcXVvdDt1bmFibGUgdG8gaW5pdGlhbGl6ZSBwdGhyZWFkIHdyYXBwZXIgbGlicmFyeS5cbiZx
dW90Oyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gRUlOVkFMO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoH3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvC
oCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoGlmICh0aHJlYWRfaW5fdHJhY2UpIHvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqByZXR1cm4gY29uZF93YWl0KGNvbmRp
dGlvbiwgbXV0ZXgpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID0gMTvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBw
dGhyZWFkX2NvbmRfd2FpdF9iZWdpbiwgY29uZGl0aW9uLCBtdXRleCzCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQom
Z3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgcmV0dmFsID0gY29uZF93YWl0KGNvbmRpdGlvbiwgbXV0ZXgpO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgdHJhY2Vwb2ludChsdHRuZ191c3RfcHRocmVhZCwgcHRocmVhZF9jb25k
X3dhaXRfZW5kLCBjb25kaXRpb24sIG11dGV4LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDC
oExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAwO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4NCiZndDvCoCDCoHJldHVybiByZXR2YWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgPGJyPg0KJmd0OyB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7IGludCBwdGhyZWFkX2NvbmRfc2lnbmFsKHB0aHJlYWRfPHdicj5jb25kX3QgKmNvbmRpdGlv
binCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQom
Z3Q7IHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoHN0YXRpYyBpbnQgKCpjb25kX3NpZ25hbCkocHRo
cmVhZF9jb25kX3QgKik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgaW50IHJldHZhbDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDvCoCDCoGlmICghY29uZF9zaWduYWwpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoCDCoGNvbmRfc2lnbmFsID0gZGxzeW0oUlRMRF9ORVhULCAmcXVv
dDtwdGhyZWFkX2NvbmRfc2lnbmFsJnF1b3Q7KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqBpZiAoIWNvbmRfc2lnbmFsKSB7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAodGhyZWFkX2luX3Ry
YWNlKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgYWJv
cnQoKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
wqAgwqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7dW5h
YmxlIHRvIGluaXRpYWxpemUgcHRocmVhZCB3cmFwcGVyIGxpYnJhcnkuXG4mcXVvdDspO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgcmV0dXJuIEVJTlZBTDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAg
wqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqBpZiAodGhyZWFkX2luX3RyYWNlKSB7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgcmV0dXJuIGNvbmRfc2lnbmFsKGNv
bmRpdGlvbik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgfcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgdGhyZWFkX2luX3RyYWNlID0gMTvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9w
dGhyZWFkLCBwdGhyZWFkX2NvbmRfc2lnbmFsX2JlZ2luLCBjb25kaXRpb24swqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBMVFROR19VU1RfQ0FMTEVSX0lQKCkpO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgcmV0dmFsID0gY29uZF9zaWduYWwoY29u
ZGl0aW9uKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3Vz
dF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRfc2lnbmFsX2VuZCwgY29uZGl0aW9uLMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgTFRUTkdfVVNUX0NBTExFUl9JUCgpKTvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoHRocmVhZF9pbl90cmFjZSA9IDA7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgcmV0dXJuIHJl
dHZhbDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7
IH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsgaW50IHB0aHJlYWRfY29u
ZF9icm9hZGNhc3QoPHdicj5wdGhyZWFkX2NvbmRfdCAqY29uZGl0aW9uKcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyB7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7wqAgwqBzdGF0aWMgaW50ICgqY29uZF9icm9hZGNhc3QpKHB0aHJlYWRfPHdicj5jb25kX3Qg
Kik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqBpbnQgcmV0dmFsO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgaWYgKCFjb25k
X2Jyb2FkY2FzdCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDC
oCDCoGNvbmRfYnJvYWRjYXN0ID0gZGxzeW0oUlRMRF9ORVhULCAmcXVvdDtwdGhyZWFkX2NvbmRf
YnJvYWRjYXN0JnF1b3Q7KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQomZ3Q7wqAg
wqAgwqBpZiAoIWNvbmRfYnJvYWRjYXN0KSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgaWYgKHRocmVhZF9pbl90cmFjZSkge8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGFib3J0KCk7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKgfcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O3VuYWJsZSB0byBpbml0aWFsaXplIHB0aHJl
YWQgd3JhcHBlciBsaWJyYXJ5LlxuJnF1b3Q7KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oCDCoCDCoHJldHVybiBFSU5WQUw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
PGJyPg0KJmd0O8KgIMKgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKg
aWYgKHRocmVhZF9pbl90cmFjZSkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4N
CiZndDvCoCDCoCDCoHJldHVybiBjb25kX2Jyb2FkY2FzdChjb25kaXRpb24pO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKg
dGhyZWFkX2luX3RyYWNlID0gMTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+
DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRfYnJv
YWRjYXN0X2JlZ2luLCBjb25kaXRpb24swqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0O8KgIMKgIMKg
TFRUTkdfVVNUX0NBTExFUl9JUCgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDvCoCDCoHJldHZhbCA9IGNvbmRfYnJvYWRjYXN0KGNvbmRpdGlvbik7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqB0cmFjZXBvaW50KGx0dG5nX3VzdF9wdGhyZWFkLCBwdGhyZWFkX2NvbmRfYnJv
YWRjYXN0X2VuZCwgY29uZGl0aW9uLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCiZndDvCoCDCoCDC
oExUVE5HX1VTVF9DQUxMRVJfSVAoKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7wqAgwqB0aHJlYWRfaW5fdHJhY2UgPSAwO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDxicj4NCiZndDvCoCDCoHJldHVybiByZXR2YWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyB9wqAgwqAgwqA8YnI+DQo8YnI+DQo8L2Rpdj48
L2Rpdj4mZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzx3YnI+X19fX19fX19fX19f
X19fX188YnI+DQomZ3Q7IGx0dG5nLWRldiBtYWlsaW5nIGxpc3Q8YnI+DQomZ3Q7IDxhIGhyZWY9
Im1haWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIj5sdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnPC9hPjxicj4NCiZndDsgPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldiIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLTx3YnI+YmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2PC9hPjxicj4NCjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIj
ODg4ODg4Ij48YnI+DQo8YnI+DQotLSA8YnI+DQpKb25hdGhhbiBSYWpvdHRlLUp1bGllbjxicj4N
CkVmZmljaU9TPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2
Pg0K
--0000000000000f5bb0056b532b5a--

--===============8016236041734808316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8016236041734808316==--
