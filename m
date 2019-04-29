From: Joe Sutker <jomasu22@gmail.com>
Subject: enable-event wildcards
Date: Mon, 29 Apr 2019 11:13:33 -0400
Message-ID: <CAHryLm77cSdg4WDwYrfsCr9fHYyRH5rrQKq7O=Roq3k14_aVjQ__34317.4269118876$1556552322$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6921609932724345804=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by lists.lttng.org (Postfix) with ESMTPS id 44t7Tk5Dg0z1L1p
 for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2019 11:13:46 -0400 (EDT)
Received: by mail-lf1-x131.google.com with SMTP id t11so8163736lfl.12
 for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2019 08:13:46 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6921609932724345804==
Content-Type: multipart/alternative; boundary="000000000000f7830a0587acba57"

--000000000000f7830a0587acba57
Content-Type: text/plain; charset="UTF-8"

Hello LTTng Devs,

When using `lttng enable-event -u`, putting a wildcard anywhere but the end
of the event name causes an error (Invalid event name). Is this intended
behavior? If so, the man pages should probably be changed.

Thanks,

Joe

--000000000000f7830a0587acba57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello LTTng Devs,<div><br></div><div>When using `lttng ena=
ble-event -u`, putting a wildcard anywhere but the end of the=C2=A0event na=
me causes an error (Invalid event name). Is this intended behavior? If so, =
the man pages should probably be changed.</div><div><br></div><div>Thanks,<=
/div><div><br></div><div>Joe</div></div>

--000000000000f7830a0587acba57--

--===============6921609932724345804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6921609932724345804==--
