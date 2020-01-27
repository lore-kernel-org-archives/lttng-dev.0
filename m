From: Anders Wallin <wallinux@gmail.com>
Subject: babeltrace 2.0.0 install docdata in the same directory
 as babeltrace 1.5.x
Date: Mon, 27 Jan 2020 15:59:27 +0100
Message-ID: <CAF2baFdnm07M=C93UErWsV+qbgGHsrEe8eXfWC9sWoQFw76tSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2302383447148323530=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 485tFS6J9pz1xGJ
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 09:59:39 -0500 (EST)
Received: by mail-oi1-x229.google.com with SMTP id i1so6884251oie.8
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 06:59:39 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2302383447148323530==
Content-Type: multipart/alternative; boundary="000000000000395700059d205b08"

--000000000000395700059d205b08
Content-Type: text/plain; charset="UTF-8"

Hi,

babeltrace 1.5 and babeltrace 2.0 both install the docDATA files in the
same directory, /usr/local/share/doc/babeltrace.
babeltrace 2.0 should install it into /usr/local/share/doc/babeltrace2

$ sudo make install-dist_docDATA
 /bin/mkdir -p '/usr/local/share/doc/babeltrace'
 /usr/bin/install -c -m 644 ChangeLog LICENSE mit-license.txt gpl-2.0.txt
lgpl-2.1.txt std-ext-lib.txt README.adoc CONTRIBUTING.adoc
'/usr/local/share/doc/babeltrace'

Best Regards
Anders Wallin

--000000000000395700059d205b08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>babeltrace 1.5 and babeltrace 2.0 both install =
the docDATA files in the same directory, /usr/local/share/doc/babeltrace.<b=
r>babeltrace 2.0 should install it into /usr/local/share/doc/babeltrace2<br=
><br><font face=3D"monospace">$ sudo make install-dist_docDATA<br>=C2=A0/bi=
n/mkdir -p &#39;/usr/local/share/doc/babeltrace&#39;<br>=C2=A0/usr/bin/inst=
all -c -m 644 ChangeLog LICENSE mit-license.txt gpl-2.0.txt lgpl-2.1.txt st=
d-ext-lib.txt README.adoc CONTRIBUTING.adoc &#39;/usr/local/share/doc/babel=
trace&#39;</font><br><br>Best Regards<br clear=3D"all"><div><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Anders Walli=
n</div></div></div>

--000000000000395700059d205b08--

--===============2302383447148323530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2302383447148323530==--
