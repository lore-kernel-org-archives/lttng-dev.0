From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: lttng_ust_cyg_profile
Date: Fri, 23 Mar 2018 01:13:28 +0000
Message-ID: <CADwgpi_5wd=FcP9FczgrWVqy=SqVW_3c6PWXcd+6ZHaQkZ1qyQ__48342.8897023716$1521767516$gmane$org@mail.gmail.com>
References: <CADwgpi8T=f_JmLDJf9tDAOFztih+mdJ=QFv27+XQkN0w+Mfw-A@mail.gmail.com>
 <20180322192513.GB9345@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6087318164404259466=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 by lists.lttng.org (Postfix) with ESMTPS id 406lsv5qQtzyBZ
 for <lttng-dev@lists.lttng.org>; Thu, 22 Mar 2018 21:13:39 -0400 (EDT)
Received: by mail-ua0-x242.google.com with SMTP id w3so6825904uae.5
 for <lttng-dev@lists.lttng.org>; Thu, 22 Mar 2018 18:13:39 -0700 (PDT)
In-Reply-To: <20180322192513.GB9345@joraj-alpa>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6087318164404259466==
Content-Type: multipart/alternative; boundary="f40304373aec56d21e05680a22db"

--f40304373aec56d21e05680a22db
Content-Type: text/plain; charset="UTF-8"

Response inline.

On Thu, Mar 22, 2018 at 12:25 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Alok,
>
> On Thu, Mar 22, 2018 at 06:31:41PM +0000, Alok Priyadarshi wrote:
> > I am trying to collect a trace for visualizing callstack using
> > lttng_ust_cyg_profile.
> >
> > Even though I have compiled a single source file with
> > -finstrument-functions, I guess it is producing too many events to
> > considerably slow down the instrumented process and cause lost events.
>
> Did you have a look at [1]. A "fast" shared object is available.
>
> [1] https://lttng.org/man/3/lttng-ust-cyg-profile/v2.10/


Yes - I tried both - fast and regular. I did not notice any difference.


>
> >
> > I am using clang, which does not support
> > -finstrument-functions-exclude-file-list.
>
> Might want to give gcc a chance then.
>

The version of gcc I am using has a bug which produces linker errors for
intrinsics when compiled with -finstrument-functions.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78333
I will either need to find a gcc version where this bug is fixed or figure
out a workaround. Using clang seemed easier, but then it does not support
-finstrument-functions-exclude-file-list :|


> > Is there any way to
> > filter lttng_ust_cyg_profile events before they are written to the
> trace? I
> > have tried various things:
> > 1. lttng-track to only track one process
> >
> > 2. Only enable lttng_ust_cyg_profile:* events
> >
> > 3. Increase the subbuffer size:
> > lttng enable-channel --userspace --buffers-pid --subbuf-size=2M
> > --num-subbuf=2 mychannel
>
> Is there any reason you are using --buffer-pid instead of the default
> per-uid buffering?
>

No particular reason. I read somewhere in the mailing list that
--buffer-pid might be less susceptible to lose events. I can switch back to
using the default per-uid buffering if that is better for my usecase.


> > Using this option is very flaky however. It crashes lttng-sessiond.
> >
>
> We will need the log (lttng-sessiond -vvv) (pastebin) and the version of
> lttng for this.
>

OK. I will get you that when I back at work.


> Does your workflow looks somewhat similar to this?
>
> 1) Instrumented app is started with relevant LD_PRELOAD
> 2) lttng create my_session
> 3) lttng enable-channel -u --subbuf-size=2M --num-subbuf=8 my_channel
> 4) lttng enable-event -u -c my_channel 'lttng_ust_cyg_profile:*'
> 5) lttng track -u -p <PID>
> 6) lttng start
> ... some time pass
> 7) lttng stop
> 8) lttng destroy
>
> If a discarded events warning is reported the solution is to increase
> either the
> size or the number of subbuffers per cpu. Note that the upper limit for
> the total
> subbuffers size is dictated by the available free memory of the system.
>

Yup - exactly. Except I am using --num-subbuf=2. I have also tried
--subbuf-size as 4M and 8M, without much success.


> > Any other ideas to filter events?
> >
> > I am also open to explicitly adding tracepoints to the functions I care
> > about. But I am not sure how they can be visualized in trace-compass
> > callstack view.
>
> Neither am I, this might be a better question for the tracecompass mailing
> list.
>

OK. I will ping the tracecompass mailing list. Is there any tool that can
just show events on each thread timeline? I have a multi-threaded
application, and I want to just visualize when functions enter/exit on
various thread with respect to each other.

Using lttng_ust_cyg_profile seemed straightforward, but apparently not.
Thanks for your help Jonathan.

