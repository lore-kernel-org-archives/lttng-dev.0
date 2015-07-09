From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Enabling Syscalls LTTng v2.5.1
Date: Thu, 9 Jul 2015 10:36:57 -0400
Message-ID: <CA+jJMxs1+j+AAJyKCzKi71sXW4Bv73Zjj_FTfduLQL-LW5O+vg__31050.2282729887$1436452697$gmane$org@mail.gmail.com>
References: <DM2PR12MB03148D7374C0C505D2D8EAB19B900@DM2PR12MB0314.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971728951=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZDCwh-0004da-Jd
 for lttng-dev@lists.lttng.org; Thu, 09 Jul 2015 10:37:10 -0400
Received: by pdrg1 with SMTP id g1so34599631pdr.2
 for <lttng-dev@lists.lttng.org>; Thu, 09 Jul 2015 07:36:58 -0700 (PDT)
In-Reply-To: <DM2PR12MB03148D7374C0C505D2D8EAB19B900@DM2PR12MB0314.namprd12.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dilong Zheng <Dilong.Zheng@mitel.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1971728951==
Content-Type: multipart/alternative; boundary=e89a8f83abb9082bde051a72305a

--e89a8f83abb9082bde051a72305a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Jul 9, 2015 9:23 AM, "Dilong Zheng" <Dilong.Zheng@mitel.com> wrote:
>
> Hi Jeremie,
>
>
> I am attempting to enable syscalls by doing: lttng enable-event -a -k
--syscall but I am received a warning: "Warning: Kernel events already
enabled". From searching online, I read that the warning is just a UI issue
and doesn't actually

Can you provide a link to this?
Have you tried with the latest 2.5.x release?

Thanks,
J=C3=A9r=C3=A9mie

affect the functionality of LTTng; that the syscalls are actually being
enabled. However when viewing the kernel trace inside TraceCompass or
Tracealyzer I do barely ever see any system calls. The only syscalls that
appear if any are almost always "clone". I am currently using Fedora 22,
x86 architecture. Be great to get some insight regarding the warning and
what I could be doing better to see syscalls by enabling the event. Thanks
for your help.
>
>
> Dilong Zheng

--e89a8f83abb9082bde051a72305a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 9, 2015 9:23 AM, &quot;Dilong Zheng&quot; &lt;<a href=3D"mailto:Dilo=
ng.Zheng@mitel.com">Dilong.Zheng@mitel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Jeremie,<br>
&gt;<br>
&gt;<br>
&gt; I am attempting to enable syscalls by doing: lttng enable-event -a -k =
--syscall but I am received a warning: &quot;Warning: Kernel events already=
 enabled&quot;. From searching online, I read that the warning is just a UI=
 issue and doesn&#39;t actually</p>
<p dir=3D"ltr">Can you provide a link to this?<br>
Have you tried with the latest 2.5.x release?</p>
<p dir=3D"ltr">Thanks,<br>
J=C3=A9r=C3=A9mie</p>
<p dir=3D"ltr"> affect the functionality of LTTng; that the syscalls are ac=
tually being enabled. However when viewing the kernel trace inside TraceCom=
pass or Tracealyzer I do barely ever see any system calls. The only syscall=
s that appear if any are almost always &quot;clone&quot;. I am currently us=
ing Fedora 22, x86 architecture. Be great to get some insight regarding the=
 warning and what I could be doing better to see syscalls by enabling the e=
vent. Thanks for your help.<br>
&gt;<br>
&gt;<br>
&gt; Dilong Zheng<br>
</p>

--e89a8f83abb9082bde051a72305a--


--===============1971728951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1971728951==--
