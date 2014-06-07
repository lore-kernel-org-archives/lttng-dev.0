From: Antoine Busque <antoine.busque@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: blktrace instrumentation
 for backported branches
Date: Sat, 7 Jun 2014 12:25:57 -0400
Message-ID: <CA+MZcXtR_ADXPkgDCTu9AavGi13CpEPvWfBoh5JZBjEoMnOjkg__28648.9435857677$1402158419$gmane$org@mail.gmail.com>
References: <CA+MZcXvcHsLm3y5hyTSU718OfPF5cP2A_+XOoesOJ6898iK-mQ@mail.gmail.com>
 <2019538324.28072.1402154174077.JavaMail.zimbra@efficios.com>
 <598170477.28122.1402154233383.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0326107868=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nintendopro@gmail.com>) id 1WtJRT-00023Q-4r
 for lttng-dev@lists.lttng.org; Sat, 07 Jun 2014 12:26:05 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so3650723pdj.12
 for <lttng-dev@lists.lttng.org>; Sat, 07 Jun 2014 09:25:57 -0700 (PDT)
In-Reply-To: <598170477.28122.1402154233383.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0326107868==
Content-Type: multipart/alternative; boundary=001a1136338acc4e7804fb416eb2

--001a1136338acc4e7804fb416eb2
Content-Type: text/plain; charset=UTF-8

On Sat, Jun 7, 2014 at 11:17 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
>
> ------------------------------
>
> *From: *"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> *To: *"Antoine Busque" <antoine.busque@efficios.com>
> *Cc: *lttng-dev@lists.lttng.org
> *Sent: *Saturday, June 7, 2014 11:16:14 AM
> *Subject: *Re: [lttng-dev] [PATCH lttng-modules] Fix: blktrace
> instrumentation for        backported branches
>
>
>
> ------------------------------
>
> *From: *"Antoine Busque" <antoine.busque@efficios.com>
> *To: *lttng-dev@lists.lttng.org
> *Sent: *Friday, June 6, 2014 6:00:59 PM
> *Subject: *[lttng-dev] [PATCH lttng-modules] Fix: blktrace
> instrumentation for        backported branches
>
> The following commit from kernel 3.15 changing the API of a block layer
> tracepoint has been backported to multiple branches:
>
> commit af5040da01ef980670b3741b3e10733ee3e33566
> Author: Roman Pen <r.peniaev@gmail.com>
> Date:   Tue Mar 4 23:13:10 2014 +0900
>
>     blktrace: fix accounting of partially completed requests
>
> This patch fixes the resulting build failure by adding the proper
> version checks. The versions and corresponding commit SHA-1 hashes are
> as follow:
>
>    3.2.58
>        commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6
>
>    3.4.91
>        commit 14eee5bd065d6aac0acbdc6092a25ba68c55b9c8
>
>    3.10.41
>        commit e9d933941569c107e0083c3c115467c699a57db2
>
>    3.12.21
>        commit 5104b40a981d26212ced149fbd43ad0b6b72910b
>
>    3.14.15
>        commit 0a8eda9c00ef37e8b40de77f2b0714317191bcf2
>
> Signed-off-by: Antoine Busque <antoine.busque@efficios.com>
> ---
>  instrumentation/events/lttng-module/block.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/instrumentation/events/lttng-module/block.h
> b/instrumentation/events/lttng-module/block.h
> index 4f3460e..5684153 100644
> --- a/instrumentation/events/lttng-module/block.h
> +++ b/instrumentation/events/lttng-module/block.h
> @@ -221,8 +221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
>      TP_ARGS(q, rq)
>  )
>
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)    \
> -    || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)    \
> +    || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0)        \
> +    || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)        \
> +    || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)        \
> +    || LTTNG_KERNEL_RANGE(3,12,21, 3,13,0))
>
> It looks like your mail client turns tabs into spaces. Can you fix and
> re-send ?
>
> git-send-email is very likely what you'll want to use.
>
> Thanks,
>
> Mathieu
>
>
Alright, I'm resending right now through send-email. The commit itself
definitely contains tabs and not spaces, so hopefully this should work.

Thanks,
Antoine.

