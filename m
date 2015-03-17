From: =?UTF-8?Q?Fran=C3=A7ois_Doray?= <francois.doray@gmail.com>
Subject: Re: Userspace Tracing and Backtraces
Date: Tue, 17 Mar 2015 14:50:27 -0400
Message-ID: <CAHq3sd+vOGd22ZMu=hrj33sagHmAa9LR2vS39utUy1Hx+CRWcQ__35906.6402110786$1426621596$gmane$org@mail.gmail.com>
References: <BY2SR01MB595A5A400E2211CC7567298C81F0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM6VLGQgjF4tS1dLg749rEZ8DKMMda=DsrihLCoQ9sHPdw@mail.gmail.com>
 <BY2SR01MB5952376CA9DE7B8211078C8C81C0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM4AXG5btHdaoHjuCwzCDvPn9AORyh8gvo-VOua7ndWF2w@mail.gmail.com>
 <CH1SR01MB5996051E5E9E51406F6502DC81B0@CH1SR01MB599.namsdf01.sdf.exchangelabs.com>
 <353474327.273521.1426038464379.JavaMail.zimbra@efficios.com>
 <CAC6yHM4QSUhv4mw0HzhENDY32BrmckQwvX==gAvw0ej3mwBGAg@mail.gmail.com>
 <BY2SR01MB59586D89F6A546404D75DE3C8030@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0716984201=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francois.doray@gmail.com>) id 1YXwZo-0007dA-W9
 for lttng-dev@lists.lttng.org; Tue, 17 Mar 2015 14:50:57 -0400
Received: by obdfc2 with SMTP id fc2so14758200obd.3
 for <lttng-dev@lists.lttng.org>; Tue, 17 Mar 2015 11:50:47 -0700 (PDT)
In-Reply-To: <BY2SR01MB59586D89F6A546404D75DE3C8030@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Brian Robbins <brianrob@microsoft.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0716984201==
Content-Type: multipart/alternative; boundary=001a113debdade769a0511807117

--001a113debdade769a0511807117
Content-Type: text/plain; charset=UTF-8

Hi,

I worked on these 2 optimizations to libunwind:
- I replaced the global cache by a thread-local cache. This removes the
need for some locking.
- Instead of restoring all registers for every stack frame, I restore only
EBP, EIP and ESP.

The code is here:
https://github.com/fdoray/libunwind/tree/minimal_regs
Warning: This version of the library is no longer signal-safe and has
undefined behavior if more registers than EBP/EIP/ESP are required to
unwind a stack frame (this never happened in the few tests that I made so
far). These two limitations could easily be overcome in the future.

Performance results, on x86_64:

unw_backtrace(), original libunwind
Mean time per backtrace: 6130 ns / 80% of samples between 1479 and 13837 ns

unw_backtrace(), modified libunwind ***
Mean time per backtrace: 4255 ns / 80% of samples between 1526 and 5252 ns.

unw_step()/unw_get_reg() [1], original libuwndin
Mean time per backtrace: 43520 ns / 80% of samples between 13705 and 58782
ns.

unw_step()/unw_get_reg(), modified libunwind
Mean time per backtrace: 5804 ns / 80% of samples between 2844 and 11325 ns.

Francois

[1] As in the example presented here:
http://www.nongnu.org/libunwind/man/libunwind(3).html


On Mon, Mar 16, 2015 at 8:35 PM, Brian Robbins <brianrob@microsoft.com>
wrote:

>  Hi All,
>
>
>
> This is great.  Thank you very much for the information.
>
>
>
> -Brian
>
>
>
> *From:* Francis Giraldeau [mailto:francis.giraldeau@gmail.com]
> *Sent:* Thursday, March 12, 2015 11:34 AM
> *To:* Mathieu Desnoyers
> *Cc:* Brian Robbins; lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] Userspace Tracing and Backtraces
>
>
>
> 2015-03-10 21:47 GMT-04:00 Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com>:
>
>  Francis: Did you define UNW_LOCAL_ONLY before including
>
> the libunwind header in your benchmarks ? (see
>
> http://www.nongnu.org/libunwind/man/libunwind%283%29.html)
>
>
>
> The seems to change performance dramatically according to the
> documentation.
>
>
>
>
>
> Yes, this is the case. Time to unwind is higher at the beginning (probably
> related to internal cache build), and also vary according to call-stack
> depth.
>
>
>
>  Agreed on having the backtrace as a context. The main question left is
>
> to figure out if we want to call libunwind from within the traced
> application
>
> execution context.
>
>
>
> Unfortunately, libunwind is not reentrant wrt signals. This is already
>
> a good argument for not calling it from within a tracepoint. I wonder
>
> if the authors of libunwind would be open to make it signal-reentrant
>
> in the future (not by disabling signals, but rather by keeping a TLS
>
> nesting counter, and returning an error if nested, for performance
>
> considerations).
>
>
>
> The functions unw_init_local() and unw_step() are signal safe [1]. The
> critical sections are protected using lock_acquire() that blocks all
> signals before taking the mutex, which prevent the recursion.
>
>
>
> #define lock_acquire(l,m)                               \
>
> do {                                                    \
>
>   SIGPROCMASK (SIG_SETMASK, &unwi_full_mask, &(m));     \
>
>   mutex_lock (l);                                       \
>
> } while (0)
>
> #define lock_release(l,m)                       \
>
> do {                                            \
>
>   mutex_unlock (l);                             \
>
>   SIGPROCMASK (SIG_SETMASK, &(m), NULL);        \
>
> } while (0)
>
>
>
> To understand the implications, I did a small program to study nested
> signals [2], where a signal is sent from within a signal, or when
> segmentation fault occurs in a signal handler. Blocking a signal differs it
> when it is unblocked, while ignored signals are discarded. Blocked signals
> that can't be ignored have their default behaviour. It prevents a possible
> deadlock, let's say if lock_acquire() was nesting with a custom SIGSEGV
> handler trying to get the same lock.
>
>
>
> So, let's say that instead of blocking signals, we have a per-thread
> mutex, that returns if try_lock() fails. It would be faster, but from the
> user's point of view, the backtrace will be dropped randomly. I would
> prefer it a bit slower, but reliable.
>
>
>
> In addition, could it be possible that TLS is not signal safe [3]?
>
>      or using the perf capture mechanism that you describe below?
>
>  Perf is peeking at the userspace from kernel space, it's another story.
> I guess that libunwind was not ported to the kernel because it is a large
> chunk of complicated code that performs a lot of I/O and computation, while
> copying a portion of the stack is really about KISS and low runtime
> overhead.
>
>  If using libunwind does not work out, another alternative I would
> consider
>
> would be to copy the stack like perf is doing from the kernel. However,
>
> in the spirit of compacting trace data, I would be tempted to do the
> following
>
> if we go down that route: check each pointer-aligned address for its
> content.
>
> If it looks like a pointer to an executable memory area (library,
> executable, or
>
> JIT'd code), we keep it. Else, we zero this information (not needed). We
> can
>
> then do a RLE-alike compression on the zeroes, so we can keep the layout
>
> of the stack after uncompression.
>
>
>
>
>
> Interesting! For comparison, here is a perf event [4] that shows there is
> a lot of room for reducing the event size. We should check if discarding
> other saved register values on the stack impacts restoring the instruction
> pointer register. Doing the unwind offline also solves signal safety,
> should be fast and scalable.
>
>
>
> Francis
>
>
>
> [1] http://www.nongnu.org/libunwind/man/unw_init_local(3).html
>
> [2] https://gist.github.com/giraldeau/98f08161e83a7ab800ea
>
> [3] https://sourceware.org/glibc/wiki/TLSandSignals
>
> [4] http://pastebin.com/sByfXXAQ
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--001a113debdade769a0511807117
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I worked on these 2 optimizations t=
o libunwind:</div><div>- I replaced the global cache by a thread-local cach=
e. This removes the need for some locking.</div><div>- Instead of restoring=
 all registers for every stack frame, I restore only EBP, EIP and ESP.</div=
><div><br></div><div>The code is here:</div><div><a href=3D"https://github.=
com/fdoray/libunwind/tree/minimal_regs" target=3D"_blank">https://github.co=
m/fdoray/libunwind/tree/minimal_regs</a><br></div><div>Warning: This versio=
n of the library is no longer signal-safe and has undefined behavior if mor=
e registers than EBP/EIP/ESP are required to unwind a stack frame (this nev=
er happened in the few tests that I made so far). These two limitations cou=
ld easily be overcome in the future.</div><div><br></div><div>Performance r=
esults, on x86_64:</div><div><br></div><div>unw_backtrace(), original libun=
wind</div><div>Mean time per backtrace: 6130 ns / 80% of samples between 14=
79 and 13837 ns<br></div><div><br></div><div>unw_backtrace(), modified libu=
nwind ***</div><div>Mean time per backtrace: 4255 ns / 80% of samples betwe=
en 1526 and 5252 ns.</div><div><br></div><div>unw_step()/unw_get_reg() [1],=
 original libuwndin</div><div>Mean time per backtrace: 43520 ns / 80% of sa=
mples between 13705 and 58782 ns.<br></div><div><br></div><div>unw_step()/u=
nw_get_reg(), modified libunwind</div><div>Mean time per backtrace: 5804 ns=
 / 80% of samples between 2844 and 11325 ns.</div><div><br></div><div>Franc=
ois</div><div><br></div><div>[1] As in the example presented here:=C2=A0<a =
href=3D"http://www.nongnu.org/libunwind/man/libunwind(3).html">http://www.n=
ongnu.org/libunwind/man/libunwind(3).html</a></div><div><br></div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Mar 16, 2015=
 at 8:35 PM, Brian Robbins <span dir=3D"ltr">&lt;<a href=3D"mailto:brianrob=
@microsoft.com" target=3D"_blank">brianrob@microsoft.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Hi All,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">This is great.=C2=A0 Thank you very m=
uch for the information.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">-Brian<u></u><u></u></span></p>
<p class=3D"MsoNormal"><a name=3D"14c2529008d33d03__MailEndCompose"><span s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#=
1f497d"><u></u>=C2=A0<u></u></span></a></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Francis Giraldeau [mailto:<a h=
ref=3D"mailto:francis.giraldeau@gmail.com" target=3D"_blank">francis.girald=
eau@gmail.com</a>]
<br>
<b>Sent:</b> Thursday, March 12, 2015 11:34 AM<br>
<b>To:</b> Mathieu Desnoyers<br>
<b>Cc:</b> Brian Robbins; <a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><span class=3D""><br>
<b>Subject:</b> Re: [lttng-dev] Userspace Tracing and Backtraces<u></u><u><=
/u></span></span></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<p class=3D"MsoNormal">2015-03-10 21:47 GMT-04:00 Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.de=
snoyers@efficios.com</a>&gt;:<u></u><u></u></p><div><div class=3D"h5">
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Francis: Did you define =
UNW_LOCAL_ONLY before including<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">the libunwind header in =
your benchmarks ? (see<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><a href=3D"http://www.no=
ngnu.org/libunwind/man/libunwind%283%29.html" target=3D"_blank">http://www.=
nongnu.org/libunwind/man/libunwind%283%29.html</a>)</span><span style=3D"fo=
nt-family:&quot;Arial&quot;,sans-serif;color:#222222">=C2=A0</span><span st=
yle=3D"color:black"><u></u><u></u></span></p>
</div>
</div>
</blockquote>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><u></u>=C2=A0<u></u></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">The seems to change perf=
ormance dramatically according to the documentation.<u></u><u></u></span></=
p>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Yes, this is the case. Time to unwind is higher at t=
he beginning (probably related to internal cache build), and also vary acco=
rding to call-stack depth.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Agreed on having the bac=
ktrace as a context. The main question left is<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">to figure out if we want=
 to call libunwind from within the traced application<u></u><u></u></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">execution context.<u></u=
><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><u></u>=C2=A0<u></u></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Unfortunately, libunwind=
 is not reentrant wrt signals. This is already<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">a good argument for not =
calling it from within a tracepoint. I wonder<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">if the authors of libunw=
ind would be open to make it signal-reentrant<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">in the future (not by di=
sabling signals, but rather by keeping a TLS<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">nesting counter, and ret=
urning an error if nested, for performance<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">considerations).<u></u><=
u></u></span></p>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">The functions unw_init_local() and unw_step() are si=
gnal safe [1]. The critical sections are protected using lock_acquire() tha=
t blocks all signals before taking the mutex, which prevent the recursion.<=
u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<div>
<p class=3D"MsoNormal">#define lock_acquire(l,m) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<u></u><u></=
u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0 SIGPROCMASK (SIG_SETMASK, &amp;unwi_full_mask=
, &amp;(m)); =C2=A0 =C2=A0 \<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0 mutex_lock (l); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">} while (0)<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">#define lock_release(l,m) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0 mutex_unlock (l); =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<u>=
</u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0 SIGPROCMASK (SIG_SETMASK, &amp;(m), NULL); =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">} while (0)<u></u><u></u></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">To understand the implications, I did a small progra=
m to study nested signals [2], where a signal is sent from within a signal,=
 or when segmentation fault occurs in a signal handler. Blocking a signal d=
iffers it when it is unblocked, while
 ignored signals are discarded. Blocked signals that can&#39;t be ignored h=
ave their default behaviour. It prevents a possible deadlock, let&#39;s say=
 if lock_acquire() was nesting with a custom SIGSEGV handler trying to get =
the same lock.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">So, let&#39;s say that instead of blocking signals, =
we have a per-thread mutex, that returns if try_lock() fails. It would be f=
aster, but from the user&#39;s point of view, the backtrace will be dropped=
 randomly. I would prefer it a bit slower,
 but reliable.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">In addition, could it be possible that TLS is not si=
gnal safe [3]?=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<blockquote style=3D"border:none;border-left:solid #1010ff 1.5pt;padding:0i=
n 0in 0in 4.0pt;margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div>
<div>
<div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">or using the perf capture mechanism t=
hat you describe below?</span><span style=3D"color:black"><u></u><u></u></s=
pan></p>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Perf is peeking at the u=
serspace from kernel space, it&#39;s another story. I guess that libunwind =
was not ported to the kernel because it is a large chunk
 of complicated code that performs a lot of I/O and computation, while copy=
ing a portion of the stack is really about KISS and low runtime overhead.<u=
></u><u></u></span></p>
</div>
</div>
</div>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">If using libunwind does =
not work out, another alternative I would consider<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">would be to copy the sta=
ck like perf is doing from the kernel. However,<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">in the spirit of compact=
ing trace data, I would be tempted to do the following<u></u><u></u></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">if we go down that route=
: check each pointer-aligned address for its content.<u></u><u></u></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">If it looks like a point=
er to an executable memory area (library, executable, or<u></u><u></u></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">JIT&#39;d code), we keep=
 it. Else, we zero this information (not needed). We can<u></u><u></u></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">then do a RLE-alike comp=
ression on the zeroes, so we can keep the layout<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">of the stack after uncom=
pression.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><u></u>=C2=A0<u></u></sp=
an></p>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Interesting! For comparison, here is a perf event [4=
] that shows there is a lot of room for reducing the event size. We should =
check if discarding other saved register values on the stack impacts restor=
ing the instruction pointer register.
 Doing the unwind offline also solves signal safety, should be fast and sca=
lable.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Francis<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">[1]=C2=A0<a href=3D"http://www.nongnu.org/libunwind/=
man/unw_init_local(3).html" target=3D"_blank">http://www.nongnu.org/libunwi=
nd/man/unw_init_local(3).html</a><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">[2]=C2=A0<a href=3D"https://gist.github.com/giraldea=
u/98f08161e83a7ab800ea" target=3D"_blank">https://gist.github.com/giraldeau=
/98f08161e83a7ab800ea</a><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">[3]=C2=A0<a href=3D"https://sourceware.org/glibc/wik=
i/TLSandSignals" target=3D"_blank">https://sourceware.org/glibc/wiki/TLSand=
Signals</a><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">[4]=C2=A0<a href=3D"http://pastebin.com/sByfXXAQ" ta=
rget=3D"_blank">http://pastebin.com/sByfXXAQ</a><u></u><u></u></p>
</div>
</div></div></div>
</div>
</div>
</div>
</div>

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>

--001a113debdade769a0511807117--


--===============0716984201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0716984201==--
