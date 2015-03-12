From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Userspace Tracing and Backtraces
Date: Thu, 12 Mar 2015 14:34:23 -0400
Message-ID: <CAC6yHM4QSUhv4mw0HzhENDY32BrmckQwvX==gAvw0ej3mwBGAg__1815.33501386202$1426185362$gmane$org@mail.gmail.com>
References: <BY2SR01MB595A5A400E2211CC7567298C81F0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM6VLGQgjF4tS1dLg749rEZ8DKMMda=DsrihLCoQ9sHPdw@mail.gmail.com>
 <BY2SR01MB5952376CA9DE7B8211078C8C81C0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM4AXG5btHdaoHjuCwzCDvPn9AORyh8gvo-VOua7ndWF2w@mail.gmail.com>
 <CH1SR01MB5996051E5E9E51406F6502DC81B0@CH1SR01MB599.namsdf01.sdf.exchangelabs.com>
 <353474327.273521.1426038464379.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1310558239=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YW7wC-0004hl-Mt
 for lttng-dev@lists.lttng.org; Thu, 12 Mar 2015 14:34:39 -0400
Received: by qcvp6 with SMTP id p6so20881588qcv.1
 for <lttng-dev@lists.lttng.org>; Thu, 12 Mar 2015 11:34:23 -0700 (PDT)
In-Reply-To: <353474327.273521.1426038464379.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1310558239==
Content-Type: multipart/alternative; boundary=001a113511dc006f5605111ba289

--001a113511dc006f5605111ba289
Content-Type: text/plain; charset=UTF-8