--f40304373aec56d21e05680a22db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Response inline.<br><br><div class=3D"gmail_quote"><div di=
r=3D"ltr">On Thu, Mar 22, 2018 at 12:25 PM Jonathan Rajotte-Julien &lt;<a h=
ref=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien=
@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Alo=
k,<br>
<br>
On Thu, Mar 22, 2018 at 06:31:41PM +0000, Alok Priyadarshi wrote:<br>
&gt; I am trying to collect a trace for visualizing callstack using<br>
&gt; lttng_ust_cyg_profile.<br>
&gt;<br>
&gt; Even though I have compiled a single source file with<br>
&gt; -finstrument-functions, I guess it is producing too many events to<br>
&gt; considerably slow down the instrumented process and cause lost events.=
<br>
<br>
Did you have a look at [1]. A &quot;fast&quot; shared object is available.<=
br>
<br>
[1] <a href=3D"https://lttng.org/man/3/lttng-ust-cyg-profile/v2.10/" rel=3D=
"noreferrer" target=3D"_blank">https://lttng.org/man/3/lttng-ust-cyg-profil=
e/v2.10/</a></blockquote><div><br></div><div>Yes - I tried both - fast and =
regular. I did not notice any difference.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
<br>
&gt;<br>
&gt; I am using clang, which does not support<br>
&gt; -finstrument-functions-exclude-file-list.<br>
<br>
Might want to give gcc a chance then.<br></blockquote><div><br></div><div>T=
he version of gcc I am using has a bug which produces linker errors for int=
rinsics when compiled with -finstrument-functions.=C2=A0<a href=3D"https://=
gcc.gnu.org/bugzilla/show_bug.cgi?id=3D78333">https://gcc.gnu.org/bugzilla/=
show_bug.cgi?id=3D78333</a></div><div>I will either need to find a gcc vers=
ion where this bug is fixed or figure out a workaround. Using clang seemed =
easier, but then it does not support -finstrument-functions-exclude-file-li=
st :|</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; Is there any way to<br>
&gt; filter lttng_ust_cyg_profile events before they are written to the tra=
ce? I<br>
&gt; have tried various things:<br>
&gt; 1. lttng-track to only track one process<br>
&gt;<br>
&gt; 2. Only enable lttng_ust_cyg_profile:* events<br>
&gt;<br>
&gt; 3. Increase the subbuffer size:<br>
&gt; lttng enable-channel --userspace --buffers-pid --subbuf-size=3D2M<br>
&gt; --num-subbuf=3D2 mychannel<br>
<br>
Is there any reason you are using --buffer-pid instead of the default per-u=
id buffering?<br></blockquote><div><br></div><div>No particular reason. I r=
ead somewhere in the mailing list that --buffer-pid might be less susceptib=
le to lose events. I can switch back to using the default per-uid buffering=
 if that is better for my usecase.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
&gt; Using this option is very flaky however. It crashes lttng-sessiond.<br=
>
&gt;<br>
<br>
We will need the log (lttng-sessiond -vvv) (pastebin) and the version of lt=
tng for this.<br></blockquote><div><br></div><div>OK. I will get you that w=
hen I back at work.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
Does your workflow looks somewhat similar to this?<br>
<br>
1) Instrumented app is started with relevant LD_PRELOAD<br>
2) lttng create my_session<br>
3) lttng enable-channel -u --subbuf-size=3D2M --num-subbuf=3D8 my_channel<b=
r>
4) lttng enable-event -u -c my_channel &#39;lttng_ust_cyg_profile:*&#39;<br=
>
5) lttng track -u -p &lt;PID&gt;<br>
6) lttng start<br>
... some time pass<br>
7) lttng stop<br>
8) lttng destroy<br>
<br>
If a discarded events warning is reported the solution is to increase eithe=
r the<br>
size or the number of subbuffers per cpu. Note that the upper limit for the=
 total<br>
subbuffers size is dictated by the available free memory of the system.<br>=
</blockquote><div><br></div><div>Yup - exactly. Except I am using --num-sub=
buf=3D2. I have also tried --subbuf-size as 4M and 8M, without much success=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; Any other ideas to filter events?<br>
&gt;<br>
&gt; I am also open to explicitly adding tracepoints to the functions I car=
e<br>
&gt; about. But I am not sure how they can be visualized in trace-compass<b=
r>
&gt; callstack view.<br>
<br>
Neither am I, this might be a better question for the tracecompass mailing =
list.<br></blockquote><div><br></div><div>OK. I will ping the tracecompass =
mailing list. Is there any tool that can just show events on each thread ti=
meline? I have a multi-threaded application, and I want to just visualize w=
hen functions enter/exit on various thread with respect to each other.=C2=
=A0</div><div><br></div><div>Using lttng_ust_cyg_profile seemed straightfor=
ward, but apparently not. Thanks for your help Jonathan.</div></div></div>

--f40304373aec56d21e05680a22db--

--===============6087318164404259466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6087318164404259466==--
