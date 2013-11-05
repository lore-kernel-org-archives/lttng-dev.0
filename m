From: "=?UTF-8?Q?David_Lindstr=C3=B6m?=" <david.lindstrom@percepio.se>
Subject: Tagging traces with arbitrary data (as in custom
	metadata)
Date: Tue, 5 Nov 2013 15:15:14 +0100
Message-ID: <C62A2692A7474EDFAB0AD54DA97D77E8__21677.6966969066$1383660971$gmane$org@DVDMANDT5>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0153618935=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f53.google.com ([209.85.215.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.lindstrom@percepio.se>) id 1VdhPg-0007ev-17
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 09:15:25 -0500
Received: by mail-la0-f53.google.com with SMTP id eh20so4358657lab.12
	for <lttng-dev@lists.lttng.org>; Tue, 05 Nov 2013 06:15:17 -0800 (PST)
Received: from DVDMANDT5 (h185n9.malarenergi.ias.bredband.telia.com.
	[90.224.212.185])
	by mx.google.com with ESMTPSA id n15sm28137896laa.2.2013.11.05.06.15.16
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 05 Nov 2013 06:15:17 -0800 (PST)
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

This is a multi-part message in MIME format.

--===============0153618935==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0B87_01CEDA39.D44B9FC0"

This is a multi-part message in MIME format.

------=_NextPart_000_0B87_01CEDA39.D44B9FC0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I was wondering if there=E2=80=99s a way to tag a trace with some =
additional information. A general example would be to include a =
description of the current experiment. One way to do this currently =
would be to create a custom lttng-message application with some UST =
tracepoint and then just log that to a separate channel, but that would =
be pretty ugly. It would be much cleaner to insert extra fields into the =
metadata stream. Is something like that possible in current versions of =
LTTng and/or would it be possible to add it for a future version?

Mvh
David Lindstr=C3=B6m
------=_NextPart_000_0B87_01CEDA39.D44B9FC0
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD></HEAD>
<BODY dir=3Dltr>
<DIV dir=3Dltr>
<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: #000000">
<DIV>Hi, I was wondering if there=E2=80=99s a way to tag a trace with =
some additional=20
information. A general example would be to include a description of the =
current=20
experiment. One way to do this currently would be to create a custom=20
lttng-message application with some UST tracepoint and then just log =
that to a=20
separate channel, but that would be pretty ugly. It would be much =
cleaner to=20
insert extra fields into the metadata stream. Is something like that =
possible in=20
current versions of LTTng and/or would it be possible to add it for a =
future=20
version?</DIV>
<DIV>&nbsp;</DIV>
<DIV=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Calibri'; COLOR: =
#000000">Mvh<BR>David=20
Lindstr=C3=B6m</DIV></DIV></DIV></BODY></HTML>

------=_NextPart_000_0B87_01CEDA39.D44B9FC0--



--===============0153618935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0153618935==--
