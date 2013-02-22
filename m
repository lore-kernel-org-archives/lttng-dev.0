From: Patrick Baggett <baggett.patrick@gmail.com>
Subject: Re: liburcu sparc support, build failure on buildd
Date: Fri, 22 Feb 2013 14:42:31 -0600
Message-ID: <CAEk2St=563zuyo3qvnPTv7qedi66nT4hQjckJY+9dvGt9fx6YA@mail.gmail.com>
References: <20130222141551.GB22156@Krystal>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf3074d22ceea44c04d6563aa5
Return-path: <bounce-debian-sparc=debian-sparc=m.gmane.org@lists.debian.org>
In-Reply-To: <20130222141551.GB22156@Krystal>
Resent-Message-ID: <3D6H5gRLUbH.A.GTB.Oh9JRB@bendel>
List-URL: <http://lists.debian.org/debian-sparc/>
List-Post: <mailto:debian-sparc@lists.debian.org>
List-Help: <mailto:debian-sparc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-sparc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-sparc-request@lists.debian.org?subject=unsubscribe>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: sparc@buildd.debian.org, debian-sparc@lists.debian.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--20cf3074d22ceea44c04d6563aa5
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 22, 2013 at 8:15 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,
>
> I notice the following build failure here
>
> https://buildd.debian.org/status/package.php?p=liburcu
>
> Tail of log for liburcu on sparc:
>
> urcu/static/wfqueue.h:84:2: warning: implicit declaration of function
> 'CMM_STORE_SHARED' [-Wimplicit-function-declaration]
> urcu/static/wfqueue.h: In function '___cds_wfq_node_sync_next':
> urcu/static/wfqueue.h:99:2: warning: implicit declaration of function
> 'CMM_LOAD_SHARED' [-Wimplicit-function-declaration]
> urcu/static/wfqueue.h:99:15: warning: assignment makes pointer from
> integer without a cast [enabled by default]
> urcu/static/wfqueue.h:104:4: warning: implicit declaration of function
> 'caa_cpu_relax' [-Wimplicit-function-declaration]
> urcu/static/wfqueue.h: In function '___cds_wfq_dequeue_blocking':
> urcu/static/wfqueue.h:126:55: warning: comparison between pointer and
> integer [enabled by default]
> make[3]: *** [wfqueue.lo] Error 1
> make[3]: Leaving directory
> `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/liburcu-0.7.6'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory
> `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/liburcu-0.7.6'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/liburcu-0.7.6'
> dh_auto_build: make -j1 returned exit code 2
> make: *** [build-arch] Error 2
>
> One main question I have: what sparc architectures are supported by
> Debian's "sparc" architecture ? Userspace RCU only supports Sparcv9 and
> onward, because it requires some atomic instructions.
>
>
Debian definitely only supports[1] SPARCv9 compatible CPUs (sun4u, sun4v).
I've heard that Linux on 32-bit SPARC (i.e. sparc <= v8) is shoddy now, but
I certainly haven't tried it.

[1] http://www.debian.org/ports/sparc/

As documented in the urcu README file, building a package that includes
> sparcv9 isntructions for 32-bit sparc can be done with:
>
> CFLAGS="-m32 -Wa,-Av9a -g -O2" ./configure
>

"v9a" includes VIS instruction set, which is an extension of SPARCv9. I
think only some early Fujitsu SPARC CPUs (pre 2000) are missing it -- the
original UltraSPARC from Sun does include it. Probably safe to turn on, but
technically extends requirements to use the program.


>
> But if Debian sparc needs to support pre-v9 sparcs, then I guess it
> would not be appropriate to use v9 instructions for urcu sparc build.
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> --
> To UNSUBSCRIBE, email to debian-sparc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact
> listmaster@lists.debian.org
> Archive: http://lists.debian.org/20130222141551.GB22156@Krystal
>
>

--20cf3074d22ceea44c04d6563aa5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Feb 22, 2013 at 8:15 AM, Mathieu=
 Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@effici=
