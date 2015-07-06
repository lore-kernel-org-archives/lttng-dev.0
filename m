From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Lttng 2.6 relayd hanged
Date: Mon, 6 Jul 2015 11:07:27 -0400
Message-ID: <CA+jJMxu0+4THB9yUYdD3Jr01BF_PdQxvfQqqU8Lcb+zOc1GDsA__32023.4337625608$1436195332$gmane$org@mail.gmail.com>
References: <CA+=ghtPz_0VPxXH+nVBbsx_j4GVCd2U+Uxfep40bTCYud1otWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1187158924=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZC7zY-0007uJ-NU
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 11:07:40 -0400
Received: by pdbep18 with SMTP id ep18so107516593pdb.1
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jul 2015 08:07:27 -0700 (PDT)
In-Reply-To: <CA+=ghtPz_0VPxXH+nVBbsx_j4GVCd2U+Uxfep40bTCYud1otWw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kranthi kumar <kranthi.vskp@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1187158924==
Content-Type: multipart/alternative; boundary=047d7b10ccd38798b4051a3643f8

--047d7b10ccd38798b4051a3643f8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kranthi,

This looks similar to the bug reported by Aravind HT:
http://lists.lttng.org/pipermail/lttng-dev/2015-June/024643.html

Can you provide the commands used to setup the tracing? Are applications
crashing while tracing is active?

Regards,
J=C3=A9r=C3=A9mie

On Fri, Jul 3, 2015 at 5:32 PM, kranthi kumar <kranthi.vskp@gmail.com>
wrote:

> Dear Sir/Madam,
>
>
>
>   We are using Lttng 2.6
>
>   We are using Lttng for tracing across multiple systems.
>
>   We have a relayd running on a remote-host with several system(4) with 2
> active sessions each, generating traces towards this remote-host.
>
>   After running for 2-3 days, we observed that the tracing systems
> restarted and the sessions are killed.
>
>   However we observed sockets of relayd in ESTABLISHED state.  We also
> verified that ps command showing relayd active. From =E2=80=9Cnetstat =E2=
=80=93tanp=E2=80=9D we
> confirmed that relayd is listening on default port.
>
>
>
>  When we tried to establish new sessions and start streaming towards this
> relayd from our trace generating systems(all 4 one at a time) again, all
> the systems hanged indefinitely without showing any error messages.
>
>
>
> The only way to recover our trace generating systems is to restart the
> relayd on remote host.  If you restart the relayd and then create new
> sessions, streaming can be started again.
>
>
>
> Please let us know if this is a known issue.
>
>
>
>
>
> BR
>
>
>
> Kranthi.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b10ccd38798b4051a3643f8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Kranthi,<div><br></div><div>This looks similar to the b=
ug reported by Aravind HT:</div><div><a href=3D"http://lists.lttng.org/pipe=
rmail/lttng-dev/2015-June/024643.html">http://lists.lttng.org/pipermail/ltt=
ng-dev/2015-June/024643.html</a><br></div><div><br></div><div>Can you provi=
de the commands used to setup the tracing? Are applications crashing while =
tracing is active?</div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=
=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Fri, Jul 3, 2015 at 5:32 PM, kranthi kumar <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:kranthi.vskp@gmail.com" target=3D"_blank">kranthi.vskp@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">

<p class=3D"MsoNormal"><span lang=3D"EN-US">Dear
Sir/Madam,</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0 </span>We are usin=
g Lttng 2.6</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0 </span>We are usin=
g Lttng for tracing across multiple
systems.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0 </span>We have a r=
elayd running on a remote-host
with several system(4) with 2 active sessions each, generating traces towar=
ds
this remote-host.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0 </span>After runni=
ng for 2-3 days, we observed that
the tracing systems restarted and the sessions are killed.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0 </span>However we =
observed sockets of relayd in
ESTABLISHED state. <span>=C2=A0</span>We also verified that
ps command showing relayd active. From =E2=80=9Cnetstat =E2=80=93tanp=E2=80=
=9D we confirmed that relayd
is listening on default port.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US"><span>=C2=A0</span>When we trie=
d to establish new sessions and
start streaming towards this relayd from our trace generating systems(all 4=
 one
at a time) again, all the systems hanged indefinitely without showing any e=
rror
messages.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">The only
way to recover our trace generating systems is to restart the relayd on rem=
ote
host. <span>=C2=A0</span>If you restart the relayd and then
create new sessions, streaming can be started again.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Please let
us know if this is a known issue.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">BR</span></p><span class=3D"HOE=
nZb"><font color=3D"#888888">

<p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Kranthi. </span></p>

</font></span></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--047d7b10ccd38798b4051a3643f8--


--===============1187158924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1187158924==--
