From: Dmitri Shubin <sbn@tbricks.com>
Subject: Re: Enable UST probes only in specific process
Date: Thu, 31 Jul 2014 21:03:17 +0400
Message-ID: <CADmgc-v4+vd9UnHZirc-3VfGMfyi0nOAgZ6vepCXUAru8=SUHQ__20678.4266433262$1406826272$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD3CCB3AF5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0993657244=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sbn@tbricks.com>) id 1XCtlD-0004lq-LM
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 13:03:29 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so4103252ieb.4
 for <lttng-dev@lists.lttng.org>; Thu, 31 Jul 2014 10:03:17 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3CCB3AF5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0993657244==
Content-Type: multipart/alternative; boundary=089e0122a7fcbfcf1604ff803fbd

--089e0122a7fcbfcf1604ff803fbd
Content-Type: text/plain; charset=UTF-8

Hi Daniel,


On Wed, Jul 30, 2014 at 8:36 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>
>    I do believe that the filter drops the event before it starts resolving
> its arguments, so filtering should be enough.  Someone more familiar with
> the internals of LTTng should set us straight either way.
>


Simple demonstration using tracef():

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
$ ./a.out &
[1] 12820
$ ./a.out &
[2] 12823
$ lttng create
Session auto-20140731-205604 created.
Traces will be written in /home/sbn/lttng-traces/auto-20140731-205604
$ lttng add-context -u -t vpid
UST context vpid added to all channels
$ lttng enable-event -u lttng_ust_tracef:event -f '$ctx.vpid==12820'
Event lttng_ust_tracef:event: Filter '$ctx.vpid==12820' successfully set
$ lttng start
Tracing started for session auto-20140731-205604
$
[1]-  Aborted                 (core dumped) ./a.out
[2]+  Aborted                 (core dumped) ./a.out

So I specify filter on PID, but probe fired in both processes.
That's not what I want.

Regards!

--089e0122a7fcbfcf1604ff803fbd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<br><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Wed, Jul 30, 2014 at 8:36 PM, Thibault, Daniel <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D=
"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><br>
=C2=A0 =C2=A0I do believe that the filter drops the event before it starts =
resolving its arguments, so filtering should be enough. =C2=A0Someone more =
familiar with the internals of LTTng should set us straight either way.<br>=
</blockquote>

<div><br></div><div><br></div><div>Simple demonstration using tracef():</di=
v><div><br></div><div><div>$ cat a.c=C2=A0</div><div>#include &lt;stdlib.h&=
gt;</div><div>#include &lt;unistd.h&gt;</div><div>#include &lt;lttng/tracef=
.h&gt;</div>

<div><br></div><div>int main()</div><div>{</div><div>=C2=A0 =C2=A0 for (;;)=
 {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tracef(&quot;hello&quot;, (abort()=
, 1));</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(1);</div><div>=C2=A0 =C2=
=A0 }</div><div><br></div><div>=C2=A0 =C2=A0 return 0;</div><div>
}</div>
</div><div>$ gcc a.c -llttng-ust<br></div><div><div>$ ./a.out &amp;</div><d=
iv>[1] 12820</div><div>$ ./a.out &amp;<br></div><div>[2] 12823</div></div><=
div><div>$ lttng create</div><div>Session auto-20140731-205604 created.</di=
v>

<div>Traces will be written in /home/sbn/lttng-traces/auto-20140731-205604<=
/div><div>$ lttng add-context -u -t vpid<br></div><div>UST context vpid add=
ed to all channels</div><div>$ lttng enable-event -u lttng_ust_tracef:event=
 -f &#39;$ctx.vpid=3D=3D12820&#39;<br>

</div><div>Event lttng_ust_tracef:event: Filter &#39;$ctx.vpid=3D=3D12820&#=
39; successfully set</div><div>$ lttng start<br></div><div>Tracing started =
for session auto-20140731-205604</div><div>$=C2=A0<br></div><div>[1]- =C2=
=A0Aborted =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (core du=
mped) ./a.out</div>

<div>[2]+ =C2=A0Aborted =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (core dumped) ./a.out</div></div><div><br></div><div>So I specify fi=
lter on PID, but probe fired in both processes.</div><div>That&#39;s not wh=
at I want.</div><div><br></div><div>Regards!</div>
</div></div></div>

--089e0122a7fcbfcf1604ff803fbd--


--===============0993657244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0993657244==--