2015-03-10 21:47 GMT-04:00 Mathieu Desnoyers <mathieu.desnoyers@efficios.com
>:
>
> Francis: Did you define UNW_LOCAL_ONLY before including
> the libunwind header in your benchmarks ? (see
> http://www.nongnu.org/libunwind/man/libunwind%283%29.html)
>

> The seems to change performance dramatically according to the
> documentation.
>


Yes, this is the case. Time to unwind is higher at the beginning (probably
related to internal cache build), and also vary according to call-stack
depth.


> Agreed on having the backtrace as a context. The main question left is
> to figure out if we want to call libunwind from within the traced
> application
> execution context.
>
> Unfortunately, libunwind is not reentrant wrt signals. This is already
> a good argument for not calling it from within a tracepoint. I wonder
> if the authors of libunwind would be open to make it signal-reentrant
> in the future (not by disabling signals, but rather by keeping a TLS
> nesting counter, and returning an error if nested, for performance
> considerations).
>

The functions unw_init_local() and unw_step() are signal safe [1]. The
critical sections are protected using lock_acquire() that blocks all
signals before taking the mutex, which prevent the recursion.

#define lock_acquire(l,m)                               \
do {                                                    \
  SIGPROCMASK (SIG_SETMASK, &unwi_full_mask, &(m));     \
  mutex_lock (l);                                       \
} while (0)
#define lock_release(l,m)                       \
do {                                            \
  mutex_unlock (l);                             \
  SIGPROCMASK (SIG_SETMASK, &(m), NULL);        \
} while (0)

To understand the implications, I did a small program to study nested
signals [2], where a signal is sent from within a signal, or when
segmentation fault occurs in a signal handler. Blocking a signal differs it
when it is unblocked, while ignored signals are discarded. Blocked signals
that can't be ignored have their default behaviour. It prevents a possible
deadlock, let's say if lock_acquire() was nesting with a custom SIGSEGV
handler trying to get the same lock.

So, let's say that instead of blocking signals, we have a per-thread mutex,
that returns if try_lock() fails. It would be faster, but from the user's
point of view, the backtrace will be dropped randomly. I would prefer it a
bit slower, but reliable.

In addition, could it be possible that TLS is not signal safe [3]?

> or using the perf capture mechanism that you describe below?
>
> Perf is peeking at the userspace from kernel space, it's another story. I
> guess that libunwind was not ported to the kernel because it is a large
> chunk of complicated code that performs a lot of I/O and computation, while
> copying a portion of the stack is really about KISS and low runtime
> overhead.
>
> If using libunwind does not work out, another alternative I would consider
> would be to copy the stack like perf is doing from the kernel. However,
> in the spirit of compacting trace data, I would be tempted to do the
> following
> if we go down that route: check each pointer-aligned address for its
> content.
> If it looks like a pointer to an executable memory area (library,
> executable, or
> JIT'd code), we keep it. Else, we zero this information (not needed). We
> can
> then do a RLE-alike compression on the zeroes, so we can keep the layout
> of the stack after uncompression.
>
>
Interesting! For comparison, here is a perf event [4] that shows there is a
lot of room for reducing the event size. We should check if discarding
other saved register values on the stack impacts restoring the instruction
pointer register. Doing the unwind offline also solves signal safety,
should be fast and scalable.

Francis

[1] http://www.nongnu.org/libunwind/man/unw_init_local(3).html
[2] https://gist.github.com/giraldeau/98f08161e83a7ab800ea
[3] https://sourceware.org/glibc/wiki/TLSandSignals
[4] http://pastebin.com/sByfXXAQ

--001a113511dc006f5605111ba289
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2015=
-03-10 21:47 GMT-04:00 Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@e=
fficios.com</a>&gt;</span>:<blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div style=3D"font-family:&#39;=
times new roman&#39;,&#39;new york&#39;,times,serif;font-size:12pt;color:rg=
b(0,0,0)"><div>Francis: Did you define UNW_LOCAL_ONLY before including</div=
><div>the libunwind header in your benchmarks ? (see</div><div><a href=3D"h=
ttp://www.nongnu.org/libunwind/man/libunwind%283%29.html" target=3D"_blank"=
>http://www.nongnu.org/libunwind/man/libunwind%283%29.html</a>)<span style=
=3D"font-family:arial,sans-serif;font-size:small;color:rgb(34,34,34)">=C2=
=A0</span></div></div></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div style=3D"font-fam=
ily:&#39;times new roman&#39;,&#39;new york&#39;,times,serif;font-size:12pt=
;color:rgb(0,0,0)"><div></div><div><br></div><div>The seems to change perfo=
rmance dramatically according to the documentation.<br></div></div></blockq=
uote><div><br></div><div><br></div><div>Yes, this is the case. Time to unwi=
nd is higher at the beginning (probably related to internal cache build), a=
nd also vary according to call-stack depth.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex"><div style=3D"font-family:&#39;times new roman&#39;,&#39;new york&#=
39;,times,serif;font-size:12pt;color:rgb(0,0,0)"><div>Agreed on having the =
backtrace as a context. The main question left is<br></div><div>to figure o=
ut if we want to call libunwind from within the traced application<br></div=
><div>execution context.<br></div><div><br></div><div>Unfortunately, libunw=
ind is not reentrant wrt signals. This is already<br></div><div>a good argu=
ment for not calling it from within a tracepoint. I wonder<br></div><div>if=
 the authors of libunwind would be open to make it signal-reentrant<br></di=
v><div>in the future (not by disabling signals, but rather by keeping a TLS=
<br></div><div>nesting counter, and returning an error if nested, for perfo=
rmance</div><div>considerations).<br></div></div></blockquote><div><br></di=
v><div>The functions unw_init_local() and unw_step() are signal safe [1]. T=
he critical sections are protected using lock_acquire() that blocks all sig=
nals before taking the mutex, which prevent the recursion.</div><div><br></=
div><div><div>#define lock_acquire(l,m) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \</di=
v><div>do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\</div><div>=C2=A0 SIGPROCMASK=
 (SIG_SETMASK, &amp;unwi_full_mask, &amp;(m)); =C2=A0 =C2=A0 \</div><div>=
=C2=A0 mutex_lock (l); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \</div><div>} while (0)</div><div>#define lock_release(l,m) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \</di=
v><div>do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\</div><div>=C2=A0 mutex_unlock (l); =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \</div><div>=C2=A0 SIGPROCMASK (SIG_SETMASK, &amp;(m), NULL); =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\</div><div>} while (0)</div></div><div><br></div><div>=
To understand the implications, I did a small program to study nested signa=
ls [2], where a signal is sent from within a signal, or when segmentation f=
ault occurs in a signal handler. Blocking a signal differs it when it is un=
blocked, while ignored signals are discarded. Blocked signals that can&#39;=
t be ignored have their default behaviour. It prevents a possible deadlock,=
 let&#39;s say if lock_acquire() was nesting with a custom SIGSEGV handler =
trying to get the same lock.<br></div><div><br></div><div>So, let&#39;s say=
 that instead of blocking signals, we have a per-thread mutex, that returns=
 if try_lock() fails. It would be faster, but from the user&#39;s point of =
view, the backtrace will be dropped randomly. I would prefer it a bit slowe=
r, but reliable.</div><div><br></div><div>In addition, could it be possible=
 that TLS is not signal safe [3]?=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div style=3D=
"font-family:&#39;times new roman&#39;,&#39;new york&#39;,times,serif;font-=
size:12pt;color:rgb(0,0,0)"><span class=3D""><blockquote style=3D"border-le=
ft-width:2px;border-left-style:solid;border-left-color:rgb(16,16,255);margi=
n-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt"><div><div><div><div><blockquote style=3D"border-style:none none non=
e solid;border-left-color:rgb(204,204,204);border-left-width:1pt;padding:0i=
n 0in 0in 6pt;margin-left:4.8pt;margin-right:0in"><div><div><p class=3D"Mso=
Normal"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;color:=
rgb(31,73,125)">or using the perf capture mechanism that you describe below=
?</span></p></div></div></blockquote><div><p class=3D"MsoNormal">Perf is pe=
eking at the userspace from kernel space, it&#39;s another story. I guess t=
hat libunwind was not ported to the kernel because it is a large chunk of c=
omplicated code that performs a lot of I/O and computation, while copying a=
 portion
 of the stack is really about KISS and low runtime overhead.</p></div></div=
></div></div></div></blockquote></span><div>If using libunwind does not wor=
k out, another alternative I would consider<br></div><div>would be to copy =
the stack like perf is doing from the kernel. However,<br></div><div>in the=
 spirit of compacting trace data, I would be tempted to do the following<br=
></div><div>if we go down that route: check each pointer-aligned address fo=
r its content.<br></div><div>If it looks like a pointer to an executable me=
mory area (library, executable, or<br></div><div>JIT&#39;d code), we keep i=
t. Else, we zero this information (not needed). We can<br></div><div>then d=
o a RLE-alike compression on the zeroes, so we can keep the layout<br></div=
><div>of the stack after uncompression.<br></div><div><br></div></div></blo=
ckquote><div><br></div><div>Interesting! For comparison, here is a perf eve=
nt [4] that shows there is a lot of room for reducing the event size. We sh=
ould check if discarding other saved register values on the stack impacts r=
estoring the instruction pointer register. Doing the unwind offline also so=
lves signal safety, should be fast and scalable.</div><div><br></div><div>F=
rancis</div><div><br></div><div>[1]=C2=A0<a href=3D"http://www.nongnu.org/l=
ibunwind/man/unw_init_local(3).html">http://www.nongnu.org/libunwind/man/un=
w_init_local(3).html</a></div><div>[2]=C2=A0<a href=3D"https://gist.github.=
com/giraldeau/98f08161e83a7ab800ea">https://gist.github.com/giraldeau/98f08=
161e83a7ab800ea</a></div><div>[3]=C2=A0<a href=3D"https://sourceware.org/gl=
ibc/wiki/TLSandSignals">https://sourceware.org/glibc/wiki/TLSandSignals</a>=
</div><div>[4]=C2=A0<a href=3D"http://pastebin.com/sByfXXAQ">http://pastebi=
n.com/sByfXXAQ</a></div></div></div></div>

--001a113511dc006f5605111ba289--


--===============1310558239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1310558239==--
