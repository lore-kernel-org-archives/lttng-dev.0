From: Amit Balboul <amit.balboul@shinesec.com>
Subject: Changes in the lttng-tools cause issues in build
Date: Mon, 4 Mar 2013 19:02:14 +0200
Message-ID: <CAHg4Oy-xKD6zHbQrATEQ9oQQoO-wUf7f-CriT0NbTr-CHGr=uA__25540.9911428162$1362416597$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494553163=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amit.balboul@shinesec.com>) id 1UCYmK-0003Bx-9i
	for lttng-dev@lists.lttng.org; Mon, 04 Mar 2013 12:02:20 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so4958202vea.30
	for <lttng-dev@lists.lttng.org>; Mon, 04 Mar 2013 09:02:14 -0800 (PST)
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

--===============0494553163==
Content-Type: multipart/alternative; boundary=bcaec54b45689518c704d71c517b

--bcaec54b45689518c704d71c517b
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I recently pulled the updated sources from the lttng-tools repository,
having the latest *commit e58727c84472f69d641d94efaf90e728cda84a6b.*
*
*
When I tried to re-build it I'm having some issues in compilation.
(I'm building for Android but those issues are not related to it).
Some I managed to workaroud, but some, like for example

ust-registry.h:70: error: field 'header_type' has incomplete type

are just an enigma. I assume this is not some configuration issue since
grep-ing ustctl_channel_header in the source doesn't result any useful
match (just some uses of it).

Am I missing something here?

Amit.

--bcaec54b45689518c704d71c517b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div style>I recently pulled the upd=
ated sources from the lttng-tools repository, having the latest=A0<b><font =
color=3D"#0000ff">commit e58727c84472f69d641d94efaf90e728cda84a6b.</font></=
b></div>
<div style><b><font color=3D"#0000ff"><br></font></b></div><div style>When =
I tried to re-build it I&#39;m having some issues in compilation.</div><div=
 style>(I&#39;m building for Android but those issues are not related to it=
).<br>
</div><div style>Some I managed to workaroud, but some, like for example</d=
iv><div style><br></div><div style><font face=3D"courier new, monospace">us=
t-registry.h:70: error: field &#39;header_type&#39; has incomplete type</fo=
nt><br>
</div><div style><br></div><div style>are just an enigma. I assume this is =
not some configuration issue since grep-ing=A0<font face=3D"courier new, mo=
nospace">ustctl_channel_header</font> in the source doesn&#39;t result any =
useful match (just some uses of it).</div>
<div style><br></div><div style>Am I missing something here?</div><div styl=
e><br></div><div style>Amit.</div><div style><br></div></div>

--bcaec54b45689518c704d71c517b--


--===============0494553163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0494553163==--