>
>
> thanks,
>
> Mathieu
>
>
>
>
>  /**
>   * block_rq_complete - block IO operation completed by device driver
> --
> 2.0.0
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1136338acc4e7804fb416eb2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Sat, Jun 7, 2014 at 11:17 AM, Mathieu Desnoyers <span dir=3D"ltr=
">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">m=
athieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-f=
amily:times new roman,new york,times,serif;font-size:12pt;color:rgb(0,0,0)"=
><div>
<br></div><div><br></div><hr><blockquote style=3D"border-left:2px solid rgb=
(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt">
<b>From: </b>&quot;Mathieu Desnoyers&quot; &lt;<a href=3D"mailto:mathieu.de=
snoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&=
gt;<br><b>To: </b>&quot;Antoine Busque&quot; &lt;<a href=3D"mailto:antoine.=
busque@efficios.com" target=3D"_blank">antoine.busque@efficios.com</a>&gt;<=
br>
<b>Cc: </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br><b>Sent: </b>Saturday, June 7, 2014 11:16:1=
4 AM<br><b>Subject: </b>Re: [lttng-dev] [PATCH lttng-modules] Fix: blktrace=
 instrumentation for=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backpor=
ted branches<div>
<div class=3D"h5"><br><div><br></div><div style=3D"font-family:times new ro=
man,new york,times,serif;font-size:12pt;color:rgb(0,0,0)"><div><br></div><h=
r><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px=
;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">
<b>From: </b>&quot;Antoine Busque&quot; &lt;<a href=3D"mailto:antoine.busqu=
e@efficios.com" target=3D"_blank">antoine.busque@efficios.com</a>&gt;<br><b=
>To: </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
<b>Sent: </b>Friday, June 6, 2014 6:00:59 PM<br><b>Subject: </b>[lttng-dev]=
 [PATCH lttng-modules] Fix: blktrace instrumentation for=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backported branches<br><div><br></div><div di=
r=3D"ltr">The following commit from kernel 3.15 changing the API of a block=
 layer<br>
tracepoint has been backported to multiple branches:<br><div><br></div>comm=
it af5040da01ef980670b3741b3e10733ee3e33566<br>Author: Roman Pen &lt;<a hre=
f=3D"mailto:r.peniaev@gmail.com" target=3D"_blank">r.peniaev@gmail.com</a>&=
gt;<br>

Date:=C2=A0=C2=A0 Tue Mar 4 23:13:10 2014 +0900<br><div><br></div>=C2=A0=C2=
=A0=C2=A0 blktrace: fix accounting of partially completed requests<br><div>=
<br></div>This patch fixes the resulting build failure by adding the proper=
<br>version checks. The versions and corresponding commit SHA-1 hashes are<=
br>

as follow:<br><div><br></div>=C2=A0=C2=A0 3.2.58<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6<br><div><br=
></div>=C2=A0=C2=A0 3.4.91<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit 1=
4eee5bd065d6aac0acbdc6092a25ba68c55b9c8<br><div><br></div>=C2=A0=C2=A0 3.10=
.41<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit e9d933941569c107e0083c3c=
115467c699a57db2<br>
<div><br></div>=C2=A0=C2=A0 3.12.21<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 commit 5104b40a981d26212ced149fbd43ad0b6b72910b<br><div><br></div>=C2=A0=
=C2=A0 3.14.15<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit 0a8eda9c00ef3=
7e8b40de77f2b0714317191bcf2<br><div><br></div>Signed-off-by: Antoine Busque=
 &lt;<a href=3D"mailto:antoine.busque@efficios.com" target=3D"_blank">antoi=
ne.busque@efficios.com</a>&gt;<br>

---<br>=C2=A0instrumentation/events/lttng-module/block.h | 7 +++++--<br>=C2=
=A01 file changed, 5 insertions(+), 2 deletions(-)<br><div><br></div>diff -=
-git a/instrumentation/events/lttng-module/block.h b/instrumentation/events=
/lttng-module/block.h<br>

index 4f3460e..5684153 100644<br>--- a/instrumentation/events/lttng-module/=
block.h<br>+++ b/instrumentation/events/lttng-module/block.h<br>@@ -221,8 +=
221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 TP_ARGS(q, rq)<br>

=C2=A0)<br><div><br></div>-#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3=
,15,0)=C2=A0=C2=A0=C2=A0 \<br>-=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,2=
,58, 3,3,0))<br>+#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,14,5)=C2=
=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,2,58, 3,3,=
0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \<br>

+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,10,41, =
3,11,0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LT=
TNG_KERNEL_RANGE(3,12,21, 3,13,0))</div></blockquote><div>It looks like you=
r mail client turns tabs into spaces. Can you fix and re-send ?</div>
</div></div></div></blockquote><div>git-send-email is very likely what you&=
#39;ll want to use.<br></div><div><br></div><div>Thanks,<br></div><div><br>=
</div><div>Mathieu<br></div><div class=3D""><div><br></div></div></div></di=
v>
</blockquote><div><br></div><div>Alright, I&#39;m resending right now throu=
gh send-email. The commit itself<br>definitely contains tabs and not spaces=
, so hopefully this should work.<br></div><div><br></div><div>Thanks,<br>
</div><div>Antoine.<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt;color:rgb(0,0,0)">
<div class=3D""><div></div><blockquote style=3D"border-left:2px solid rgb(1=
6,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt">
<div style=3D"font-family:times new roman,new york,times,serif;font-size:12=
pt;color:rgb(0,0,0)"><div><br></div><div><br></div><div>thanks,<br></div><d=
iv><br></div><div>Mathieu<br></div><div><br></div><div><br></div><blockquot=
e style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-lef=
t:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">
<div dir=3D"ltr"><br><div><br></div>=C2=A0/**<br>=C2=A0 * block_rq_complete=
 - block IO operation completed by device driver<br>
-- <br>2.0.0<br><div><br></div><br></div><br>______________________________=
_________________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@=
lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=
=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_b=
lank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
</blockquote><div><br><div><br></div></div><div><br></div><div>-- <br></div=
><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.=
com" target=3D"_blank">http://www.efficios.com</a><br></div></div></blockqu=
ote>
<div><br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"><=
/span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.=
com" target=3D"_blank">http://www.efficios.com</a><span name=3D"x"></span><=
br></div>
</div></div></div></blockquote></div><br></div></div>

--001a1136338acc4e7804fb416eb2--


--===============0326107868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0326107868==--
