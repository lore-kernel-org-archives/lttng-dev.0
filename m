From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Man page: reference lttng-crash
 under --shm-path option
Date: Tue, 28 Apr 2015 10:18:11 -0400
Message-ID: <CA+jJMxsRVA3pnQns3uUof-iSKSLpsTWD69=cSya63=Qq0hv=nQ__45680.5816422731$1430230850$gmane$org@mail.gmail.com>
References: <1429731540-30119-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0699240250=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yn6L3-0001vb-N1
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 10:18:25 -0400
Received: by qcbii10 with SMTP id ii10so70850462qcb.2
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2015 07:18:12 -0700 (PDT)
In-Reply-To: <1429731540-30119-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0699240250==
Content-Type: multipart/alternative; boundary=001a114273ee58d7b30514c988b0

--001a114273ee58d7b30514c988b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

On Wed, Apr 22, 2015 at 3:39 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  doc/man/lttng.1 | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index e077b09..4b40a62 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -312,6 +312,8 @@ Path where shared memory holding buffers should be
> created. Useful
>  when used with PRAMFS or other persistent memory filesystems to extract
>  trace data in the event of a crash requiring a reboot.
>
> +See the \fBlttng-crash(1)\fP utility for more information on crash
> recovery.
> +
>  .TP
>  .BR "\-U, \-\-set-url=3DURL"
>  Set URL for the consumer output destination. It is persistent for the
> @@ -1116,6 +1118,7 @@ found.
>  .BR lttng-ust(3),
>  .BR lttng-sessiond(8),
>  .BR lttng-relayd(8),
> +.BR lttng-crash(1),
>
>  .SH "BUGS"
>
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a114273ee58d7b30514c988b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Wed, Apr 22, 2015 at 3:39 PM, Jonathan Rajotte <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" t=
arget=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Signed-off-by: Jonathan Rajotte &lt;<a h=
ref=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien=
@efficios.com</a>&gt;<br>
---<br>
=C2=A0doc/man/lttng.1 | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/doc/man/lttng.1 b/doc/man/lttng.1<br>
index e077b09..4b40a62 100644<br>
--- a/doc/man/lttng.1<br>
+++ b/doc/man/lttng.1<br>
@@ -312,6 +312,8 @@ Path where shared memory holding buffers should be crea=
ted. Useful<br>
=C2=A0when used with PRAMFS or other persistent memory filesystems to extra=
ct<br>
=C2=A0trace data in the event of a crash requiring a reboot.<br>
<br>
+See the \fBlttng-crash(1)\fP utility for more information on crash recover=
y.<br>
+<br>
=C2=A0.TP<br>
=C2=A0.BR &quot;\-U, \-\-set-url=3DURL&quot;<br>
=C2=A0Set URL for the consumer output destination. It is persistent for the=
<br>
@@ -1116,6 +1118,7 @@ found.<br>
=C2=A0.BR lttng-ust(3),<br>
=C2=A0.BR lttng-sessiond(8),<br>
=C2=A0.BR lttng-relayd(8),<br>
+.BR lttng-crash(1),<br>
<br>
=C2=A0.SH &quot;BUGS&quot;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a114273ee58d7b30514c988b0--


--===============0699240250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0699240250==--
