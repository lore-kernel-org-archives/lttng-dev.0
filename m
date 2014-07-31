From: Dmitri Shubin <sbn@tbricks.com>
Subject: Re: Enable UST probes only in specific process
Date: Thu, 31 Jul 2014 21:29:23 +0400
Message-ID: <CADmgc-taOgBY+nsOX7bNuMtbgyi5Uw+9Tcy4Y64O5nedZR51UQ__32785.0180482075$1406827838$gmane$org@mail.gmail.com>
References: <CADmgc-ueSkK_XZPwtjsm_6dvSDCqi1GLfCyH7SNhVw1n-7WppQ@mail.gmail.com>
 <CA+jJMxva_iZRJMzLkMTJ5=WXd1p4-WJNEQM95u2w8sdP0927hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904849185=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sbn@tbricks.com>) id 1XCuAT-0004vU-Bn
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 13:29:34 -0400
Received: by mail-ie0-f179.google.com with SMTP id rl12so4180089iec.38
 for <lttng-dev@lists.lttng.org>; Thu, 31 Jul 2014 10:29:24 -0700 (PDT)
In-Reply-To: <CA+jJMxva_iZRJMzLkMTJ5=WXd1p4-WJNEQM95u2w8sdP0927hw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1904849185==
Content-Type: multipart/alternative; boundary=089e0149bfa620469c04ff809de9

--089e0149bfa620469c04ff809de9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=A9r=C3=A9mie,


On Wed, Jul 30, 2014 at 10:31 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Wed, Jul 30, 2014 at 9:58 AM, Dmitri Shubin <sbn@tbricks.com> wrote:
> > AFAIU
> > lttng enable-event -u prov:probe --filter '$ctx.vpid=3D=3D12345'
> > enables probe for all processes and then drops unmatched.
> >
>
> Correct. The event won't be traced.
>

I.e. it won't be written to trace buffer/file, ok.


> The arguments won't be evaluated if the event is not enabled. However,
> when an event is enabled, the arguments are evaluated regardless of
> the result of the filter's expression evaluation since it could be
> based on the event's content.
>
> Let me know if that's not what you meant.
>

Yes, exactly.
I pass stack trace as an argument to the tracepoint.
So it's computed just to be dropped...


> > The only way I can do it now is playing with LTTNG_HOME variable settin=
g
> it
> > to different paths for each process.
>
> I'm not sure I understand what you mean here. Care to elaborate?
>

$ cat a.c
#include <stdlib.h>
#include <unistd.h>
#include <lttng/tracef.h>

int main()
{
    for (;;) {
        tracef("hello", (abort(), 1));
        sleep(1);
    }

    return 0;
}
$ gcc a.c -llttng-ust
$ mkdir /tmp/lttng-home-1 /tmp/lttng-home-2
$ LTTNG_HOME=3D/tmp/lttng-home-1 ./a.out &
[1] 13029
$ LTTNG_HOME=3D/tmp/lttng-home-2 ./a.out &
[2] 13032
$ export LTTNG_HOME=3D/tmp/lttng-home-1
$ lttng create
Spawning a session daemon
Session auto-20140731-211730 created.
Traces will be written in
/tmp/lttng-home-1/lttng-traces/auto-20140731-211730
$ lttng enable-event -u lttng_ust_tracef:event
UST event lttng_ust_tracef:event created in channel channel0
$ lttng start
Tracing started for session auto-20140731-211730
$
[1]-  Aborted                 (core dumped) LTTNG_HOME=3D/tmp/lttng-home-1
./a.out

I.e. here I have separate session per each process I want to trace.
It would be easier if I can have channel per process, like e.g.
$ lttng enable-channel -p 12345

For instance in dtrace I can explicitly specify process I want to trace by
appending its PID to probe name.

Regards!

