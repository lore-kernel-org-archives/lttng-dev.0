From: Suraj Bagad <surajbagad@gmail.com>
Subject: Re:
	=?iso-8859-1?q?/home/admin/lttng-modules-2=2E3=2E0-rc?=
	=?iso-8859-1?q?1/lttng-events=2Ec=3A388=3A_error=3A_too_many_argum?=
	=?iso-8859-1?q?ents_to_function_=E2tracepoint=5Fprobe=5Fregister?=
	=?iso-8859-1?q?=E2?=
Date: Thu, 8 Aug 2013 18:05:47 +0530
Message-ID: <CAFa-mVUWH29L0V-OXD8UaMgdH96tcxqNd1fgxOT=YX4b7cnzGQ__40699.7848804623$1375965395$gmane$org@mail.gmail.com>
References: <CAFa-mVWYapQuAYkrvTLUBdGibRugYXKBi5+dgkNwqDCTj1yvrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2053165857=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <surajbagad@gmail.com>) id 1V7PRa-0007BB-3Z
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 08:35:54 -0400
Received: by mail-wi0-f175.google.com with SMTP id hq12so509452wib.14
	for <lttng-dev@lists.lttng.org>; Thu, 08 Aug 2013 05:35:48 -0700 (PDT)
In-Reply-To: <CAFa-mVWYapQuAYkrvTLUBdGibRugYXKBi5+dgkNwqDCTj1yvrQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2053165857==
Content-Type: multipart/alternative; boundary=f46d0418282ec9946304e36ee50f

--f46d0418282ec9946304e36ee50f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

HI Iam trying to install lttng-modules for kernel probing on CentOS 6.4
2.6.32-358.6.1.el6.x86_64
iam getting error while running make as follows.
/home/admin/lttng-modules-2.3.0-rc1/lttng-events.c:388: error: too many
arguments to function =E2tracepoint_probe_register=E2

I have already installed lttng-tools (lttng-tools-2.0.4-2.el6.x86_
64
) for user space probing

It seems that the lttng-modules are not compatible for above mentioned
centOS .
Can u please let me know which version or how i can install lttng-modules
for kernel probing for my
mentioned CentOS version


On Thu, Aug 8, 2013 at 5:02 PM, Suraj Bagad <surajbagad@gmail.com> wrote:

> HI Iam trying to install lttng-modules for kernel probing on CentOS 6.4
> 2.6.32-358.6.1.el6.x86_64
> iam getting error while running make as follows.
> /home/admin/lttng-modules-2.3.0-rc1/lttng-events.c:388: error: too many
> arguments to function =E2tracepoint_probe_register=E2
>
> I have already installed lttng-tools (lttng-tools-2.0.4-2.el6.x86_64
> ) for user space probing
>
> It seems that the lttng-modules are not compatible for above mentioned
> centOS .
> Can u please let me know which version or how i can install lttng-modules
> for kernel probing for my
> mentioned CentOS version
> --
> Thanks
> and Regards,
> Suraj Bagad
>



--=20
Thanks
and Regards

--f46d0418282ec9946304e36ee50f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>HI Iam trying to install lttng-modules for kernel pro=
bing on CentOS 6.4 2.6.32-358.6.1.el6.x86_64<br></div><div>iam getting erro=
r while running make as follows. <br>/home/admin/lttng-modules-2.3.0-rc1/lt=
tng-events.c:388: error: too many arguments to function =E2tracepoint_probe=
_register=E2<br>

<br></div>I have already installed lttng-tools (lttng-tools-2.0.4-2.el6.x86=
_<div dir=3D"ltr">64<br>) for user space probing<br clear=3D"all"><div><div=
><br></div><div>It seems that the lttng-modules are not compatible for abov=
e mentioned centOS .<br>

Can u please let me know which version or how i can install lttng-modules f=
or kernel probing for my <br></div><div>mentioned CentOS version</div></div=
></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">
On Thu, Aug 8, 2013 at 5:02 PM, Suraj Bagad <span dir=3D"ltr">&lt;<a href=
=3D"mailto:surajbagad@gmail.com" target=3D"_blank">surajbagad@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div dir=3D"ltr"><div>HI Iam trying to install lttng-modules for kernel pro=
bing on CentOS 6.4 2.6.32-358.6.1.el6.x86_64<br></div><div>iam getting erro=
r while running make as follows. <br>/home/admin/lttng-modules-2.3.0-rc1/lt=
tng-events.c:388: error: too many arguments to function =E2tracepoint_probe=
_register=E2<br>

<br></div>I have already installed lttng-tools (lttng-tools-2.0.4-2.el6.x86=
_64<br>) for user space probing<br clear=3D"all"><div><div><br></div><div>I=
t seems that the lttng-modules are not compatible for above mentioned centO=
S .<br>

Can u please let me know which version or how i can install lttng-modules f=
or kernel probing for my <br></div><div>mentioned CentOS version<span class=
=3D"HOEnZb"><font color=3D"#888888"><br></font></span></div><span class=3D"=
HOEnZb"><font color=3D"#888888"><div>
-- <br>Thanks <br>and Regards,<br></div><div>Suraj Bagad<br></div></font></=
span></div>
</div>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Thanks <br>and Regards
</div>

--f46d0418282ec9946304e36ee50f--


--===============2053165857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2053165857==--