os.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
I notice the following build failure here<br>
<br>
<a href=3D"https://buildd.debian.org/status/package.php?p=3Dliburcu" target=
=3D"_blank">https://buildd.debian.org/status/package.php?p=3Dliburcu</a><br=
>
<br>
Tail of log for liburcu on sparc:<br>
<br>
urcu/static/wfqueue.h:84:2: warning: implicit declaration of function &#39;=
CMM_STORE_SHARED&#39; [-Wimplicit-function-declaration]<br>
urcu/static/wfqueue.h: In function &#39;___cds_wfq_node_sync_next&#39;:<br>
urcu/static/wfqueue.h:99:2: warning: implicit declaration of function &#39;=
CMM_LOAD_SHARED&#39; [-Wimplicit-function-declaration]<br>
urcu/static/wfqueue.h:99:15: warning: assignment makes pointer from integer=
 without a cast [enabled by default]<br>
urcu/static/wfqueue.h:104:4: warning: implicit declaration of function &#39=
;caa_cpu_relax&#39; [-Wimplicit-function-declaration]<br>
urcu/static/wfqueue.h: In function &#39;___cds_wfq_dequeue_blocking&#39;:<b=
r>
urcu/static/wfqueue.h:126:55: warning: comparison between pointer and integ=
er [enabled by default]<br>
make[3]: *** [wfqueue.lo] Error 1<br>
make[3]: Leaving directory `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/libu=
rcu-0.7.6&#39;<br>
make[2]: *** [all-recursive] Error 1<br>
make[2]: Leaving directory `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/libu=
rcu-0.7.6&#39;<br>
make[1]: *** [all] Error 2<br>
make[1]: Leaving directory `/build/buildd-liburcu_0.7.6-1-sparc-GySyug/libu=
rcu-0.7.6&#39;<br>
dh_auto_build: make -j1 returned exit code 2<br>
make: *** [build-arch] Error 2<br>
<br>
One main question I have: what sparc architectures are supported by<br>
Debian&#39;s &quot;sparc&quot; architecture ? Userspace RCU only supports S=
parcv9 and<br>
onward, because it requires some atomic instructions.<br>
<br></blockquote><div><br></div><div>Debian definitely only supports[1] SPA=
RCv9=A0compatible=A0CPUs (sun4u, sun4v). I&#39;ve heard that Linux on 32-bi=
t SPARC (i.e. sparc &lt;=3D v8) is shoddy now, but I certainly haven&#39;t =
tried it.</div>
<div>=A0</div><div>[1] <a href=3D"http://www.debian.org/ports/sparc/">http:=
//www.debian.org/ports/sparc/</a></div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">

As documented in the urcu README file, building a package that includes<br>
sparcv9 isntructions for 32-bit sparc can be done with:<br>
<br>
CFLAGS=3D&quot;-m32 -Wa,-Av9a -g -O2&quot; ./configure<br></blockquote><div=
><br></div><div>&quot;v9a&quot; includes VIS instruction set, which is an e=
xtension of SPARCv9. I think only some early Fujitsu SPARC CPUs (pre 2000) =
are missing it -- the original UltraSPARC from Sun does include it. Probabl=
y safe to turn on, but technically extends requirements to use the program.=
</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
But if Debian sparc needs to support pre-v9 sparcs, then I guess it<br>
would not be appropriate to use v9 instructions for urcu sparc build.<br>
<br>
Thoughts ?<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
<br>
--<br>
To UNSUBSCRIBE, email to <a href=3D"mailto:debian-sparc-REQUEST@lists.debia=
n.org">debian-sparc-REQUEST@lists.debian.org</a><br>
with a subject of &quot;unsubscribe&quot;. Trouble? Contact <a href=3D"mail=
to:listmaster@lists.debian.org">listmaster@lists.debian.org</a><br>
Archive: <a href=3D"http://lists.debian.org/20130222141551.GB22156@Krystal"=
 target=3D"_blank">http://lists.debian.org/20130222141551.GB22156@Krystal</=
a><br>
<br>
</font></span></blockquote></div><br>

--20cf3074d22ceea44c04d6563aa5--