--089e0149bfa620469c04ff809de9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0J=C3=A9r=C3=A9mie,<br><div class=3D"gmail_extra"><=
br><br><div class=3D"gmail_quote">On Wed, Jul 30, 2014 at 10:31 PM, J=C3=A9=
r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarn=
eau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;<=
/span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">On Wed, Jul 30, 2014 at 9:58 AM, Dmitri Shubin &lt;<a href=
=3D"mailto:sbn@tbricks.com" target=3D"_blank">sbn@tbricks.com</a>&gt; wrote=
:<br>


&gt; AFAIU<br>
&gt; lttng enable-event -u prov:probe --filter &#39;$ctx.vpid=3D=3D12345&#3=
9;<br>
&gt; enables probe for all processes and then drops unmatched.<br>
&gt;<br>
<br>
Correct. The event won&#39;t be traced.<br></blockquote><div><br></div><div=
>I.e. it won&#39;t be written to trace buffer/file, ok.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:soli=
d;padding-left:1ex">

The arguments won&#39;t be evaluated if the event is not enabled. However,<=
br>
when an event is enabled, the arguments are evaluated regardless of<br>
the result of the filter&#39;s expression evaluation since it could be<br>
based on the event&#39;s content.<br>
<br>
Let me know if that&#39;s not what you meant.<br></blockquote><div><br></di=
v><div>Yes, exactly.</div><div>I pass stack trace as an argument to the tra=
cepoint.</div><div>So it&#39;s computed just to be dropped...</div>
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">&gt; The only way I can do it now is play=
ing with LTTNG_HOME variable setting it<br>



&gt; to different paths for each process.<br>
<br>
I&#39;m not sure I understand what you mean here. Care to elaborate?<br></b=
lockquote><div><br></div><div><div>$ cat a.c=C2=A0</div><div>#include &lt;s=
tdlib.h&gt;</div><div>#include &lt;unistd.h&gt;</div><div>#include &lt;lttn=
g/tracef.h&gt;</div>

<div><br></div><div>int main()</div><div>{</div><div>=C2=A0 =C2=A0 for (;;)=
 {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tracef(&quot;hello&quot;, (abort()=
, 1));</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(1);</div><div>=C2=A0 =C2=
=A0 }</div><div><br></div><div>=C2=A0 =C2=A0 return 0;</div><div>
}</div>
<div>$ gcc a.c -llttng-ust</div><div>$ mkdir /tmp/lttng-home-1 /tmp/lttng-h=
ome-2<br></div></div><div><div>$ LTTNG_HOME=3D/tmp/lttng-home-1 ./a.out &am=
p;</div><div>[1] 13029</div><div>$ LTTNG_HOME=3D/tmp/lttng-home-2 ./a.out &=
amp;</div>

<div>[2] 13032</div></div><div><div>$ export LTTNG_HOME=3D/tmp/lttng-home-1=
</div><div>$ lttng create</div><div>Spawning a session daemon</div><div>Ses=
sion auto-20140731-211730 created.</div><div>Traces will be written in /tmp=
/lttng-home-1/lttng-traces/auto-20140731-211730</div>

<div>$ lttng enable-event -u lttng_ust_tracef:event<br></div><div>UST event=
 lttng_ust_tracef:event created in channel channel0</div><div>$ lttng start=
</div><div>Tracing started for session auto-20140731-211730</div><div>
$=C2=A0</div>
<div>[1]- =C2=A0Aborted =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (core dumped) LTTNG_HOME=3D/tmp/lttng-home-1 ./a.out</div></div><div=
><br></div><div>I.e. here I have separate session per each process I want t=
o trace.</div><div>It would be easier if I can have channel per process, li=
ke e.g.</div>

<div>$ lttng enable-channel -p 12345<br></div><div><br></div><div>For insta=
nce in dtrace I can explicitly specify process I want to trace by appending=
 its PID to probe name.</div><div><br></div><div>Regards!</div>
</div></div></div>

--089e0149bfa620469c04ff809de9--


--===============1904849185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1904849185==--
