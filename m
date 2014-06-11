From: Antoine Busque <antoine.busque@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: correct typo in kernel
 version number range
Date: Wed, 11 Jun 2014 10:43:11 -0400
Message-ID: <CA+MZcXvyRFtvFCeUi18JqB8ZcjcbvRz5t+XoVf9S-hancjhx9g__8740.8592612066$1402497866$gmane$org@mail.gmail.com>
References: <1402411964-4522-1-git-send-email-antoine.busque@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1612113365=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nintendopro@gmail.com>) id 1WujkD-0000Zx-MA
 for lttng-dev@lists.lttng.org; Wed, 11 Jun 2014 10:43:23 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so7348392pde.28
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jun 2014 07:43:12 -0700 (PDT)
In-Reply-To: <1402411964-4522-1-git-send-email-antoine.busque@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <antoine.busque@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1612113365==
Content-Type: multipart/alternative; boundary=047d7bea334eae421904fb907686

--047d7bea334eae421904fb907686
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 10, 2014 at 10:52 AM, Antoine Busque <
antoine.busque@efficios.com> wrote:

> A typo in an if statement verifying the range in which the current
> kernel's version is situated caused build failure for modules on 3.5.0
> specifically, by trying to use the new api for block_rq_complete which
> has not been backported from the 3.15 branch to the 3.5 branch.
> ---
>  instrumentation/events/lttng-module/block.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/instrumentation/events/lttng-module/block.h
> b/instrumentation/events/lttng-module/block.h
> index dbe6c6c..ad0a363 100644
> --- a/instrumentation/events/lttng-module/block.h
> +++ b/instrumentation/events/lttng-module/block.h
> @@ -224,7 +224,7 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)      \
>         || LTTNG_KERNEL_RANGE(3,12,21, 3,13,0)          \
>         || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)          \
> -       || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)            \
> +       || LTTNG_KERNEL_RANGE(3,4,91, 3,5,0)            \
>         || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
>
>  /**
> --
> 2.0.0
>

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


I just realised I forgot to sign off the previous patch,
so I'll resend now. Please excuse the multiple emails,
I'm still getting the hang of this workflow.

Regards,
Antoine.

--047d7bea334eae421904fb907686
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jun 10, 2014 at 10:52 AM, Antoine Busque <span dir=3D"ltr">&lt;<a href=
=3D"mailto:antoine.busque@efficios.com" target=3D"_blank">antoine.busque@ef=
ficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D""><div class=3D"h5">A typo in an if statemen=
t verifying the range in which the current<br>

kernel&#39;s version is situated caused build failure for modules on 3.5.0<=
br>
specifically, by trying to use the new api for block_rq_complete which<br>
has not been backported from the 3.15 branch to the 3.5 branch.<br>
---<br>
=C2=A0instrumentation/events/lttng-module/block.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/=
events/lttng-module/block.h<br>
index dbe6c6c..ad0a363 100644<br>
--- a/instrumentation/events/lttng-module/block.h<br>
+++ b/instrumentation/events/lttng-module/block.h<br>
@@ -224,7 +224,7 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,<br>
=C2=A0#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,14,5) =C2=A0 =C2=A0 =
=C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 || LTTNG_KERNEL_RANGE(3,12,21, 3,13,0) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
- =C2=A0 =C2=A0 =C2=A0 || LTTNG_KERNEL_RANGE(3,4,91, 3,5,1) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+ =C2=A0 =C2=A0 =C2=A0 || LTTNG_KERNEL_RANGE(3,4,91, 3,5,0) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))<br>
<br>
=C2=A0/**<br>
--<br>
2.0.0</div></div></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex"><div class=3D""><div class=
=3D"h5">

<br>
</div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
/blockquote><div><br></div>I just realised I forgot to sign off the previou=
s patch,<div>
so I&#39;ll resend now. Please excuse the multiple emails,</div><div>I&#39;=
m still getting the hang of this workflow.=C2=A0</div></div><br></div><div =
class=3D"gmail_extra">Regards,</div><div class=3D"gmail_extra">Antoine.</di=
v></div>

--047d7bea334eae421904fb907686--


--===============1612113365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1612113365==--
